{
  inputs.nixpkgs.url = "github:flyingcircusio/nixpkgs/d431bef2ec3825d1f61674b0c9cdde5e29641cc2";

  outputs = { self, nixpkgs }:
    let
      # Supported systems
      systems = [ "x86_64-linux" ];
      # Helper to generate system-specific outputs
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system: 
        let
          pkgs = nixpkgs.legacyPackages.${system};
          custom-pkgs = import ./custom-discourse-pkgs.nix { inherit pkgs; };
        in {
          nixosDiscourse = custom-pkgs.nixosDiscourse;
          bigDiscourse = custom-pkgs.bigDiscourse;
        });
      
      # Default package for `nix build`
      defaultPackage = forAllSystems (system: self.packages.${system}.nixosDiscourse);
    };
}
