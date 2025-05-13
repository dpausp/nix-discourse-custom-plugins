{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-events";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-events";
    rev = "80f1a9ed14232599ff78cd57dc3ead3dd6f2aab6";
    sha256 = "sha256-vlsKvwjEMbgDJUPea1KSro/m8ebzDDjfRy5OHqHcGyE=====";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}