{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "0f3bd114f6d79c90b55236e98900789ec432a55e";
    sha256 = "sha256-VypMv5YM08ByTu270VwCB0xm8h3XjsNXA1wf/ltN61E==";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}