{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "27d67cd626eca89df710be81eca88ef377481b73";
    sha256 = "sha256-hUe1n0sQKIJHCAgsVUJ9y4/m5uNDlwhAcoiGK4/5jrs========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}