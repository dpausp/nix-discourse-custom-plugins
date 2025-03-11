{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "ba30de9b11efe96f27c2e5f5effaadf1dde15072";
    sha256 = "sha256-g26pugtRdVCjIYh7JomXDjb68aEsf18OnfsKUyeK99k=========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}