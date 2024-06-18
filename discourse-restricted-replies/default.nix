{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "6d8419d965eee659bde4595a1ada8c0161924aaa";
    sha256 = "sha256-fsYDgyTw8fM79oJtA6Uc0twnckkTeYgEFj6bFzLoedo=======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}