{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "792afcfca04ab1b47b92d572256d5b51fd76ce51";
    sha256 = "sha256-OYvBy1QMStakrgYgTArtg1/K9TwtQFGnF0wzmY5j45E====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}