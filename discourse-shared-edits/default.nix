{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-shared-edits";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-shared-edits";
    rev = "60977e100a0f6e278bb146a86352c721e52682f0";
    sha256 = "sha256-7tHbRolfvCzeSEMULkTq8C8OxMd+eqO/zFw0j7RE3Nw=======";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}