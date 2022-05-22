{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-chat";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-chat";
    rev = "2256d4a85f88355ad7774ff43343af788727be8d";
    hash = "sha256-BqqbdYy9OBGe9Dka13s11xZfSKDjnXatl7t3+nFVi6E";

  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
