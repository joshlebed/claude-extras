#!/bin/bash

# Project Plan Session Start Hook
# Persists session_id to environment for use by work loop scripts
#
# Note: If CLAUDE_ENV_FILE isn't available in hook context, the setup-work-loop.sh
# script uses a "pending-bind" placeholder that gets bound to the real session ID
# when the stop hook runs (which does receive session_id in its input).

set -euo pipefail

# Read hook input from stdin
HOOK_INPUT=$(cat)

# Extract session_id and persist to CLAUDE_ENV_FILE if available
SESSION_ID=$(echo "$HOOK_INPUT" | jq -r '.session_id // empty')
if [ -n "${CLAUDE_ENV_FILE:-}" ] && [ -n "$SESSION_ID" ]; then
  echo "export PROJECT_PLAN_SESSION_ID=\"$SESSION_ID\"" >> "$CLAUDE_ENV_FILE"
fi

exit 0
