{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "1ac3cc429e62e94b0776a8ce89cd81addac956ee";
    sha256 = "sha256-fDL86ZgFXuQY5m1P8/sR6sWoOok57M1MNkmRPLry0s0======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}