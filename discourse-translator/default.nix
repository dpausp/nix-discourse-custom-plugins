{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-translator";
  bundlerEnvArgs.gemdir = ./.;
  src = fetchFromGitHub {
    owner = "LibreTranslate";
    repo = "discourse-translator";
    rev = "fdeb9a0de2b00d205959ba553df56c48d4cec73a";
    sha256 = "sha256-H50jFXiUj6bolR3HXK0BUjH9U06xAx/ZNewUG+SwroE=";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
