{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "bb654a96da7dcdb0af4fa1dcf21274f991bd8862";
    sha256 = "sha256-/OwPCFayAqiDgwwfgB8iI+GuJHsGphhWXneK1/2JPgM===";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}