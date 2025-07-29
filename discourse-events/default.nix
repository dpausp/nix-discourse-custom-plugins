{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-events";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-events";
    rev = "b4e6760fb531174449a0f2220d096fc75c37dc6a";
    sha256 = "sha256-6Kq6qOuLiJ7vfvIL+7eDqUKOsIJ9T2rgraDZFRSXDMk======";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}