{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "af20b7ec3b023a89452e6eb57b556bb6183eb3ee";
    sha256 = "sha256-Q3cyhGxqWUC2IoLGuUFcw3ur8f48/1OtQHzqU+FGHaA===";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}