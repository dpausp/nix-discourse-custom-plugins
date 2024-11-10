{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-translator";
  bundlerEnvArgs.gemdir = ./.;
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-translator";
    rev = "5346b4bafba2c2fb817f030a473b7bbca97b909c";
    sha256 = "sha256-r5y/gZy4flKHrxP8n3LF/3uPOHO8poUVVu1Hd5Z2xcw===";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
