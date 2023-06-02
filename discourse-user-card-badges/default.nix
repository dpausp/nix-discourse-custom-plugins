{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "e98c31fbb0127503aaab987d92f0416cc4294858";
    sha256 = "sha256-XYzhAFhNgrGnOcuJce9ZV1f0fgr8zQux1l5JOIoMuBM=====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}