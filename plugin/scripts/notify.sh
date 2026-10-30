#!/usr/bin/env bash
# Notification hook: route notifications to ntfy.sh, Slack, or email
# Reads notification data from stdin JSON.
# Configuration via environment variables or the project .env (read with grep, never sourced):
#   NTFY_TOPIC      — ntfy.sh topic name (free, no account needed)
#   SLACK_WEBHOOK_URL — Slack incoming webhook URL
#   NOTIFICATION_EMAIL — email address for sendmail/msmtp
#
# If no notification method is configured, exits silently.

set -uo pipefail

# Read notification from stdin
input=$(cat)
title=$(echo "$input" | jq -r '.title // "Claude Code Notification"' 2>/dev/null)
message=$(echo "$input" | jq -r '.message // .body // "Task completed"' 2>/dev/null)

NTFY_TOPIC=${NTFY_TOPIC:-$(grep -sm1 '^NTFY_TOPIC=' .env | cut -d= -f2-)}
SLACK_WEBHOOK_URL=${SLACK_WEBHOOK_URL:-$(grep -sm1 '^SLACK_WEBHOOK_URL=' .env | cut -d= -f2-)}
NOTIFICATION_EMAIL=${NOTIFICATION_EMAIL:-$(grep -sm1 '^NOTIFICATION_EMAIL=' .env | cut -d= -f2-)}

sent=false

# Method 1: ntfy.sh
if [ -n "${NTFY_TOPIC:-}" ]; then
    curl -s \
        -H "Title: $title" \
        -d "$message" \
        "https://ntfy.sh/$NTFY_TOPIC" >/dev/null 2>&1 && sent=true
fi

# Method 2: Slack webhook
if [ -n "${SLACK_WEBHOOK_URL:-}" ]; then
    payload=$(jq -n --arg text "*$title*\n$message" '{"text": $text}')
    curl -s -X POST \
        -H 'Content-type: application/json' \
        -d "$payload" \
        "$SLACK_WEBHOOK_URL" >/dev/null 2>&1 && sent=true
fi

# Method 3: Email
if [ -n "${NOTIFICATION_EMAIL:-}" ]; then
    if command -v msmtp >/dev/null 2>&1; then
        printf 'Subject: %s\n\n%s\n' "$title" "$message" | msmtp "$NOTIFICATION_EMAIL" 2>/dev/null && sent=true
    elif command -v sendmail >/dev/null 2>&1; then
        printf 'Subject: %s\n\n%s\n' "$title" "$message" | sendmail "$NOTIFICATION_EMAIL" 2>/dev/null && sent=true
    fi
fi

exit 0
