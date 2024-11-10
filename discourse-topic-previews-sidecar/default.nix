{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-topic-previews-sidecar";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-topic-previews-sidecar";
    rev = "296c7e0a9b70489f2b93b56dbafca118b2cf96b9";
    sha256 = "sha256-YKUx9qEyHfE4XYzRJUP7mBEcjA7wyWhk26O6gKsHyQE=====";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}