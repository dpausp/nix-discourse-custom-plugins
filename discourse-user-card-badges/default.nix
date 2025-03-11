{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "26f42d63c9b7513832ad7bb53eb12781bd0329a2";
    sha256 = "sha256-QwtslBN/UaDh7PfpRXof+o3Uqq+ABgXb9XLsdKKb74c=========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}