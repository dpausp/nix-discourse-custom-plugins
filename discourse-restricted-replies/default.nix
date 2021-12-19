{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "30ae82c92cdf8d79e1df72dc489abf9ceb14d431";
    sha256 = "0b5wy4mbmayh2kx8n6a9km46qy136h2bfkn1ay55izv1raq1vqy1";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}