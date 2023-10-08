{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "b8569928778f343c22ca7f0a5e696c07643c8227";
    sha256 = "sha256-1gr6iKI2NHd57UnAYhCL+YWYYNkTXSobTb5PdNbkcnc======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}