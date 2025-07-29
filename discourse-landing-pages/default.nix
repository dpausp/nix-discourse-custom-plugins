{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-landing-pages";
  bundlerEnvArgs.gemdir = ./.;
  src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-landing-pages";
    rev = "f428098c718d3c392234a974359be6698046e8ea";
    sha256 = "sha256-ocjAFC6DeeSJaR8LMNhvcyFiF8rO4ZRbdGpeYY4Q5Yo=======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}