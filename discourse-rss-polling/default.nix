{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "8cbb3e82b19fff7e6ee90be6bf76562cf49c6c13";
    sha256 = "sha256-rgF7fBb0b904MKMttWj6HJRMhn8Oa2WGF3fzd1RNKVo=";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}