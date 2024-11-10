{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "0c6709d138ec6618536ff78fc637cd77e5126eac";
    sha256 = "sha256-ymS0MlkaR0S+416P19YIC6zg45roth5KHlVu6Tvs89M========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}