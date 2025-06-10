{
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

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
          custom-pkgs = import ./custom-discourse-pkgs.nix {
            inherit pkgs;
            plugins = self.packages.${system}.plugins;
          };
        in {
          nixosDiscourse = custom-pkgs.nixosDiscourse;
          bigDiscourse = custom-pkgs.bigDiscourse;
          
          plugins = let
            pluginPkgs = import ./. {
              inherit (pkgs.discourse) mkDiscoursePlugin;
              inherit (pkgs) fetchFromGitHub newScope;
            };
          in {
            discourse-events = pluginPkgs.discourse-events;
            discourse-landing-pages = pluginPkgs.discourse-landing-pages;
            discourse-question-answer = pluginPkgs.discourse-question-answer;
            discourse-restricted-replies = pluginPkgs.discourse-restricted-replies;
            discourse-shared-edits = pluginPkgs.discourse-shared-edits;
            discourse-templates = pluginPkgs.discourse-templates;
            discourse-topic-previews-sidecar = pluginPkgs.discourse-topic-previews-sidecar;
            discourse-user-card-badges = pluginPkgs.discourse-user-card-badges;
          };
        });
      
      # Default package for `nix build`
      defaultPackage = forAllSystems (system: self.packages.${system}.nixosDiscourse);
    };
}
