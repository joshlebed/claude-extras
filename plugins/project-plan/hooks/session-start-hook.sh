#!/bin/bash

# Project Plan Session Start Hook
# Persists session_id to environment for use by work loop scripts

set -euo pipefail

# Read hook input from stdin
HOOK_INPUT=$(cat)

# Extract session_id and persist to CLAUDE_ENV_FILE if available
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  SESSION_ID=$(echo "$HOOK_INPUT" | jq -r '.session_id // empty')
  if [ -n "$SESSION_ID" ]; then
    echo "export PROJECT_PLAN_SESSION_ID=\"$SESSION_ID\"" >> "$CLAUDE_ENV_FILE"
  fi
fi

exit 0
