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
          
          # Import our custom plugins
          customPlugins = import ./. {
            inherit (pkgs.discourse) mkDiscoursePlugin;
            inherit (pkgs) fetchFromGitHub newScope;
          };
          
          # Single unified Discourse package with all plugins
          discourse = pkgs.discourse.override {
            plugins = (with pkgs.discourse.plugins; [
              # Official nixpkgs plugins
              discourse-assign
              discourse-bbcode-color
              discourse-calendar
              discourse-chat-integration
              discourse-data-explorer
              discourse-docs
              discourse-github
              discourse-math
              discourse-openid-connect
              discourse-prometheus
              discourse-saved-searches
              discourse-solved
              discourse-voting
              discourse-yearly-review
            ]) ++ (with customPlugins; [
              # Our custom plugins
              discourse-events
              discourse-landing-pages
              discourse-question-answer
              discourse-restricted-replies
              discourse-shared-edits
              discourse-templates
              discourse-topic-previews-sidecar
              discourse-user-card-badges
            ]);
          };
          
        in {
          # Main package - single Discourse with all plugins
          default = discourse;
          
          # Alias for backwards compatibility
          nixosDiscourse = discourse;
        } // customPlugins);

      # Hydra CI jobs
      hydraJobs = forAllSystems (system: {
        discourse = self.packages.${system}.default;
      });
      
      # Default package for `nix build`
      defaultPackage = forAllSystems (system: self.packages.${system}.default);
    };
}
