{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-events";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-events";
    rev = "e27d4087bf3cfcdc51b8b84f59bb00e5b5ef7757";
    sha256 = "sha256-sAYkqyoukpLP8e1mkXEjHpFNJ6l0slnDusOlP+9zBOM==";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}