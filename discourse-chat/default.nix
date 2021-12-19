{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-chat";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-chat";
    rev = "f9dadd8c5a6c13537abd40ad087d64c0ab5afff7";
    sha256 = "01fjkhhl0rz30xr921w9l01kg3d28l2i998w60f0afgwf7225gy3";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}