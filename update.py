#!/usr/bin/env nix-shell
#! nix-shell -i python3 -p "python3.withPackages (ps: with ps; [ requests click click-log packaging ])" bundix bundler nix-update nurl
from __future__ import annotations

import ast
import logging
import os
import re
import stat
import subprocess
import tempfile
import textwrap
from functools import total_ordering
from packaging.version import Version
from pathlib import Path
from typing import Union, Iterable

import click
import click_log
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
        if version.startswith('v'):
            self.tag = version
            self.version = version.lstrip('v')
        else:
            self.tag = 'v' + version
            self.version = version

        self._version = Version(self.version)

    def __eq__(self, other: DiscourseVersion):
        """Versions are equal when their individual parts are."""
        return self._version == other._version

    def __gt__(self, other: DiscourseVersion):
        """Check if this version is greater than the other."""
        return self._version > other._version

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
    for platform in ['arm64-darwin-20', 'x86_64-darwin-18',
                     'x86_64-darwin-19', 'x86_64-darwin-20',
                     'x86_64-linux', 'aarch64-linux']:
        with open(rubyenv_dir / 'Gemfile.lock', 'r') as f:
            for line in f:
                if platform in line:
                    subprocess.check_output(
                        ['bundle', 'lock', '--remove-platform', platform], cwd=rubyenv_dir)
                    break


def _parse_compatibility_line(line):
    """Parse a compatibility line and return (operator, version, plugin_rev)"""
    line = line.strip()
    if not line:
        return None
    
    # Split on colon to separate version spec from plugin rev
    parts = line.split(':', 1)
    if len(parts) != 2:
        return None
    
    version_spec = parts[0].strip()
    plugin_rev = parts[1].strip()
    
    # Parse operator and version
    if version_spec.startswith('<='):
        operator = '<='
        version = version_spec[2:].strip()
    elif version_spec.startswith('<'):
        operator = '<'
        version = version_spec[1:].strip()
    else:
        # No explicit operator means implicit <=
        operator = '<='
        version = version_spec
    
    return (operator, DiscourseVersion(version), plugin_rev)


def _get_compatible_plugin_revision(repo, repo_latest_commit, discourse_version):
    """Get the compatible plugin revision based on discourse-compatibility file."""
    try:
        compatibility_spec = repo.get_file('.discourse-compatibility', repo_latest_commit)
        
        # Parse all compatibility lines
        parsed_versions = []
        for line in compatibility_spec.splitlines():
            parsed = _parse_compatibility_line(line)
            if parsed:
                parsed_versions.append(parsed)
        
        # Find compatible versions based on operators
        # The logic: if discourse_version matches the constraint, use the pinned plugin_rev
        # Otherwise, use latest commit
        compatible_versions = []
        for operator, version, plugin_rev in parsed_versions:
            if operator == '<=' and discourse_version <= version:
                compatible_versions.append((version, plugin_rev))
            elif operator == '<' and discourse_version < version:
                compatible_versions.append((version, plugin_rev))
        
        if compatible_versions == []:
            return repo_latest_commit
        else:
            # Sort by version and take the lowest compatible version (most restrictive constraint)
            compatible_versions.sort(key=lambda x: x[0], reverse=False)
            rev = compatible_versions[0][1]
            return rev
    except requests.exceptions.HTTPError:
        return repo_latest_commit


@click_log.simple_verbosity_option(logger)
@click.group()
def main():
    pass


@main.command()
@click.option('--version', default=lambda: Path("discourse_version").read_text().strip(), 
              help="Discourse version to get plugins for.")
@click.option('--pretend', is_flag=True, help="Only show what would be done.")
@click.option('--plugin-version-overrides', default="{}", 
              help="JSON string of plugin version overrides.")
@click.option('--check-hub-api', is_flag=True, help="Check Discourse Hub API before updating.")
@click.option('--output-report', type=click.Path(), help="Output update report to JSON file.")
def update_plugins(version, pretend, plugin_version_overrides, check_hub_api, output_report):
    """Update plugins to their latest revision."""
    from pprint import pprint
    import json
    
    # Check Hub API if requested
    if check_hub_api:
        try:
            result = subprocess.run(['./update_discourse_hub.py', 'check', '--check-only'], 
                                  capture_output=True, text=True)
            if result.returncode == 2:  # Critical updates available
                logger.warning("Critical updates detected by Hub API")
            elif result.returncode == 1:  # Updates available
                logger.info("Updates available according to Hub API")
        except Exception as e:
            logger.warning(f"Failed to check Hub API: {e}")

    pprint(plugin_version_overrides)

    overridden_plugin_versions = ast.literal_eval(plugin_version_overrides)
    
    # Initialize update report
    update_report = {
        'discourse_version': version,
        'timestamp': str(Path().cwd()),
        'plugins_updated': [],
        'plugins_skipped': [],
        'errors': []
    }
    plugins = [
        {"name": "discourse-events", "owner": "paviliondev"},
        {"name": "discourse-landing-pages", "owner": "paviliondev"},
        {"name": "discourse-post-voting"},
        {"name": "discourse-restricted-replies"},
        {"name": "discourse-rss-polling"},
        {"name": "discourse-shared-edits"},
        {"name": "discourse-templates"},
        {"name": "discourse-topic-previews-sidecar", "owner": "paviliondev"},
        {"name": "discourse-translator"},
        {"name": "discourse-user-card-badges"},
    ]

    if pretend:
        click.echo("Only showing what would be done (--pretend is set):")

    discourse_version = DiscourseVersion(version)

    for plugin in plugins:
        click.echo(f"Checking plugin {plugin}...")
        fetcher = plugin.get("fetcher") or "fetchFromGitHub"
        owner = plugin.get("owner") or "discourse"
        name = plugin.get("name")
        repo_name = plugin.get("repo_name") or name

        repo = DiscourseRepo(owner=owner, repo=repo_name)

        # implement the plugin pinning algorithm laid out here:
        # https://meta.discourse.org/t/pinning-plugin-and-theme-versions-for-older-discourse-installs/156971
        # this makes sure we don't upgrade plugins to revisions that
        # are incompatible with the packaged Discourse version
        rev = overridden_plugin_versions.get(name)

        if rev is None:
            repo_latest_commit = repo.latest_commit_sha
            rev = _get_compatible_plugin_revision(repo, repo_latest_commit, discourse_version)

        print(f"Using revision {rev} for plugin {name}")

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

            all_plugins_filename = Path(__file__).parent / "default.nix"
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
            click.echo(f"Plugin {name} is already at the latest revision")
            update_report['plugins_skipped'].append({
                'name': name,
                'reason': 'already_latest',
                'current_rev': prev_commit_sha
            })
            continue

        if not prev_commit_sha:
            click.echo(f"Plugin file {filename} invalid: commit id not found")
            continue

        if not prev_hash:
            click.echo(f"Plugin file {filename} invalid: hash not found")
            continue

        if fetcher == "fetchFromGitHub":
            url = f"https://github.com/{owner}/{repo_name}"
        else:
            raise NotImplementedError(f"Missing URL pattern for {fetcher}")

        new_hash = subprocess.check_output(
            [
                "nurl",
                "--fetcher", fetcher,
                "--hash",
                url,
                rev,
            ],
            text=True,
        ).strip("\n")

        update_prefix = "Would update" if pretend else "Update"
        click.echo(
            f"{update_prefix} {name}, {prev_commit_sha} -> {rev} in {filename}"
        )
        
        # Record update in report
        update_report['plugins_updated'].append({
            'name': name,
            'old_rev': prev_commit_sha,
            'new_rev': rev,
            'filename': str(filename),
            'pretend': pretend
        })

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
                line = ",".join(
                    filter(lambda x: "require_name" not in x, line.split(","))
                )
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

    # Save update report if requested
    if output_report:
        with open(output_report, 'w') as f:
            json.dump(update_report, f, indent=2)
        click.echo(f"Update report saved to {output_report}")


if __name__ == "__main__":
    main()
