{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "9385c3e6640057e0e9b50007116cb1482e138184";
    sha256 = "sha256-0xuqc7A3hdAmC+wfMAi4BaNsdTO3YG8kogWdqD+gtkk========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}