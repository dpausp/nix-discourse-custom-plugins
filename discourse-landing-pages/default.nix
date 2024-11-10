{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-landing-pages";
  bundlerEnvArgs.gemdir = ./.;
  src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-landing-pages";
    rev = "2f20e3b1a1f444b7f3e5e747322aecc449907fb0";
    sha256 = "sha256-IuCfBVDhIGTJJtJMPElcJnnBG7vH/HR0Xr+oFfRpt0s====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}