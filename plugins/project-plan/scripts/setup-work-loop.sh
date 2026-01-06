#!/bin/bash

# Project Plan Work Loop Setup Script
# Creates state file for in-session work loop with Stop hook

set -euo pipefail

# Use CLAUDE_PLUGIN_ROOT if available, otherwise assume script is in scripts/
if [ -n "${CLAUDE_PLUGIN_ROOT:-}" ]; then
    PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT}"
else
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PLUGIN_ROOT="$(dirname "${SCRIPT_DIR}")"
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

EXAMPLES:
  /project-plan:work                 # Auto-select most recent project
  /project-plan:work add-user-auth   # Specify project explicitly

MONITORING:
  # View current iteration:
  grep '^iteration:' .claude/project-plan-loop.local.md

  # View full state:
  head -10 .claude/project-plan-loop.local.md

CANCELING:
  Use /project-plan:cancel to stop the loop early.
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

# Check for existing active loop FIRST
STATE_FILE=".claude/project-plan-loop.local.md"
if [[ -f "$STATE_FILE" ]]; then
  EXISTING_SLUG=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE" | grep '^project_slug:' | sed 's/project_slug: *//')
  EXISTING_ITERATION=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE" | grep '^iteration:' | sed 's/iteration: *//')

  if [[ -z "$PROJECT_SLUG" ]] || [[ "$PROJECT_SLUG" == "$EXISTING_SLUG" ]]; then
    # No slug provided or same slug - continue with existing loop
    PROJECT_SLUG="$EXISTING_SLUG"
    PROJECT_DIR=".project-plan/$PROJECT_SLUG"

    # Get current task count for display
    TOTAL_TASKS=$(grep -cE '^\- \[ \]|^\- \[x\]' "$PROJECT_DIR/PROGRESS.md" 2>/dev/null || echo "0")
    COMPLETED_TASKS=$(grep -cE '^\- \[x\]' "$PROJECT_DIR/PROGRESS.md" 2>/dev/null || echo "0")
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
    # User specified a different project - error
    echo "❌ Error: Work loop already active for: $EXISTING_SLUG" >&2
    echo "   You requested: $PROJECT_SLUG" >&2
    echo "" >&2
    echo "   Use /project-plan:cancel to stop the current loop first." >&2
    exit 1
  fi
fi

# No active loop - auto-select project if none provided
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

# Create state file directory
mkdir -p .claude
STATE_FILE=".claude/project-plan-loop.local.md"

# Create state file with YAML frontmatter
cat > "$STATE_FILE" <<EOF
---
project_slug: $PROJECT_SLUG
iteration: 1
started_at: "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
---
EOF

# Get current task count for display
TOTAL_TASKS=$(grep -cE '^\- \[ \]|^\- \[x\]' "$PROJECT_DIR/PROGRESS.md" 2>/dev/null || echo "0")
COMPLETED_TASKS=$(grep -cE '^\- \[x\]' "$PROJECT_DIR/PROGRESS.md" 2>/dev/null || echo "0")
# Ensure numeric values for arithmetic
TOTAL_TASKS=${TOTAL_TASKS:-0}
COMPLETED_TASKS=${COMPLETED_TASKS:-0}
PENDING_TASKS=$((TOTAL_TASKS - COMPLETED_TASKS))

# Output setup message
cat <<EOF
🔄 Project work loop activated!

Project: $PROJECT_SLUG$AUTO_SELECTED
Progress: $COMPLETED_TASKS/$TOTAL_TASKS tasks complete ($PENDING_TASKS remaining)

The stop hook is now active. After each task completion, the work prompt will be
fed back automatically. The loop stops when all tasks in PROGRESS.md are complete.

To monitor: head -10 .claude/project-plan-loop.local.md
To cancel:  /project-plan:cancel

───────────────────────────────────────────────────────────────

EOF
