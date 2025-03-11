{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-templates";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-templates";
    rev = "2ee4963af359a4b60a077894356a3fbbaeb99397";
    sha256 = "sha256-hNM0x+szVT1i+Ys272qIDKwyn0XpWYVsC0XOzMwiF7w=====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
