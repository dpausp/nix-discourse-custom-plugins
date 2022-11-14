{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "9e807100970ccab42ae7dbc8876a82b14c4b1fec";
    sha256 = "sha256-g5tIV3aiJeaC56wF8JL5LXbCDqzhB84P/t7bEN2eFv8===";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}