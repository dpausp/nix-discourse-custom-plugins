{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "69bbeae3a249dcd51dd8bcd04d459e6e6d70d5e9";
    sha256 = "sha256-HKfpMjRgw6rWSpnthsnC5gUlUK9qOlgpA6u0HNL3nqU=========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}