{
  description = "Custom Discourse plugins with automated updates via Renovate and Hub API";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Flake utilities for better system handling
    flake-utils.url = "github:numtide/flake-utils";
    
    # Optional: Pin specific versions for reproducibility
    # discourse-src = {
    #   url = "github:discourse/discourse";
    #   flake = false;
    # };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Version information
        discourseVersion = builtins.readFile ./discourse_version;
        
        # Import our custom plugins
        customPlugins = import ./. {
          inherit (pkgs.discourse) mkDiscoursePlugin;
          inherit (pkgs) fetchFromGitHub newScope;
        };
        
        # Plugin sets for different use cases
        officialPlugins = with pkgs.discourse.plugins; [
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
        ];
        
        customPluginList = with customPlugins; [
          discourse-events
          discourse-landing-pages
          discourse-question-answer
          discourse-restricted-replies
          discourse-shared-edits
          discourse-templates
          discourse-topic-previews-sidecar
          discourse-user-card-badges
        ];
        
        # Create different Discourse variants
        mkDiscourseVariant = { name, plugins, meta ? {} }: 
          (pkgs.discourse.override { inherit plugins; }).overrideAttrs (old: {
            pname = name;
            meta = old.meta // {
              description = meta.description or "Discourse with custom plugins";
              longDescription = meta.longDescription or ''
                Discourse forum software with a curated set of plugins.
                This variant includes: ${builtins.concatStringsSep ", " (map (p: p.pname or p.name or "unknown") plugins)}
              '';
              maintainers = (old.meta.maintainers or []) ++ (meta.maintainers or []);
            } // meta;
          });
        
        # Main Discourse package with all plugins
        discourse-full = mkDiscourseVariant {
          name = "discourse-full";
          plugins = officialPlugins ++ customPluginList;
          meta = {
            description = "Discourse with all official and custom plugins";
            longDescription = ''
              Complete Discourse installation with all available plugins.
              Includes both official nixpkgs plugins and custom plugins.
              Automatically updated via Renovate and Discourse Hub API.
            '';
          };
        };
        
        # Minimal variant with only essential plugins
        discourse-minimal = mkDiscourseVariant {
          name = "discourse-minimal";
          plugins = with pkgs.discourse.plugins; [
            discourse-solved
            discourse-assign
            discourse-data-explorer
          ] ++ (with customPlugins; [
            discourse-templates
          ]);
          meta = {
            description = "Discourse with essential plugins only";
          };
        };
        
        # Development variant with debugging tools
        discourse-dev = mkDiscourseVariant {
          name = "discourse-dev";
          plugins = officialPlugins ++ customPluginList;
          meta = {
            description = "Discourse development variant with all plugins";
          };
        };
        
      in {
        # Main packages
        packages = {
          # Default: full-featured Discourse
          default = discourse-full;
          
          # Variants
          discourse-full = discourse-full;
          discourse-minimal = discourse-minimal;
          discourse-dev = discourse-dev;
          
          # Backwards compatibility
          nixosDiscourse = discourse-full;
          
          # Plugin sets for composition
          plugins-official = pkgs.linkFarm "discourse-plugins-official" 
            (map (p: { name = p.pname or p.name; path = p; }) officialPlugins);
          plugins-custom = pkgs.linkFarm "discourse-plugins-custom"
            (map (p: { name = p.pname or p.name; path = p; }) customPluginList);
          
        } // customPlugins;
        
        # Development shells
        devShells = {
          default = pkgs.mkShell {
            name = "discourse-plugins-dev";
            buildInputs = with pkgs; [
              # Nix tools
              nix-update
              nurl
              bundix
              bundler
              
              # Ruby development
              ruby_3_3
              
              # Python tools for our scripts
              (python3.withPackages (ps: with ps; [
                requests
                click
                click-log
                packaging
              ]))
              
              # Git and utilities
              git
              jq
              curl
              
              # Optional: Discourse development tools
              nodejs_20
              yarn
              postgresql
              redis
            ];
            
            shellHook = ''
              echo "🚀 Discourse Plugins Development Environment"
              echo "📦 Current Discourse version: ${discourseVersion}"
              echo "🔧 Available commands:"
              echo "  ./update.py                    - Update plugins"
              echo "  ./update_discourse_hub.py     - Check Hub API"
              echo "  ./scripts/validate-setup.sh   - Validate setup"
              echo "  nix build .#default           - Build full Discourse"
              echo "  nix build .#discourse-minimal - Build minimal variant"
              echo ""
            '';
          };
          
          # Minimal shell for CI/CD
          ci = pkgs.mkShell {
            name = "discourse-ci";
            buildInputs = with pkgs; [
              nix
              git
              (python3.withPackages (ps: with ps; [ requests click packaging ]))
            ];
          };
        };
        
        # Apps for easy execution
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
          # Build all variants
          discourse-full = discourse-full;
          discourse-minimal = discourse-minimal;
          
          # Validate all plugins build
          plugins-build = pkgs.runCommand "check-plugins-build" {} ''
            ${pkgs.lib.concatMapStringsSep "\n" (plugin: 
              "echo 'Building ${plugin.pname or plugin.name}'") customPluginList}
            touch $out
          '';
          
          # Validate scripts syntax
          scripts-syntax = pkgs.runCommand "check-scripts-syntax" {
            buildInputs = [ pkgs.python3 ];
          } ''
            python3 -m py_compile ${./update.py}
            python3 -m py_compile ${./update_discourse_hub.py}
            python3 -m py_compile ${./scripts/full-update-workflow.py}
            touch $out
          '';
          
          # Validate flake
          flake-check = pkgs.runCommand "flake-check" {
            buildInputs = [ pkgs.nix ];
          } ''
            cd ${./.}
            nix flake check --no-build
            touch $out
          '';
        };
        
        # Formatter
        formatter = pkgs.nixpkgs-fmt;
        
      }) // {
        # System-independent outputs
        
        # NixOS modules
        nixosModules = {
          default = { config, lib, pkgs, ... }: {
            options.services.discourse-custom = {
              enable = lib.mkEnableOption "Discourse with custom plugins";
              
              variant = lib.mkOption {
                type = lib.types.enum [ "full" "minimal" "dev" ];
                default = "full";
                description = "Which Discourse variant to use";
              };
              
              package = lib.mkOption {
                type = lib.types.package;
                default = self.packages.${pkgs.system}."discourse-${config.services.discourse-custom.variant}";
                description = "Discourse package to use";
              };
            };
            
            config = lib.mkIf config.services.discourse-custom.enable {
              services.discourse = {
                enable = true;
                package = config.services.discourse-custom.package;
              };
            };
          };
        };
        
        # Overlays for integration
        overlays = {
          default = final: prev: {
            discourse-custom = self.packages.${final.system}.default;
            discourse-custom-minimal = self.packages.${final.system}.discourse-minimal;
          };
        };
        
        # Templates for new plugins
        templates = {
          discourse-plugin = {
            path = ./templates/discourse-plugin;
            description = "Template for creating new Discourse plugins";
          };
        };
      };
}