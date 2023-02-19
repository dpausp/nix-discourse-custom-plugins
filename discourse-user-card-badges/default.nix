{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "a1cfb0e8623b4872ddc7852c4b03137624cca08b";
    sha256 = "sha256-YsaCHZMO4bi591H7FZG/k8CrrGVWBKoVU6FfXalRet4====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}