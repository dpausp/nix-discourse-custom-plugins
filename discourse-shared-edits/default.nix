{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "5e83a76c5e2fa83454895f2fe1e45c453d7f27f5";
    sha256 = "sha256-IpM5eVT3EQkM3zEPDvRwEJUpVbFdy1WZ+6YsmPwO/jo======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}