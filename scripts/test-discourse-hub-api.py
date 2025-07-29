#!/usr/bin/env nix-shell
#! nix-shell -i python3 -p "python3.withPackages (ps: with ps; [ requests ])"
"""
Test script to verify Discourse Hub API connectivity and responses.
"""

import json
import sys
from pathlib import Path

import requests


def test_discourse_hub_api():
    """Test the Discourse Hub API endpoints."""
    
    # Read current version
    version_file = Path("discourse_version")
    if not version_file.exists():
        print("❌ discourse_version file not found")
        return False
    
    current_version = version_file.read_text().strip()
    print(f"Testing with current version: {current_version}")
    
    base_url = "https://api.discourse.org"
    headers = {
        'User-Agent': 'nix-discourse-updater-test/1.0',
        'Accept': 'application/json'
    }
    
    # Test version check endpoint
    print("\n🔍 Testing version check endpoint...")
    try:
        response = requests.get(
            f"{base_url}/api/version_check",
            params={'version': current_version, 'format': 'json'},
            headers=headers,
            timeout=10
        )
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Version check successful")
            print(f"   Response keys: {list(data.keys())}")
            if 'latest_version' in data:
                print(f"   Latest version: {data.get('latest_version')}")
            if 'behind_by_major' in data:
                print(f"   Behind by major: {data.get('behind_by_major')}")
            if 'behind_by_minor' in data:
                print(f"   Behind by minor: {data.get('behind_by_minor')}")
        else:
            print(f"❌ Version check failed: HTTP {response.status_code}")
            print(f"   Response: {response.text}")
            return False
            
    except requests.RequestException as e:
        print(f"❌ Version check request failed: {e}")
        return False
    
    # Test latest version endpoint
    print("\n🔍 Testing latest version endpoint...")
    try:
        response = requests.get(
            f"{base_url}/api/latest_version",
            headers=headers,
            timeout=10
        )
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Latest version check successful")
            print(f"   Response: {json.dumps(data, indent=2)}")
        else:
            print(f"⚠️  Latest version endpoint returned HTTP {response.status_code}")
            print(f"   This endpoint might not exist, which is okay")
            
    except requests.RequestException as e:
        print(f"⚠️  Latest version request failed: {e}")
        print("   This endpoint might not exist, which is okay")
    
    # Test security updates endpoint
    print("\n🔍 Testing security updates endpoint...")
    try:
        response = requests.get(
            f"{base_url}/api/security_updates",
            params={'version': current_version},
            headers=headers,
            timeout=10
        )
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Security updates check successful")
            print(f"   Response: {json.dumps(data, indent=2)}")
        else:
            print(f"⚠️  Security updates endpoint returned HTTP {response.status_code}")
            print(f"   This endpoint might not exist, which is okay")
            
    except requests.RequestException as e:
        print(f"⚠️  Security updates request failed: {e}")
        print("   This endpoint might not exist, which is okay")
    
    print("\n✅ API connectivity test completed!")
    return True


if __name__ == "__main__":
    success = test_discourse_hub_api()
    sys.exit(0 if success else 1)