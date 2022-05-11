{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-landing-pages";
  bundlerEnvArgs.gemdir = ./.;
  src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-landing-pages";
    rev = "7006f1d17d93bff371e0170fe1f2799fd2f2ea8d";
    sha256 = "1l5v6l798l1lfiz9cwgxg58hz50grj5wgmik2bk7ypr578lzacsb";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}