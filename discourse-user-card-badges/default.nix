{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "a435003ad4ed59bda2f2001073270bbf44fa9a9b";
    sha256 = "sha256-Kxmk7ilykHKhaAIbWxjQ9rUX4uL8eZJyhzdshc6/1BQ========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}