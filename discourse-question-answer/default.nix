{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "5c178de812a44b3781f3c8a3d612728c4f7e5016";
    sha256 = "sha256-vTHA0JdKOwoFdRDvxoQhe3STcwQZQyqptIq/kZnEvOw===";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}