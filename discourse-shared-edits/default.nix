{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "30d118df4ea106cf89d21745ec36ab32b6a9cc18";
    sha256 = "sha256-MIFxG4PvnAnxHQAVwnbYPq8HfPWFHppsMmygjcIIJnk====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}