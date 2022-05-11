{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "42eb0b73dc9a696ffe1f8402ac49d3b1be0dcb5a";
    sha256 = "0nirapx34fjz7bm0g8hss1p8kkdvx9xbcz10ws0vcyn87phv6s0n";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}