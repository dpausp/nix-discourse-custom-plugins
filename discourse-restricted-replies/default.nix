{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "d56010db165a4716591a32e330d127a77de8318a";
    sha256 = "sha256-RJDkj29zqmKyA9tKUn+kFSN7jaKFuohokUopZ6RWfkg=====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}