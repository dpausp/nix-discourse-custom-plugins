{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "43318340acdff5f7ecbaae9bbbf6a39175273adc";
    sha256 = "137galjsnb6wfkqfl2b5l50z7fc5a3bwm6y6n35r7l4a88p5vyz3";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}