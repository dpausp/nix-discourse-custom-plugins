{
  description = "Custom Discourse plugins for NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

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
              discourse-post-voting
              discourse-restricted-replies
              discourse-rss-polling
              discourse-shared-edits
              discourse-templates
              discourse-topic-previews-sidecar
              discourse-translator
              discourse-user-card-badges
            ]);
          };
          
          # Discourse with only our custom plugins
          discourseWithCustomPlugins = pkgs.discourse.override {
            plugins = (with customPlugins; [
              discourse-events
              discourse-landing-pages
              discourse-post-voting
              discourse-restricted-replies
              discourse-rss-polling
              discourse-shared-edits
              discourse-templates
              discourse-topic-previews-sidecar
              discourse-translator
              discourse-user-card-badges
            ]);
          };
          
        in {
          # Plain discourse from nixpkgs
          discourse = pkgs.discourse;
          
          # Discourse with only our custom plugins
          inherit discourseWithCustomPlugins;
          
          # Full Discourse with all official + custom plugins (default)
          discourseFull = discourse;
          default = discourse;
          
          # Alias for backwards compatibility
          nixosDiscourse = discourse;
        } // customPlugins);

      # Hydra CI jobs
      hydraJobs = forAllSystems (system: {
        # Plain discourse
        discourse = self.packages.${system}.discourse;
        
        # Discourse with only our custom plugins
        discourseWithCustomPlugins = self.packages.${system}.discourseWithCustomPlugins;
        
        # Full discourse with all plugins (default)
        discourseFull = self.packages.${system}.discourseFull;
        
        # Individual plugins for separate builds
        plugins = {
          discourse-events = self.packages.${system}.discourse-events;
          discourse-landing-pages = self.packages.${system}.discourse-landing-pages;
          discourse-post-voting = self.packages.${system}.discourse-post-voting;
          discourse-restricted-replies = self.packages.${system}.discourse-restricted-replies;
          discourse-rss-polling = self.packages.${system}.discourse-rss-polling;
          discourse-shared-edits = self.packages.${system}.discourse-shared-edits;
          discourse-templates = self.packages.${system}.discourse-templates;
          discourse-topic-previews-sidecar = self.packages.${system}.discourse-topic-previews-sidecar;
          discourse-translator = self.packages.${system}.discourse-translator;
          discourse-user-card-badges = self.packages.${system}.discourse-user-card-badges;
        };
      });
    };
}
