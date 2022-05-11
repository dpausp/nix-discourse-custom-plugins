{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "5ec39aa72acdaf237782b9a0a8ecc3f5188c8545";
    sha256 = "14qd9fjha4pk5fga9dwxz39r8i5r8bs2jhk8ag1b721yv0lc9l4k";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}