{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "bb5c480b9701f7835ad233de2b2ca855504d9b4a";
    sha256 = "sha256-zUKZE8EbOlqtMFJ36Ckc+bb00X2k1cwe4cxNurnhZNs==========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}