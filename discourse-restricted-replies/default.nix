{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "bb103feb2c43d1dffea680bc4cfff19a2c4aa153";
    sha256 = "sha256-IbwgjNTFa3X0jfp96RJTHFIqYRJl/X7WaKOxsPy3QLk============";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}