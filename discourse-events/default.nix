{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-events";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-events";
    rev = "83a6ee2c36a83bdb21fc58e3ec4bbd5fd5953e2e";
    sha256 = "sha256-QNcP32JYaon7phv3sFi1vlWZNwuL+LDzRWe6vi2FwTE=======";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}