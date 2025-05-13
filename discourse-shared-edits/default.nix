{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "8d8d23e0e61e5cff121ed677dc281f2ff62a4229";
    sha256 = "sha256-ZcFE1ChbKU024TUuWdi6+wj69+qMtjDzwX+VeVF2WYU==========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}