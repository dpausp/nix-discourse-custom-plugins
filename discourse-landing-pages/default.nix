{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-landing-pages";
  bundlerEnvArgs.gemdir = ./.;
  src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-landing-pages";
    rev = "38a3813970b444431e614cf142f1db7dbc333be2";
    sha256 = "sha256-Qc1o3RsouGkPXu3mnf7OrODSodY7ex2xmsZJYG+qkvE======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}