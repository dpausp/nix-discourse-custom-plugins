{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-translator";
  bundlerEnvArgs.gemdir = ./.;
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-translator";
    rev = "7d411e458bdd449f8aead2bc07cedeb00b856798";
    sha256 = "sha256-M2nwqnTHp0zvca5EkzL5CX9dE9lzThtJrgsqYfAxt1c======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
