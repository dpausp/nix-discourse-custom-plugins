{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "f9a2b7d10ec81a5345f20b0d86dbe9474e1b1933";
    sha256 = "sha256-CIysQiLE2C+hUjj5aKpVS2afHRXBO25P/FwhVCLQONE=========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}