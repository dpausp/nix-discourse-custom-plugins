{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-chat";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-chat";
    rev = "c156512dae6cb06a65b3ef6314f7d47eb1617573";
    sha256 = "/5A1h299bX4eVBgR9CQj7P6bMhznl3u4XnK1dSFQVmU=";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
