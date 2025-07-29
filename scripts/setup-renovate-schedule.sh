#!/bin/bash
# Setup GitLab CI schedule for daily Renovate runs

set -euo pipefail

# Configuration
PROJECT_ID="${CI_PROJECT_ID:-}"
GITLAB_URL="${CI_SERVER_URL:-https://gitlab.com}"
GITLAB_TOKEN="${GITLAB_TOKEN:-}"

if [[ -z "$PROJECT_ID" || -z "$GITLAB_TOKEN" ]]; then
    echo "Error: CI_PROJECT_ID and GITLAB_TOKEN environment variables are required"
    echo "Usage: CI_PROJECT_ID=123 GITLAB_TOKEN=glpat-xxx ./setup-renovate-schedule.sh"
    exit 1
fi

echo "Setting up daily Renovate schedule for project $PROJECT_ID..."

# Create pipeline schedule using GitLab API
curl -X POST \
    -H "PRIVATE-TOKEN: $GITLAB_TOKEN" \
    -H "Content-Type: application/json" \
    "$GITLAB_URL/api/v4/projects/$PROJECT_ID/pipeline_schedules" \
    -d '{
        "description": "Daily Renovate Run",
        "ref": "main",
        "cron": "0 6 * * 1-5",
        "cron_timezone": "UTC",
        "active": true
    }'

echo "✅ Renovate schedule created successfully!"
echo "Renovate will run daily at 6 AM UTC on weekdays"
echo ""
echo "You can view and manage schedules at:"
echo "$GITLAB_URL/$CI_PROJECT_PATH/-/pipeline_schedules"