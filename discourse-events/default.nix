{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-events";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-events";
    rev = "b38f3258115110c07951f18e2c3562ac3e68a301";
    sha256 = "sha256-sbGTtZpAlvfRBRpKm5CFLGa5c2xvTLpUQFMj3Sr6CEg====";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}