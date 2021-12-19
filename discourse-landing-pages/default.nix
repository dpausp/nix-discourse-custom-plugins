{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-landing-pages";
  bundlerEnvArgs.gemdir = ./.;
  src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-landing-pages";
    rev = "86618c57a84010e955a29058309ef8ccef3efeeb";
    sha256 = "105shcf6kfyalimxrdwycskna2hkgd9hzy5ws6lh0cmipvdzbqxx";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}