{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "6b8c9b582713663f536d5d2442a8713995c22604";
    sha256 = "sha256-huCU0PbrXjIEARgeJdTr0Nu6e3Y21X02P5C1HiHbWtI==";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}