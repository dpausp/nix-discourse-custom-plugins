{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-topic-previews-sidecar";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-topic-previews-sidecar";
    rev = "44c73203244b703b53dbd85504908b9d3ebfbc1e";
    sha256 = "sha256-gxhoC6sO/7JRcZx25f0kyiGX8mJQwIi9ji/o7mFiP1o====";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}