{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "c8133a15bf8dcb96e6afaa418485a388f777a0c2";
    sha256 = "05x9smww1572y3a8gfyzivc0c411bm6v2g22jhs83yslx029iqfn";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}