{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-templates";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-templates";
    rev = "15dbdbdc00181c305342b77d1a0a7ab7e8405222";
    sha256 = "sha256-8vTgGw2jQfpi9Z4HTWcDx7IXCwl++1xjMC1SzF7Y2Ow======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
