# 🏗️ Simplified Discourse Architecture

## Overview

The repository has been restructured to use a **single unified Discourse package** that includes all plugins, making it simpler to manage and ensuring rebuilds happen when nixpkgs changes.

## New Structure

### Before (Complex)
```
├── flake.nix                    # Complex multi-package setup
├── custom-discourse-pkgs.nix    # Separate custom package definitions
├── default.nix                  # Plugin definitions
└── discourse-*/                 # Individual plugin directories
    └── default.nix
```

### After (Simplified)
```
├── flake.nix                    # Single package with all plugins
├── default.nix                  # Plugin definitions  
└── discourse-*/                 # Individual plugin directories
    └── default.nix
```

## Package Structure

### Single Unified Package
```nix
# flake.nix outputs
packages.${system} = {
  default = discourse;           # Main package with ALL plugins
  nixosDiscourse = discourse;    # Backwards compatibility alias
  plugins = customPlugins;       # Individual plugins for development
}
```

### Plugin Integration
```nix
discourse = pkgs.discourse.override {
  plugins = 
    # Official nixpkgs plugins
    (with pkgs.discourse.plugins; [ ... ]) 
    ++
    # Our custom plugins  
    (with customPlugins; [ ... ]);
};
```

## Benefits

### ✅ **Simplified Management**
- **One package** instead of multiple variants
- **Single build target**: `nix build .#default`
- **Cleaner flake structure** with fewer outputs

### ✅ **Automatic Rebuilds**
- **nixpkgs changes** trigger automatic rebuilds
- **Plugin updates** rebuild the entire package
- **Discourse core updates** rebuild everything together

### ✅ **Better CI/CD**
- **Faster builds** (single target)
- **Simpler testing** (one package to validate)
- **Clear dependencies** (everything in one place)

### ✅ **Renovate Integration**
- **nixpkgs updates** create MRs with rebuild triggers
- **Plugin updates** handled by custom scripts
- **Ruby dependencies** grouped and updated together

## Usage

### Building
```bash
# Build the main Discourse package (with all plugins)
nix build .#default

# Backwards compatibility
nix build .#nixosDiscourse

# Build individual plugins for development
nix build .#plugins.discourse-events
```

### Development
```bash
# Update all plugins
./update.py

# Check for Discourse core updates
./update_discourse_hub.py check

# Full automated workflow
./scripts/full-update-workflow.py --dry-run
```

### Integration in NixOS
```nix
# In your NixOS configuration
{
  services.discourse = {
    enable = true;
    package = inputs.discourse-plugins.packages.${system}.default;
    # All plugins are already included!
  };
}
```

## Renovate Behavior

### nixpkgs Updates
- **Minor/Patch**: Weekly updates on Monday
- **Major**: Manual review required
- **Triggers**: Full Discourse rebuild with all plugins

### Plugin Updates  
- **Handled by**: Custom update scripts
- **Frequency**: When Discourse version changes
- **Validation**: Compatibility checking via `.discourse-compatibility`

### Ruby Dependencies
- **Grouped updates**: All plugin Ruby deps together
- **Schedule**: Weekly on Monday
- **Automatic**: Gemfile.lock and gemset.nix updates

## Migration Notes

### Removed Files
- ❌ `custom-discourse-pkgs.nix` (consolidated into flake.nix)
- ❌ `bigDiscourse` vs `nixosDiscourse` distinction (single package now)

### Updated References
- ✅ CI/CD scripts use `.#default`
- ✅ Documentation updated
- ✅ Renovate config simplified

### Backwards Compatibility
- ✅ `nixosDiscourse` alias maintained
- ✅ Individual plugins still available for development
- ✅ Same plugin set included

## Future Enhancements

### Possible Additions
1. **Plugin subsets** for different use cases
2. **Development shells** with plugin development tools
3. **Testing frameworks** for plugin compatibility
4. **Automated plugin discovery** from GitHub

### Integration Opportunities
1. **NixOS modules** for easier deployment
2. **Hydra builds** for multiple architectures
3. **Binary cache** for faster deployments
4. **Plugin marketplace** integration

---

This simplified architecture makes the repository easier to understand, maintain, and integrate while preserving all existing functionality.