{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "031601c8540eb9145457464bb7ff9a1bdcc41672";
    sha256 = "sha256-pfw17pZTCAqCT3BLS5nhFu/gTPoha/QTJeG7spoYRjQ==";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}