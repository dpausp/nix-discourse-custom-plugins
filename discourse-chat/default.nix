{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-chat";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-chat";
    rev = "ff1b065b7b0f8f2d47ecaa8c61bc3545c136467b";
    hash = "sha256-2jEgvDrN7Yrt4hjXCcX4XMiVyfYMkhTHeW3R9TjZjDE==";

  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
