{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "e272d971ecf687154e1ea89d0fa523b863c07c7c";
    sha256 = "sha256-EcvSCCQ8DMrXZ4Za55TkSauOwkyu88U5rBHY1emlnPo=====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}