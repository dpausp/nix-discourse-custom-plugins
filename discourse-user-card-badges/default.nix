{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "3c5c4d2a8f71a7789fdaff4fa8e84142f0143220";
    sha256 = "sha256-XzA9CJjsPn19xXVck+ShITmjb0BDT7+DmpXu+h2uAWg==========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}