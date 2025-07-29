#!/usr/bin/env nix-shell
#! nix-shell -i python3 -p "python3.withPackages (ps: with ps; [ requests click click-log packaging ])"
"""
Enhanced Discourse update script that integrates with Discourse Hub API.

This script checks the Discourse Hub API for version updates and security advisories,
then coordinates with the existing update.py script for actual updates.
"""

from __future__ import annotations

import json
import logging
import sys
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import click
import click_log
import requests
from packaging.version import Version

logger = logging.getLogger(__name__)


class DiscourseHubAPI:
    """Interface to the Discourse Hub API for version checking and security updates."""
    
    BASE_URL = "https://api.discourse.org"
    
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'nix-discourse-updater/1.0',
            'Accept': 'application/json'
        })
    
    def check_version(self, current_version: str) -> Dict:
        """
        Check current version against Discourse Hub API.
        
        Returns information about available updates, security fixes, etc.
        """
        try:
            response = self.session.get(
                f"{self.BASE_URL}/api/version_check",
                params={
                    'version': current_version,
                    'format': 'json'
                },
                timeout=30
            )
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            logger.error(f"Failed to check version with Discourse Hub API: {e}")
            return {}
    
    def get_latest_versions(self) -> Dict:
        """Get information about latest stable and beta versions."""
        try:
            response = self.session.get(
                f"{self.BASE_URL}/api/latest_version",
                timeout=30
            )
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            logger.error(f"Failed to get latest versions: {e}")
            return {}
    
    def check_security_updates(self, current_version: str) -> List[Dict]:
        """Check for security updates affecting the current version."""
        try:
            response = self.session.get(
                f"{self.BASE_URL}/api/security_updates",
                params={'version': current_version},
                timeout=30
            )
            response.raise_for_status()
            return response.json().get('security_updates', [])
        except requests.RequestException as e:
            logger.error(f"Failed to check security updates: {e}")
            return []


class DiscourseVersionManager:
    """Manages Discourse version updates with Hub API integration."""
    
    def __init__(self, version_file: Path = Path("discourse_version")):
        self.version_file = version_file
        self.hub_api = DiscourseHubAPI()
        self.current_version = self._read_current_version()
    
    def _read_current_version(self) -> str:
        """Read current version from discourse_version file."""
        if not self.version_file.exists():
            raise FileNotFoundError(f"Version file {self.version_file} not found")
        
        return self.version_file.read_text().strip()
    
    def _write_version(self, version: str) -> None:
        """Write new version to discourse_version file."""
        self.version_file.write_text(f"{version}\n")
        logger.info(f"Updated version file to {version}")
    
    def check_for_updates(self) -> Dict:
        """
        Check for available updates using Discourse Hub API.
        
        Returns a comprehensive update report.
        """
        logger.info(f"Checking for updates from current version: {self.current_version}")
        
        # Get version check results
        version_check = self.hub_api.check_version(self.current_version)
        latest_versions = self.hub_api.get_latest_versions()
        security_updates = self.hub_api.check_security_updates(self.current_version)
        
        # Analyze results
        report = {
            'current_version': self.current_version,
            'timestamp': str(Path().cwd()),
            'hub_api_response': version_check,
            'latest_versions': latest_versions,
            'security_updates': security_updates,
            'recommendations': self._analyze_updates(version_check, latest_versions, security_updates)
        }
        
        return report
    
    def _analyze_updates(self, version_check: Dict, latest_versions: Dict, security_updates: List[Dict]) -> Dict:
        """Analyze update information and provide recommendations."""
        recommendations = {
            'should_update': False,
            'update_priority': 'none',  # none, low, medium, high, critical
            'recommended_version': self.current_version,
            'reasons': []
        }
        
        current_ver = Version(self.current_version)
        
        # Check for security updates
        if security_updates:
            recommendations['should_update'] = True
            recommendations['update_priority'] = 'critical'
            recommendations['reasons'].append('Security updates available')
        
        # Check latest stable version
        if latest_versions.get('stable'):
            stable_ver = Version(latest_versions['stable'])
            if stable_ver > current_ver:
                recommendations['should_update'] = True
                recommendations['recommended_version'] = latest_versions['stable']
                if recommendations['update_priority'] == 'none':
                    recommendations['update_priority'] = 'medium'
                recommendations['reasons'].append(f'Newer stable version available: {latest_versions["stable"]}')
        
        # Check if current version is outdated based on Hub API response
        if version_check.get('behind_by_major', 0) > 0:
            recommendations['update_priority'] = 'high'
            recommendations['reasons'].append('Major version behind')
        elif version_check.get('behind_by_minor', 0) > 0:
            if recommendations['update_priority'] in ['none', 'low']:
                recommendations['update_priority'] = 'medium'
            recommendations['reasons'].append('Minor version behind')
        
        return recommendations
    
    def update_to_version(self, target_version: str, dry_run: bool = False) -> bool:
        """Update to a specific version."""
        if dry_run:
            logger.info(f"DRY RUN: Would update from {self.current_version} to {target_version}")
            return True
        
        try:
            # Validate version format
            Version(target_version)
            
            # Write new version
            self._write_version(target_version)
            self.current_version = target_version
            
            logger.info(f"Successfully updated to version {target_version}")
            return True
            
        except Exception as e:
            logger.error(f"Failed to update to version {target_version}: {e}")
            return False


@click.group()
@click_log.simple_verbosity_option(logger)
def cli():
    """Discourse Hub API integration for automated updates."""
    pass


@cli.command()
@click.option('--output', '-o', type=click.Path(), help='Output file for update report (JSON)')
@click.option('--check-only', is_flag=True, help='Only check for updates, do not apply them')
def check(output: Optional[str], check_only: bool):
    """Check for Discourse updates using Hub API."""
    manager = DiscourseVersionManager()
    
    try:
        report = manager.check_for_updates()
        
        # Display results
        recommendations = report['recommendations']
        
        click.echo(f"Current version: {report['current_version']}")
        click.echo(f"Should update: {recommendations['should_update']}")
        click.echo(f"Priority: {recommendations['update_priority']}")
        
        if recommendations['reasons']:
            click.echo("Reasons:")
            for reason in recommendations['reasons']:
                click.echo(f"  - {reason}")
        
        if recommendations['should_update'] and not check_only:
            target_version = recommendations['recommended_version']
            if target_version != report['current_version']:
                click.echo(f"\nUpdating to {target_version}...")
                success = manager.update_to_version(target_version)
                if success:
                    click.echo("✅ Version updated successfully!")
                    click.echo("Run './update.py' to update plugins for the new version.")
                else:
                    click.echo("❌ Failed to update version")
                    sys.exit(1)
        
        # Save report if requested
        if output:
            with open(output, 'w') as f:
                json.dump(report, f, indent=2)
            click.echo(f"Report saved to {output}")
        
        # Exit with appropriate code for CI/CD
        if recommendations['update_priority'] in ['high', 'critical']:
            sys.exit(2)  # Updates available
        elif recommendations['should_update']:
            sys.exit(1)  # Updates available but lower priority
        else:
            sys.exit(0)  # No updates needed
            
    except Exception as e:
        logger.error(f"Failed to check for updates: {e}")
        sys.exit(3)


@cli.command()
@click.argument('version')
@click.option('--dry-run', is_flag=True, help='Show what would be done without making changes')
def update(version: str, dry_run: bool):
    """Update to a specific Discourse version."""
    manager = DiscourseVersionManager()
    
    success = manager.update_to_version(version, dry_run=dry_run)
    
    if success and not dry_run:
        click.echo(f"✅ Updated to version {version}")
        click.echo("Run './update.py' to update plugins for the new version.")
    elif success and dry_run:
        click.echo(f"✅ Would update to version {version}")
    else:
        click.echo(f"❌ Failed to update to version {version}")
        sys.exit(1)


@cli.command()
def security():
    """Check specifically for security updates."""
    manager = DiscourseVersionManager()
    
    security_updates = manager.hub_api.check_security_updates(manager.current_version)
    
    if security_updates:
        click.echo("🚨 Security updates available:")
        for update in security_updates:
            click.echo(f"  - {update.get('title', 'Security Update')}")
            if update.get('description'):
                click.echo(f"    {update['description']}")
        sys.exit(2)
    else:
        click.echo("✅ No security updates required")
        sys.exit(0)


if __name__ == '__main__':
    cli()