{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
name = "discourse-events";
bundlerEnvArgs.gemdir = ./.;
src = fetchFromGitHub {
    owner = "paviliondev";
    repo = "discourse-events";
    rev = "92e42603bcfce2210202941a2f9271c692b5666b";
    sha256 = "sha256-xCravCbf3p3HWmC9ysGxOW0hD0NsA1iVXiEU+1BWsF0===";
};
meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
};
}