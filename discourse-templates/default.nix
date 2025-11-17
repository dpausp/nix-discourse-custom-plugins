{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-templates";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-templates";
    rev = "b2916771b52804f96bb9e5a39572f116f7166b3a";
    sha256 = "sha256-A1wBFRVRKLrF+Dd7RapOFJkSveslSf82KoebFH3+Ovg========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
