{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-templates";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-templates";
    rev = "8aa1775a2eec5ca0a4e4ec6f6b4f456e8264d4ff";
    sha256 = "sha256-BMLHBv2vM9rFfE+88mUNYIAMSZKtcQ7ya+j6AZitNWw====";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
