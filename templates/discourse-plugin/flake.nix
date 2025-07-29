{
  description = "New Discourse Plugin Template";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.discourse.mkDiscoursePlugin {
          name = "discourse-new-plugin";
          src = pkgs.fetchFromGitHub {
            owner = "your-username";
            repo = "discourse-new-plugin";
            rev = "main";
            sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          };
          meta = with pkgs.lib; {
            description = "Description of your new plugin";
            homepage = "https://github.com/your-username/discourse-new-plugin";
            license = licenses.mit;
            maintainers = [ maintainers.your-name ];
          };
        };
      });
}