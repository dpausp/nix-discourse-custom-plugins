{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "3267054820b70b6095f586db699a8c4d575d59f8";
    sha256 = "sha256-Oirw/dchezORTEMqZaaSseMpCuntgnGZbuDAmJk1A3U==========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}