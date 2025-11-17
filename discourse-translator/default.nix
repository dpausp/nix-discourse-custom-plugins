{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-translator";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-translator";
    rev = "65d27c0b2c8327589bda132b8f7e1c4f1660dcd4";
    sha256 = "sha256-2bNTOX1MWjhrhrx6v6y+4g9jqRbPuuZLQ7onM4yo0vo==";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}