{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "14c6b2e36d1a3d534677463723ca5666eac2dd14";
    sha256 = "sha256-rVHoMVcMik/yM5ZAbNWUauByaSp4u+lnn0rrxDJRO1E=======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}