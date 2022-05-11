{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-restricted-replies";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-restricted-replies";
    rev = "0199d5c8db79a727d6a57a17815d9010e3fb8048";
    sha256 = "047fcxzx71lh33m5dm9namqkij11kr7b1i467kdqgia8a5i59z3r";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}