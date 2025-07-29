# Automated Discourse Updates with Renovate and GitLab CI

This repository now includes automated Discourse and plugin updates using Renovate, GitLab CI, and the Discourse Hub API.

## Overview

The automation system consists of:

1. **Renovate Bot** - Handles dependency updates and creates merge requests
2. **Discourse Hub API Integration** - Checks for Discourse core updates and security advisories
3. **GitLab CI Pipeline** - Runs tests and validations
4. **Custom Update Scripts** - Manages Nix-specific updates for Discourse plugins

## Setup

### 1. GitLab CI Variables

Set these variables in your GitLab project settings (`Settings > CI/CD > Variables`):

```bash
GITLAB_TOKEN=glpat-xxxxxxxxxxxxxxxxxxxx  # GitLab token with API access
```

### 2. Enable Pipeline Schedules

Run the setup script to create a daily schedule:

```bash
CI_PROJECT_ID=your-project-id GITLAB_TOKEN=your-token ./scripts/setup-renovate-schedule.sh
```

Or manually create a schedule in GitLab:
- Go to `CI/CD > Schedules`
- Create new schedule: "Daily Renovate Run"
- Cron: `0 6 * * 1-5` (6 AM UTC, weekdays)
- Target branch: `main`

### 3. Test the Setup

Test Discourse Hub API connectivity:

```bash
./scripts/test-discourse-hub-api.py
```

Test the update scripts:

```bash
./update_discourse_hub.py check --check-only
./update.py --pretend
```

## How It Works

### Daily Automation Flow

1. **6 AM UTC (Weekdays)**: GitLab CI triggers the Renovate job
2. **Renovate runs** and checks for:
   - Nix flake updates (`flake.lock`)
   - Ruby dependency updates in plugins
   - Custom regex patterns for Discourse versions and plugin revisions
3. **Discourse Hub API check**: Our custom script checks for:
   - Latest Discourse versions
   - Security updates
   - Compatibility information
4. **If updates are found**: Renovate creates merge requests
5. **CI Pipeline runs** on MRs to:
   - Test builds with new versions
   - Validate plugin compatibility
   - Run integration tests

### Manual Updates

You can also trigger updates manually:

```bash
# Check for Discourse updates via Hub API
./update_discourse_hub.py check

# Update to specific version
./update_discourse_hub.py update 3.4.4

# Update plugins for current Discourse version
./update.py

# Check what would be updated (dry run)
./update.py --pretend
```

## Configuration Files

### `renovate.json`
- Configures Renovate behavior
- Defines update schedules and rules
- Sets up custom managers for Nix files
- Handles Ruby dependencies

### `.gitlab-ci.yml`
- Defines CI pipeline stages
- Runs Renovate daily
- Tests builds and validates changes
- Handles both automated and manual triggers

### `update_discourse_hub.py`
- Integrates with Discourse Hub API
- Checks for version updates and security advisories
- Provides intelligent update recommendations
- Outputs structured reports for CI/CD

## Customization

### Update Frequency

Modify the schedule in `.gitlab-ci.yml`:

```yaml
rules:
  # Change this cron expression
  - if: $CI_PIPELINE_SOURCE == "schedule"
```

Or in `renovate.json`:

```json
{
  "schedule": ["before 8am every weekday"]
}
```

### Plugin-Specific Rules

Add custom rules in `renovate.json`:

```json
{
  "packageRules": [
    {
      "matchFileNames": ["discourse-specific-plugin/default.nix"],
      "schedule": ["before 8am on monday"],
      "automerge": true
    }
  ]
}
```

### Security Update Priority

The system automatically prioritizes security updates:
- **Critical**: Security updates available
- **High**: Major version behind
- **Medium**: Minor version behind or newer stable available
- **Low**: Patch updates available

## Monitoring

### GitLab CI Dashboard
- View pipeline status and logs
- Monitor update success/failure rates
- Review merge request activity

### Update Reports
The system generates JSON reports with:
- Current vs. available versions
- Security update status
- Plugin compatibility information
- Recommended actions

### Notifications
Configure GitLab notifications for:
- Failed pipelines
- Security update alerts
- Merge request assignments

## Troubleshooting

### Common Issues

1. **Renovate not running**
   - Check GitLab CI schedule is active
   - Verify `GITLAB_TOKEN` has correct permissions
   - Review Renovate logs in CI artifacts

2. **Hub API failures**
   - Test connectivity: `./scripts/test-discourse-hub-api.py`
   - Check network access from CI runners
   - Verify API endpoints are accessible

3. **Build failures**
   - Review Nix build logs
   - Check plugin compatibility
   - Verify flake.lock is up to date

4. **Plugin update issues**
   - Check `.discourse-compatibility` files
   - Verify GitHub API rate limits
   - Review plugin repository access

### Debug Commands

```bash
# Test Renovate configuration
renovate --dry-run

# Check Nix builds
nix flake check
nix build .#default

# Validate plugin compatibility
./update.py --pretend --check-hub-api

# Generate detailed update report
./update_discourse_hub.py check --output update-report.json
```

## Security Considerations

- **Token Security**: Store GitLab tokens as protected CI variables
- **Branch Protection**: Enable branch protection rules for main branch
- **Review Process**: Require reviews for security-related updates
- **Audit Trail**: All updates are tracked via Git commits and CI logs

## Contributing

When adding new plugins or modifying update logic:

1. Test changes with `--pretend` flag first
2. Update relevant documentation
3. Add appropriate CI tests
4. Consider impact on update automation

For questions or issues, please check the GitLab CI logs and create an issue with relevant error messages.