{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "369f1a73a0bbacf12c941248c9d1d265adf6fdc9";
    sha256 = "sha256-9h+wO070+2O7hcwaaJYHNa9jDHGkk26I/ZGnYhNu2CY===";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}