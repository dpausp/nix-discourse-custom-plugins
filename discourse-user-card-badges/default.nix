{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "4ad3c62b35c84a1596e036c9e459f53769c5f2f7";
    sha256 = "sha256-4gy9LUSOeLWa2elGjZLZK21TSNMIV2N6PFm4Q4UPSCk============";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}