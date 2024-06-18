{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "42353e67483ad872cb106d154c0627db36f65849";
    sha256 = "sha256-89PfTGVB3/vLMR1+Tu4fWtwLbtX4B5HzFPaRHRdhh90=======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}