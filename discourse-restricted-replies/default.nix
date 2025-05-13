{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "9756e86c84926e888711282234cb567cebdc5b12";
    sha256 = "sha256-0BzWgWIgg6PmOz7AWDdrIK6wtGhyP4XGnKpi4myju6M==========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}