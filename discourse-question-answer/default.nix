{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "a143e16355e8fd061989bda149ebd31afafbd762";
    sha256 = "sha256-1DXsl0Wl7Omr4tLHei7QgtNhjFvv6+++POXYdCdFpFw====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}