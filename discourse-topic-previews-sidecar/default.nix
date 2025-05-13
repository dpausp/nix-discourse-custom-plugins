{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-topic-previews-sidecar";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-topic-previews-sidecar";
    rev = "2ab7f211c895bd391d4a0f8611355de261038a50";
    sha256 = "sha256-0peWsuquFAh+qsIB0HsLgOjWgPwDVb/6Y/RSru+4vsY=======";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}