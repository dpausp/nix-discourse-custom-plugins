{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-user-card-badges";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-user-card-badges";
    rev = "3ae06195b95d0845163ef7cf01b09d1e3a73c460";
    sha256 = "1gfpqznf7pj4y0n1gzw5dfsidfnxqb6713djkk752lnk5kcqk6x8";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}