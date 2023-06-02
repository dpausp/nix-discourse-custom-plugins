{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "f0b247211c484ce650fd9d7706063de7d138acf7";
    sha256 = "sha256-sF73kEUwik+yqKtitSkf28j3jEzMwmCRbbO8w4H84C0=====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}