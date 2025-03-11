{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "17024d2d5a35172bd5f665d1f3aa0416db77e5ef";
    sha256 = "sha256-KuiiaAPfbSlQJnEA2XKTcV9yqKbRy8suQIMva6QvqXQ=========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}