{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "ad3692f998ee40933dd7c95227b24b3036d648a5";
    sha256 = "sha256-u5bAdonyPb1MIWamclpjFzNPE15VYmDj4AT5DEHtNGo=======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}