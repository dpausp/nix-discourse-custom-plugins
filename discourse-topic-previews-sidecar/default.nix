{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-topic-previews-sidecar";
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-topic-previews-sidecar";
    rev = "af62f5389dc705812b365341d502370926267dfa";
    sha256 = "sha256-TqGpJLvtAygqtlGCafbsvq9KDf6ft3beJcPVSCIIiEo==";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}