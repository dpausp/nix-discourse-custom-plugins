{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "0ce1c60d0857dd718229c1c5cb4b880141431823";
    sha256 = "1agyq5l8rh22dv83hy3q6rjy0cbizzzz3wvl8ai2m883pkb3pcgy";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}