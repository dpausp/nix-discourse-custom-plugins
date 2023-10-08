{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "6f98729adb660009737cfa631c5b601866ed3bf6";
    sha256 = "sha256-ItGWPR5f05+P+4lEtrr9XifwZTMof6wd9IqLt0AbQAE======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}