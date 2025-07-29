{
  description = "Custom Discourse plugins with automated updates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
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
        # Packages
        packages = {
          default = discourse;
          nixosDiscourse = discourse; # Backwards compatibility
        } // customPlugins;

        # Development shell
        devShells.default = pkgs.mkShell {
          name = "discourse-plugins-dev";
          buildInputs = with pkgs; [
            # Nix tools
            nix-update nurl bundix bundler
            
            # Python tools for our scripts
            (python3.withPackages (ps: with ps; [
              requests click click-log packaging
            ]))
            
            # Utilities
            git jq curl
          ];
          
          shellHook = ''
            echo "🚀 Discourse Plugins Development Environment"
            echo "📦 Current version: $(cat discourse_version 2>/dev/null || echo 'unknown')"
            echo "🔧 Available commands:"
            echo "  ./update.py                    - Update plugins"
            echo "  ./update_discourse_hub.py     - Check Hub API"
            echo "  nix build .#default           - Build Discourse"
          '';
        };

        # Apps for easy script execution
        apps = {
          update-plugins = flake-utils.lib.mkApp {
            drv = pkgs.writeShellScriptBin "update-plugins" ''
              exec ${./update.py} "$@"
            '';
          };
          
          check-hub-api = flake-utils.lib.mkApp {
            drv = pkgs.writeShellScriptBin "check-hub-api" ''
              exec ${./update_discourse_hub.py} "$@"
            '';
          };
          
          full-workflow = flake-utils.lib.mkApp {
            drv = pkgs.writeShellScriptBin "full-workflow" ''
              exec ${./scripts/full-update-workflow.py} "$@"
            '';
          };
        };

        # Checks for CI
        checks = {
          discourse-build = discourse;
          
          scripts-syntax = pkgs.runCommand "check-scripts" {
            buildInputs = [ pkgs.python3 ];
          } ''
            python3 -m py_compile ${./update.py}
            python3 -m py_compile ${./update_discourse_hub.py}
            touch $out
          '';
        };

        # Formatter
        formatter = pkgs.nixpkgs-fmt;
      }) // {
        # Hydra CI jobs (system-independent)
        hydraJobs = flake-utils.lib.eachDefaultSystem (system: {
          discourse = self.packages.${system}.default;
        });
      };
}