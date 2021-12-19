{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-translator";
  src = fetchFromGitHub {
    owner = "LibreTranslate";
    repo = "discourse-translator";
    rev = "82ab052c8bc71ed33d4caf2b9ac87b3b101699b1";
    sha256 = "1d8b5f1crm7lddh6g0d2qxik70vk5alyzzkymvjn9sq9zf440v5w";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}