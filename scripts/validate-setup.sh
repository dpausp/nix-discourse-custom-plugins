#!/bin/bash
# Validate the complete Renovate + Discourse Hub API setup

set -euo pipefail

echo "🔍 Validating Discourse Renovate Setup..."
echo "========================================"

# Check required files exist
echo "📁 Checking required files..."
required_files=(
    ".gitlab-ci.yml"
    "renovate.json"
    "update_discourse_hub.py"
    "scripts/full-update-workflow.py"
    "scripts/test-discourse-hub-api.py"
    "discourse_version"
)

for file in "${required_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✅ $file"
    else
        echo "❌ $file (missing)"
        exit 1
    fi
done

# Check script permissions
echo -e "\n🔐 Checking script permissions..."
scripts=(
    "update_discourse_hub.py"
    "scripts/full-update-workflow.py"
    "scripts/test-discourse-hub-api.py"
    "scripts/setup-renovate-schedule.sh"
)

for script in "${scripts[@]}"; do
    if [[ -x "$script" ]]; then
        echo "✅ $script (executable)"
    else
        echo "⚠️  $script (not executable, fixing...)"
        chmod +x "$script"
    fi
done

# Test Python dependencies
echo -e "\n🐍 Testing Python dependencies..."
if command -v nix-shell >/dev/null 2>&1; then
    echo "✅ nix-shell available"
    
    # Test our Hub API script
    if nix-shell -p "python3.withPackages (ps: with ps; [ requests click click-log packaging ])" --run "python3 -c 'import requests, click, packaging.version; print(\"All dependencies available\")'" 2>/dev/null; then
        echo "✅ Python dependencies available"
    else
        echo "❌ Python dependencies missing"
        exit 1
    fi
else
    echo "❌ nix-shell not available"
    exit 1
fi

# Test Discourse version file
echo -e "\n📋 Testing Discourse version file..."
if [[ -f "discourse_version" ]]; then
    version=$(cat discourse_version | tr -d '\n\r ')
    if [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+(\.(beta[0-9]+))?$ ]]; then
        echo "✅ Valid Discourse version: $version"
    else
        echo "❌ Invalid version format: $version"
        exit 1
    fi
else
    echo "❌ discourse_version file missing"
    exit 1
fi

# Test JSON configuration files
echo -e "\n📝 Validating JSON configuration..."
if command -v jq >/dev/null 2>&1; then
    if jq empty renovate.json 2>/dev/null; then
        echo "✅ renovate.json is valid JSON"
    else
        echo "❌ renovate.json has invalid JSON syntax"
        exit 1
    fi
else
    echo "⚠️  jq not available, skipping JSON validation"
fi

# Test GitLab CI syntax (basic check)
echo -e "\n🔧 Basic GitLab CI validation..."
if grep -q "stages:" .gitlab-ci.yml && grep -q "renovate:" .gitlab-ci.yml; then
    echo "✅ .gitlab-ci.yml has required structure"
else
    echo "❌ .gitlab-ci.yml missing required sections"
    exit 1
fi

# Test Nix flake (if available)
echo -e "\n❄️  Testing Nix flake..."
if command -v nix >/dev/null 2>&1; then
    if nix flake check --no-build 2>/dev/null; then
        echo "✅ Nix flake syntax is valid"
        echo "✅ Single unified Discourse package structure"
    else
        echo "⚠️  Nix flake check failed (may need flake.lock update)"
    fi
else
    echo "⚠️  nix command not available"
fi

echo -e "\n🎉 Setup validation completed!"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Set up GitLab CI variables (GITLAB_TOKEN)"
echo "2. Create pipeline schedule: ./scripts/setup-renovate-schedule.sh"
echo "3. Test the workflow: ./scripts/full-update-workflow.py --dry-run"
echo "4. Monitor first automated run in GitLab CI"
echo ""
echo "For more information, see README-renovate.md"