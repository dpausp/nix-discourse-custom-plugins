{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "f5b828806dad7cf9dab9c97487fa0e6969d35f5b";
    sha256 = "sha256-fnaoxBVlqTOxiYDIAkSZSFtduR9SHD7B4fBfU2YBQU0=";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}