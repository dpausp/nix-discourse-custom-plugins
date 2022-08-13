{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "62b06fa5b9497353b01de6d0eab3cec2f353d0bb";
    sha256 = "sha256-0a5exW5+AYZLFmqlDFtg6/JGAqbLA3Zwyo1+bmiD6w0==";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}