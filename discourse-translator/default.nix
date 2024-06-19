{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-translator";
  bundlerEnvArgs.gemdir = ./.;
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-translator";
    rev = "6750e10a6d9dfd3fc2c9a0cac5a83aca1a8ee401";
    sha256 = "sha256-/Yh/NvHxKi54pbOdh+k7QdBL7+Mp3N4WSS9VhpLGczo==";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
