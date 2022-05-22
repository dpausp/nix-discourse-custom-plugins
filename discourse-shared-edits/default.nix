{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "e3050e91bf20184e9945aa038ff88fad77a0a9e4";
    sha256 = "sha256-aaKkj4RUMgrH5F6tpzLDs4WGfHf0X1w6yoOyEfoGHCo=";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}