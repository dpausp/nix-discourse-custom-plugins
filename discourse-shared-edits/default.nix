{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "21a297abcd37119ae512ae644a9920ff96e1b523";
    sha256 = "0sdgkppv7zvsp0bqd6fg6dq5r8nyzdqrr5bkf0z4aysn70ap1r8y";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}