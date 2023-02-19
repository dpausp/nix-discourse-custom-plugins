{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "cbcd5d8c064414594e4e8a14974247b0b95e0b47";
    sha256 = "sha256-Rmd5LMzhnXnykxhvMipVnxnla97b0UNfl8I4aQUJDyE====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}