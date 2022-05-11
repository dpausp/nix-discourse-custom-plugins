{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-question-answer";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-question-answer";
    rev = "52c277cb4d13ca3ed3de8a17adb3b9db4f6e6c3f";
    sha256 = "0j566vl10hak4xf957n4a7n8m5jd9j520v0hfj2il9mxx1cxxsa2";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}