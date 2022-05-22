{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "1dd76282de875a4a09fa1ea4e2d7a337da97cd78";
    sha256 = "sha256-YBdmJm7GaKSbwPETRUOlD1NuyRoTW2wjzkk2D6kIdlU=";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}