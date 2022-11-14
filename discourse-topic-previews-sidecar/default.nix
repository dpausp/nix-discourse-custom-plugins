{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-topic-previews-sidecar";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-topic-previews-sidecar";
    rev = "0a896bce2d36cbc13ce327f56e29728643a38fea";
    sha256 = "sha256-BjaTeydfXTNKI04YaQQLEwkfxjN2hYdLKwzYQzea7UU==";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}