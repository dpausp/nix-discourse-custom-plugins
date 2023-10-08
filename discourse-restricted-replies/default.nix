{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "94d7f0205a7082c0fe190a5e43fc05fb68a33d5e";
    sha256 = "sha256-TC6qMGPHTIgQBukjXCZPoeaSn4H+Ed94DgwML6d9H8o======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}