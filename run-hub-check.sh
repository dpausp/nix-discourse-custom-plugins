#!/bin/bash
# Simple wrapper to run the Discourse Hub API check with proper dependencies

set -euo pipefail

echo "🔍 Running Discourse Hub API check..."

# Try different ways to get the dependencies
if command -v nix >/dev/null 2>&1; then
    echo "📦 Using Nix to provide dependencies..."
    
    # Try with flake first
    if [ -f flake.nix ]; then
        echo "Using flake environment..."
        nix develop --command python3 update_discourse_hub_fixed.py "$@"
    else
        # Fallback to direct nix-shell with channel
        echo "Using nix-shell with channel..."
        NIX_PATH=nixpkgs=channel:nixos-unstable nix-shell \
            -p 'python3.withPackages (ps: with ps; [ requests click click-log packaging ])' \
            --run "python3 update_discourse_hub_fixed.py $*"
    fi
elif command -v python3 >/dev/null 2>&1; then
    echo "📦 Using system Python (may need pip install requests click packaging)..."
    python3 update_discourse_hub_fixed.py "$@"
else
    echo "❌ Neither Nix nor Python3 found!"
    exit 1
fi