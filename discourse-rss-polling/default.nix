{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "10e0dd1761a870390256401200e3864a4d0135ca";
    sha256 = "sha256-VNyCFMof936d3RCRuuu1Xab5SNQubjrs2kNkswOyXuE============";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}