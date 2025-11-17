{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "7a14a2fd0b06d08592b6403a92891a6d7cb5488e";
    sha256 = "sha256-ny5NpYzZh8RV6VH7H5nhQdCEFLNqgihgHSESXTHQV7A============";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}