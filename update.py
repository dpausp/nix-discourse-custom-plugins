#!/usr/bin/env nix-shell
#! nix-shell -i python3 -p bundix bundler nix-update nix-universal-prefetch python3 python3Packages.requests python3Packages.typer python3Packages.click-log prefetch-yarn-deps
from __future__ import annotations

import logging
import os
import re
import stat
import subprocess
import tempfile
import textwrap
from distutils.version import LooseVersion
from functools import total_ordering
from itertools import zip_longest
from pathlib import Path
from typing import Union, Iterable

import click_log
from typer import Typer, Option, echo
import requests

logger = logging.getLogger(__name__)


@total_ordering
class DiscourseVersion:
    """Represents a Discourse style version number and git tag.

    This takes either a tag or version string as input and
    extrapolates the other. Sorting is implemented to work as expected
    in regard to A.B.C.betaD version numbers - 2.0.0.beta1 is
    considered lower than 2.0.0.

    """

    tag: str = ""
    version: str = ""
    split_version: Iterable[Union[None, int, str]] = []

    def __init__(self, version: str):
        """Take either a tag or version number, calculate the other."""
        if version.startswith("v"):
            self.tag = version
            self.version = version.lstrip("v")
        else:
            self.tag = "v" + version
            self.version = version
        self.split_version = LooseVersion(self.version).version

    def __eq__(self, other: DiscourseVersion):
        """Versions are equal when their individual parts are."""
        return self.split_version == other.split_version

    def __gt__(self, other: DiscourseVersion):
        """Check if this version is greater than the other.

        Goes through the parts of the version numbers from most to
        least significant, only continuing on to the next if the
        numbers are equal and no decision can be made. If one version
        ends in 'betaX' and the other doesn't, all else being equal,
        the one without 'betaX' is considered greater, since it's the
        release version.

        """
        for (this_ver, other_ver) in zip_longest(
            self.split_version, other.split_version
        ):
            if this_ver == other_ver:
                continue
            if type(this_ver) is int and type(other_ver) is int:
                return this_ver > other_ver
            elif "beta" in [this_ver, other_ver]:
                # release version (None) is greater than beta
                return this_ver is None
        else:
            return False

    def __str__(self):
        return self.version


class DiscourseRepo:
    version_regex = re.compile(r"^v\d+\.\d+\.\d+(\.beta\d+)?$")
    _latest_commit_sha = None

    def __init__(self, owner: str = "discourse", repo: str = "discourse"):
        self.owner = owner
        self.repo = repo

    @property
    def versions(self) -> Iterable[str]:
        r = requests.get(
            f"https://api.github.com/repos/{self.owner}/{self.repo}/git/refs/tags"
        ).json()
        tags = [x["ref"].replace("refs/tags/", "") for x in r]

        # filter out versions not matching version_regex
        versions = filter(self.version_regex.match, tags)
        versions = [DiscourseVersion(x) for x in versions]
        versions.sort(reverse=True)
        return versions

    @property
    def latest_commit_sha(self) -> str:
        if self._latest_commit_sha is None:
            r = requests.get(
                f"https://api.github.com/repos/{self.owner}/{self.repo}/commits?per_page=1"
            )
            r.raise_for_status()
            self._latest_commit_sha = r.json()[0]["sha"]

        return self._latest_commit_sha

    def get_yarn_lock_hash(self, rev: str):
        yarn_lock_text = self.get_file("app/assets/javascripts/yarn.lock", rev)
        with tempfile.NamedTemporaryFile(mode="w") as lockFile:
            lockFile.write(yarn_lock_text)
            return (
                subprocess.check_output(["prefetch-yarn-deps", lockFile.name])
                .decode("utf-8")
                .strip()
            )

    def get_file(self, filepath, rev):
        """Return file contents at a given rev.

        :param str filepath: the path to the file, relative to the repo root
        :param str rev: the rev to fetch at :return:

        """
        r = requests.get(
            f"https://raw.githubusercontent.com/{self.owner}/{self.repo}/{rev}/{filepath}"
        )
        r.raise_for_status()
        return r.text


def _remove_platforms(rubyenv_dir: Path):
    for platform in [
        "arm64-darwin-20",
        "x86_64-darwin-18",
        "x86_64-darwin-19",
        "x86_64-darwin-20",
        "x86_64-linux",
        "aarch64-linux",
    ]:
        with open(rubyenv_dir / "Gemfile.lock", "r") as f:
            for line in f:
                if platform in line:
                    subprocess.check_output(
                        ["bundle", "lock", "--remove-platform", platform],
                        cwd=rubyenv_dir,
                    )
                    break


app = Typer()


@click_log.simple_verbosity_option(logger)
@app.callback()
def main():
    pass


@app.command()
def update_plugins(
    version: str = Option(
        Path("discourse_version").read_text().strip(),
        help="Discourse version to get plugins for.",
    ),
    pretend: bool = Option(
        False,
        help="Only show what would be done.",
    ),
):
    """Update plugins to their latest revision."""
    plugins = [
        {"name": "discourse-chat"},
        {"name": "discourse-question-answer"},
        {"name": "discourse-restricted-replies"},
        {"name": "discourse-rss-polling"},
        {"name": "discourse-shared-edits"},
        {"name": "discourse-topic-previews-sidecar", "owner": "paviliondev"},
        {"name": "discourse-landing-pages", "owner": "paviliondev"},
        {"name": "discourse-user-card-badges"},
        {"name": "discourse-translator", "owner": "LibreTranslate"},
    ]

    if pretend:
        echo("Only showing what would be done (--pretend is set):")

    for plugin in plugins:
        fetcher = plugin.get("fetcher") or "fetchFromGitHub"
        owner = plugin.get("owner") or "discourse"
        name = plugin.get("name")
        repo_name = plugin.get("repo_name") or name

        repo = DiscourseRepo(owner=owner, repo=repo_name)

        # implement the plugin pinning algorithm laid out here:
        # https://meta.discourse.org/t/pinning-plugin-and-theme-versions-for-older-discourse-installs/156971
        # this makes sure we don't upgrade plugins to revisions that
        # are incompatible with the packaged Discourse version
        try:
            compatibility_spec = repo.get_file(
                ".discourse-compatibility", repo.latest_commit_sha
            )
            versions = [
                (
                    DiscourseVersion(discourse_version_str),
                    plugin_rev.strip(" "),
                )
                for [discourse_version_str, plugin_rev] in [
                    line.split(":") for line in compatibility_spec.splitlines()
                ]
            ]
            discourse_version = DiscourseVersion(version)
            versions = list(
                filter(lambda ver: ver[0] >= discourse_version, versions)
            )
            if not versions:
                rev = repo.latest_commit_sha
            else:
                rev = versions[0][1]
        except requests.exceptions.HTTPError:
            rev = repo.latest_commit_sha

        filename = Path(__file__).parent / name / "default.nix"

        if not filename.exists() and not pretend:
            filename.parent.mkdir()

            has_ruby_deps = False
            for line in repo.get_file("plugin.rb", rev).splitlines():
                if "gem " in line:
                    has_ruby_deps = True
                    break

            with open(filename, "w") as f:
                f.write(
                    textwrap.dedent(
                        f"""
                            {{ lib, mkDiscoursePlugin, fetchFromGitHub }}:

                            mkDiscoursePlugin {{
                            name = "{name}";"""[
                            1:
                        ]
                        + (
                            """
                            bundlerEnvArgs.gemdir = ./.;"""
                            if has_ruby_deps
                            else ""
                        )
                        + f"""
                            src = {fetcher} {{
                                owner = "{owner}";
                                repo = "{repo_name}";
                                rev = "replace-with-git-rev";
                                sha256 = "replace-with-sha256";
                            }};
                            meta = with lib; {{
                                homepage = "";
                                maintainers = with maintainers; [ ];
                                license = licenses.mit; # change to the correct license!
                                description = "";
                            }};
                            }}"""
                    )
                )

            all_plugins_filename = (
                Path(__file__).parent / "plugins" / "default.nix"
            )
            with open(all_plugins_filename, "r+") as f:
                content = f.read()
                pos = -1
                while content[pos] != "}":
                    pos -= 1
                content = (
                    content[:pos]
                    + f"  {name} = callPackage ./{name} {{}};"
                    + os.linesep
                    + content[pos:]
                )
                f.seek(0)
                f.write(content)
                f.truncate()

        prev_commit_sha = None
        prev_hash = None
        with open(filename, "r") as f:
            for line in f.readlines():
                if line.strip().startswith("rev ="):
                    prev_commit_sha = line.split("=")[1].strip('"; \n')
                if line.strip().startswith(("sha256 =", "hash =")):
                    prev_hash = line.split("=")[1].strip('"; \n')

        if prev_commit_sha == rev:
            echo(f"Plugin {name} is already at the latest revision")
            continue

        if not prev_commit_sha:
            echo(f"Plugin file {filename} invalid: commit id not found")
            continue

        if not prev_hash:
            echo(f"Plugin file {filename} invalid: hash not found")
            continue

        new_hash = subprocess.check_output(
            [
                "nix-universal-prefetch",
                fetcher,
                "--owner",
                owner,
                "--repo",
                repo_name,
                "--rev",
                rev,
            ],
            text=True,
        ).strip("\n")

        update_prefix = "Would update" if pretend else "Update"
        echo(
            f"{update_prefix} {name}, {prev_commit_sha} -> {rev} in {filename}"
        )

        if pretend:
            continue

        with open(filename, "r+") as f:
            content = f.read()
            content = content.replace(prev_commit_sha, rev)
            content = content.replace(prev_hash, new_hash)
            f.seek(0)
            f.write(content)
            f.truncate()

        rubyenv_dir = Path(filename).parent
        gemfile = rubyenv_dir / "Gemfile"
        version_file_regex = re.compile(
            r'.*File\.expand_path\("\.\./(.*)", __FILE__\)'
        )
        gemfile_text = ""
        for line in repo.get_file("plugin.rb", rev).splitlines():
            if "gem " in line:
                gemfile_text = gemfile_text + line + os.linesep

                version_file_match = version_file_regex.match(line)
                if version_file_match is not None:
                    filename = version_file_match.groups()[0]
                    content = repo.get_file(filename, rev)
                    with open(rubyenv_dir / filename, "w") as f:
                        f.write(content)

        if len(gemfile_text) > 0:
            if os.path.isfile(gemfile):
                os.remove(gemfile)

            subprocess.check_output(["bundle", "init"], cwd=rubyenv_dir)
            os.chmod(
                gemfile,
                stat.S_IREAD | stat.S_IWRITE | stat.S_IRGRP | stat.S_IROTH,
            )

            with open(gemfile, "a") as f:
                f.write(gemfile_text)

            subprocess.check_output(
                ["bundle", "lock", "--add-platform", "ruby"], cwd=rubyenv_dir
            )
            subprocess.check_output(
                ["bundle", "lock", "--update"], cwd=rubyenv_dir
            )
            _remove_platforms(rubyenv_dir)
            subprocess.check_output(["bundix"], cwd=rubyenv_dir)


if __name__ == "__main__":
    app()
