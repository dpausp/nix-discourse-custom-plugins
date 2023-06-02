{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "f1e37e49dfdf550a3fd5237ba71f6375d0d3e0ea";
    sha256 = "sha256-bZp4IWQHzMRk8oXU7jjY5sQHrqjxsc6KHl0TZoeQ7rM=====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}