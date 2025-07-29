#!/usr/bin/env nix-shell
#! nix-shell -i python3 -p "python3.withPackages (ps: with ps; [ requests click click-log packaging ])"
"""
Complete Discourse update workflow that integrates Hub API checks with plugin updates.
This script is designed to be called by Renovate or GitLab CI.
"""

import json
import logging
import subprocess
import sys
from pathlib import Path

import click
import click_log

logger = logging.getLogger(__name__)


@click.command()
@click_log.simple_verbosity_option(logger)
@click.option('--dry-run', is_flag=True, help='Show what would be done without making changes')
@click.option('--force-update', is_flag=True, help='Force update even if no critical updates found')
@click.option('--output-dir', type=click.Path(), default='reports', help='Directory for output reports')
def main(dry_run, force_update, output_dir):
    """Complete Discourse update workflow with Hub API integration."""
    
    # Ensure output directory exists
    output_path = Path(output_dir)
    output_path.mkdir(exist_ok=True)
    
    hub_report_file = output_path / 'hub-api-report.json'
    plugin_report_file = output_path / 'plugin-update-report.json'
    
    logger.info("Starting Discourse update workflow...")
    
    # Step 1: Check Discourse Hub API
    logger.info("Step 1: Checking Discourse Hub API for updates...")
    try:
        cmd = ['./update_discourse_hub.py', 'check', '--output', str(hub_report_file)]
        if dry_run:
            cmd.append('--check-only')
        
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        if result.returncode == 0:
            logger.info("✅ No Discourse updates needed")
            should_update_plugins = force_update
        elif result.returncode == 1:
            logger.info("📦 Discourse updates available (low/medium priority)")
            should_update_plugins = True
        elif result.returncode == 2:
            logger.warning("🚨 Critical Discourse updates available!")
            should_update_plugins = True
        else:
            logger.error(f"❌ Hub API check failed: {result.stderr}")
            should_update_plugins = force_update
            
    except Exception as e:
        logger.error(f"Failed to run Hub API check: {e}")
        should_update_plugins = force_update
    
    # Step 2: Update plugins if needed
    if should_update_plugins:
        logger.info("Step 2: Updating Discourse plugins...")
        try:
            cmd = [
                './update.py', 'update-plugins',
                '--check-hub-api',
                '--output-report', str(plugin_report_file)
            ]
            if dry_run:
                cmd.append('--pretend')
            
            result = subprocess.run(cmd, capture_output=True, text=True)
            
            if result.returncode == 0:
                logger.info("✅ Plugin updates completed successfully")
            else:
                logger.error(f"❌ Plugin update failed: {result.stderr}")
                sys.exit(1)
                
        except Exception as e:
            logger.error(f"Failed to run plugin updates: {e}")
            sys.exit(1)
    else:
        logger.info("Step 2: Skipping plugin updates (no critical updates found)")
    
    # Step 3: Generate summary report
    logger.info("Step 3: Generating summary report...")
    summary = generate_summary_report(hub_report_file, plugin_report_file, dry_run)
    
    summary_file = output_path / 'update-summary.json'
    with open(summary_file, 'w') as f:
        json.dump(summary, f, indent=2)
    
    # Step 4: Display results
    display_summary(summary)
    
    # Exit with appropriate code for CI/CD
    if summary['critical_updates_available']:
        logger.warning("Critical updates were processed")
        sys.exit(2)
    elif summary['updates_applied'] > 0:
        logger.info("Updates were applied successfully")
        sys.exit(1)
    else:
        logger.info("No updates were needed")
        sys.exit(0)


def generate_summary_report(hub_report_file, plugin_report_file, dry_run):
    """Generate a comprehensive summary report."""
    summary = {
        'dry_run': dry_run,
        'discourse_hub_check': {},
        'plugin_updates': {},
        'updates_applied': 0,
        'critical_updates_available': False,
        'recommendations': []
    }
    
    # Load Hub API report
    if hub_report_file.exists():
        try:
            with open(hub_report_file) as f:
                hub_data = json.load(f)
            summary['discourse_hub_check'] = hub_data
            
            recommendations = hub_data.get('recommendations', {})
            if recommendations.get('update_priority') in ['high', 'critical']:
                summary['critical_updates_available'] = True
            
            if recommendations.get('should_update'):
                summary['recommendations'].extend(recommendations.get('reasons', []))
                
        except Exception as e:
            logger.warning(f"Failed to load Hub API report: {e}")
    
    # Load plugin update report
    if plugin_report_file.exists():
        try:
            with open(plugin_report_file) as f:
                plugin_data = json.load(f)
            summary['plugin_updates'] = plugin_data
            summary['updates_applied'] = len(plugin_data.get('plugins_updated', []))
            
        except Exception as e:
            logger.warning(f"Failed to load plugin update report: {e}")
    
    return summary


def display_summary(summary):
    """Display a human-readable summary."""
    click.echo("\n" + "="*60)
    click.echo("DISCOURSE UPDATE WORKFLOW SUMMARY")
    click.echo("="*60)
    
    if summary['dry_run']:
        click.echo("🔍 DRY RUN MODE - No changes were made")
    
    # Discourse Hub API results
    hub_check = summary.get('discourse_hub_check', {})
    if hub_check:
        current_version = hub_check.get('current_version', 'unknown')
        recommendations = hub_check.get('recommendations', {})
        
        click.echo(f"\n📋 Current Discourse Version: {current_version}")
        
        if recommendations.get('should_update'):
            priority = recommendations.get('update_priority', 'unknown')
            target = recommendations.get('recommended_version', 'unknown')
            
            priority_emoji = {
                'critical': '🚨',
                'high': '⚠️',
                'medium': '📦',
                'low': '💡'
            }.get(priority, '❓')
            
            click.echo(f"{priority_emoji} Update Available: {target} (Priority: {priority})")
            
            if recommendations.get('reasons'):
                click.echo("   Reasons:")
                for reason in recommendations['reasons']:
                    click.echo(f"   • {reason}")
        else:
            click.echo("✅ Discourse is up to date")
    
    # Plugin update results
    plugin_updates = summary.get('plugin_updates', {})
    if plugin_updates:
        updated = plugin_updates.get('plugins_updated', [])
        skipped = plugin_updates.get('plugins_skipped', [])
        
        click.echo(f"\n🔌 Plugin Updates:")
        click.echo(f"   • Updated: {len(updated)} plugins")
        click.echo(f"   • Skipped: {len(skipped)} plugins")
        
        if updated:
            click.echo("   Updated plugins:")
            for plugin in updated:
                name = plugin['name']
                old_rev = plugin['old_rev'][:8]
                new_rev = plugin['new_rev'][:8]
                click.echo(f"   • {name}: {old_rev} → {new_rev}")
    
    # Overall status
    click.echo(f"\n📊 Summary:")
    click.echo(f"   • Total updates applied: {summary['updates_applied']}")
    click.echo(f"   • Critical updates available: {summary['critical_updates_available']}")
    
    if summary['recommendations']:
        click.echo("   • Recommendations:")
        for rec in summary['recommendations']:
            click.echo(f"     - {rec}")
    
    click.echo("="*60)


if __name__ == '__main__':
    main()