{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "da698e662a81f327247a904760eb84dd4ade7f9d";
    sha256 = "sha256-1ySGTj0+Hnf5SOyktKFzZkEVb9jMd8g7rtNpysDHfy8==";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}