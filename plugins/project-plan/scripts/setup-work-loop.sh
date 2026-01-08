#!/bin/bash

# Project Plan Work Loop Setup Script
# Creates per-project state file with session binding for multi-instance support

set -euo pipefail

# Use CLAUDE_PLUGIN_ROOT if available, otherwise assume script is in scripts/
if [ -n "${CLAUDE_PLUGIN_ROOT:-}" ]; then
    PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT}"
else
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PLUGIN_ROOT="$(dirname "${SCRIPT_DIR}")"
fi

# Get session ID from environment (set by SessionStart hook via CLAUDE_ENV_FILE)
SESSION_ID="${PROJECT_PLAN_SESSION_ID:-}"

# If no session ID available, use a placeholder - the stop hook will bind the real session ID
# on first stop attempt (the stop hook receives session_id in its input)
if [[ -z "$SESSION_ID" ]]; then
  SESSION_ID="pending-bind"
fi

# Parse arguments
PROJECT_SLUG=""

show_help() {
  cat << 'HELP_EOF'
Project Plan Work Loop - Continuous implementation with plan updates

USAGE:
  /project-plan:work [project-slug]

ARGUMENTS:
  project-slug    The project identifier (directory name in .project-plan/)
                  If omitted, auto-selects the most recently edited project.

DESCRIPTION:
  Starts an autonomous work loop in your CURRENT session. The stop hook
  prevents exit and feeds the work prompt back until all tasks are complete.

  Each iteration:
  1. Reads PROGRESS.md to find the next highest-priority task
  2. Implements the task
  3. Updates documentation (PROGRESS.md, INDEX.md if needed)
  4. Continues to next task

  The loop AUTOMATICALLY STOPS when all tasks are marked complete in PROGRESS.md.

MULTI-INSTANCE SUPPORT:
  Multiple Claude instances can work on different projects simultaneously.
  Each instance binds to its project via session ID - no conflicts.

EXAMPLES:
  /project-plan:work                 # Auto-select most recent project
  /project-plan:work add-user-auth   # Specify project explicitly

MONITORING:
  # View current state:
  cat .project-plan/<slug>/loop-state.local.md

CANCELING:
  Use /project-plan:cancel to stop the loop early.

RECOVERY:
  If Claude was force-quit, just run /project-plan:work again to resume.
HELP_EOF
}

# Parse options
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      if [[ -z "$PROJECT_SLUG" ]]; then
        PROJECT_SLUG="$1"
      else
        echo "❌ Error: Unexpected argument: $1" >&2
        echo "   Only one project slug can be provided." >&2
        exit 1
      fi
      shift
      ;;
  esac
done

# Helper: Parse YAML frontmatter value from a file
parse_frontmatter() {
  local file="$1"
  local key="$2"
  sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$file" | grep "^${key}:" | sed "s/${key}: *//" | tr -d '"'
}

# Helper: Check if this session already has an active loop
# Returns the project slug if found, exits 1 otherwise
# When SESSION_ID is "pending-bind", also matches existing pending-bind loops
find_session_loop() {
  local session="$1"
  if [[ ! -d ".project-plan" ]]; then
    return 1
  fi
  for dir in .project-plan/*/; do
    local state_file="${dir}loop-state.local.md"
    if [[ -f "$state_file" ]]; then
      local file_session
      file_session=$(parse_frontmatter "$state_file" "session_id")
      # Match exact session ID, or match pending-bind if that's what we have
      if [[ "$file_session" == "$session" ]]; then
        basename "$dir"
        return 0
      fi
    fi
  done
  return 1
}

# Check if THIS session already has an active loop
EXISTING_SESSION_LOOP=""
if EXISTING_SESSION_LOOP=$(find_session_loop "$SESSION_ID"); then
  # This session already has a loop bound
  if [[ -z "$PROJECT_SLUG" ]] || [[ "$PROJECT_SLUG" == "$EXISTING_SESSION_LOOP" ]]; then
    # Continue with existing loop
    PROJECT_SLUG="$EXISTING_SESSION_LOOP"
    PROJECT_DIR=".project-plan/$PROJECT_SLUG"
    STATE_FILE="$PROJECT_DIR/loop-state.local.md"
    EXISTING_ITERATION=$(parse_frontmatter "$STATE_FILE" "iteration")

    # Get current task count for display
    TOTAL_TASKS=$(grep -cE '^\- \[ \]|^\- \[x\]' "$PROJECT_DIR/PROGRESS.md" 2>/dev/null || true)
    COMPLETED_TASKS=$(grep -cE '^\- \[x\]' "$PROJECT_DIR/PROGRESS.md" 2>/dev/null || true)
    TOTAL_TASKS=${TOTAL_TASKS:-0}
    COMPLETED_TASKS=${COMPLETED_TASKS:-0}
    PENDING_TASKS=$((TOTAL_TASKS - COMPLETED_TASKS))

    cat <<EOF
🔄 Continuing work loop for: $PROJECT_SLUG

Iteration: $EXISTING_ITERATION
Progress: $COMPLETED_TASKS/$TOTAL_TASKS tasks complete ($PENDING_TASKS remaining)

───────────────────────────────────────────────────────────────

EOF
    exit 0
  else
    # User wants to switch to a different project - unbind from current first
    OLD_STATE_FILE=".project-plan/$EXISTING_SESSION_LOOP/loop-state.local.md"
    if [[ -f "$OLD_STATE_FILE" ]]; then
      rm "$OLD_STATE_FILE"
    fi
    echo "📋 Switched from $EXISTING_SESSION_LOOP to $PROJECT_SLUG"
  fi
fi

# Auto-select project if none provided
AUTO_SELECTED=""
if [[ -z "$PROJECT_SLUG" ]]; then
  if [[ ! -d ".project-plan" ]]; then
    echo "❌ Error: No projects found" >&2
    echo "   Run /project-plan:new first to create a project." >&2
    exit 1
  fi

  # Find project with most recently modified PROGRESS.md
  MOST_RECENT=""
  MOST_RECENT_TIME=0

  for dir in .project-plan/*/; do
    if [[ -f "${dir}PROGRESS.md" ]]; then
      # Get modification time (works on both macOS and Linux)
      if [[ "$(uname)" == "Darwin" ]]; then
        MOD_TIME=$(stat -f %m "${dir}PROGRESS.md" 2>/dev/null || echo "0")
      else
        MOD_TIME=$(stat -c %Y "${dir}PROGRESS.md" 2>/dev/null || echo "0")
      fi

      if [[ "$MOD_TIME" -gt "$MOST_RECENT_TIME" ]]; then
        MOST_RECENT_TIME="$MOD_TIME"
        MOST_RECENT=$(basename "$dir")
      fi
    fi
  done

  if [[ -z "$MOST_RECENT" ]]; then
    echo "❌ Error: No projects with PROGRESS.md found" >&2
    echo "   Run /project-plan:new first to create a project." >&2
    exit 1
  fi

  PROJECT_SLUG="$MOST_RECENT"
  AUTO_SELECTED=" (auto-selected, most recently edited)"
fi

# Validate project exists
PROJECT_DIR=".project-plan/$PROJECT_SLUG"
if [[ ! -d "$PROJECT_DIR" ]]; then
  echo "❌ Error: Project not found: $PROJECT_SLUG" >&2
  echo "" >&2
  echo "   Directory .project-plan/$PROJECT_SLUG/ does not exist." >&2
  echo "" >&2
  echo "   Available projects:" >&2
  if [[ -d ".project-plan" ]]; then
    for dir in .project-plan/*/; do
      if [[ -f "${dir}PROGRESS.md" ]]; then
        slug=$(basename "$dir")
        echo "     - $slug" >&2
      fi
    done
  else
    echo "     (none - run /project-plan:new first)" >&2
  fi
  exit 1
fi

# Validate PROGRESS.md exists
if [[ ! -f "$PROJECT_DIR/PROGRESS.md" ]]; then
  echo "❌ Error: Project missing PROGRESS.md: $PROJECT_SLUG" >&2
  echo "" >&2
  echo "   The project directory exists but PROGRESS.md is missing." >&2
  echo "   Run /project-plan:new to properly initialize the project." >&2
  exit 1
fi

# Check for existing state (could be from crashed session or another instance)
STATE_FILE="$PROJECT_DIR/loop-state.local.md"
RESUMING=""
ITERATION=1
SKIP_STATE_UPDATE=""

if [[ -f "$STATE_FILE" ]]; then
  EXISTING_SESSION=$(parse_frontmatter "$STATE_FILE" "session_id")
  EXISTING_ITERATION=$(parse_frontmatter "$STATE_FILE" "iteration")

  if [[ "$EXISTING_SESSION" == "$SESSION_ID" ]]; then
    # Same session - already handled above, but just in case
    ITERATION="${EXISTING_ITERATION:-1}"
    RESUMING=" (continuing)"
  elif [[ "$SESSION_ID" == "pending-bind" ]] && [[ "$EXISTING_SESSION" != "pending-bind" ]]; then
    # We have pending-bind but state file has a real session ID (already bound by stop hook)
    # Don't overwrite - continue with existing binding
    ITERATION="${EXISTING_ITERATION:-1}"
    RESUMING=" (continuing)"
    SKIP_STATE_UPDATE="true"
  else
    # Different session - this is a recovery/takeover scenario
    ITERATION="${EXISTING_ITERATION:-1}"
    RESUMING=" (resumed from previous session at iteration $ITERATION)"
  fi
fi

# Create/update state file with session binding (skip if already bound)
if [[ -z "$SKIP_STATE_UPDATE" ]]; then
  cat > "$STATE_FILE" <<EOF
---
session_id: "$SESSION_ID"
iteration: $ITERATION
started_at: "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
---
EOF
fi

# Get current task count for display
TOTAL_TASKS=$(grep -cE '^\- \[ \]|^\- \[x\]' "$PROJECT_DIR/PROGRESS.md" 2>/dev/null || true)
COMPLETED_TASKS=$(grep -cE '^\- \[x\]' "$PROJECT_DIR/PROGRESS.md" 2>/dev/null || true)
TOTAL_TASKS=${TOTAL_TASKS:-0}
COMPLETED_TASKS=${COMPLETED_TASKS:-0}
PENDING_TASKS=$((TOTAL_TASKS - COMPLETED_TASKS))

# Output setup message
cat <<EOF
🔄 Project work loop activated!$RESUMING

Project: $PROJECT_SLUG$AUTO_SELECTED
Progress: $COMPLETED_TASKS/$TOTAL_TASKS tasks complete ($PENDING_TASKS remaining)

The stop hook is now active. After each task completion, the work prompt will be
fed back automatically. The loop stops when all tasks in PROGRESS.md are complete.

To monitor: cat .project-plan/$PROJECT_SLUG/loop-state.local.md
To cancel:  /project-plan:cancel $PROJECT_SLUG

───────────────────────────────────────────────────────────────

EOF
