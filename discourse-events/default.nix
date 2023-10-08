{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-events";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-events";
    rev = "c18cbeeac5a3f7ebf540cd6fc7edef48db889edd";
    sha256 = "sha256-1pURGDzVY1RdbJwc2dCETr/ylOoeqwArIBFLvI1Y4gs=";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}