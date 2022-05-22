{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "7a3610eebe76cf96be000f0be46a32ddd7a27c3a";
    sha256 = "sha256-eyMFIjGAmgk8XQqgiXZIFxbp2nCo+8znldpbzxUdYFs=";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}