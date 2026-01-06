#!/bin/bash

# Project Plan Stop Hook
# Prevents session exit when a project work loop is active
# Feeds the work prompt back to continue implementation

set -euo pipefail

# Read hook input from stdin (advanced stop hook API)
HOOK_INPUT=$(cat)

# Check if project-plan loop is active
STATE_FILE=".claude/project-plan-loop.local.md"

if [[ ! -f "$STATE_FILE" ]]; then
  # No active loop - allow exit
  exit 0
fi

# Parse markdown frontmatter (YAML between ---) and extract values
FRONTMATTER=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE")
PROJECT_SLUG=$(echo "$FRONTMATTER" | grep '^project_slug:' | sed 's/project_slug: *//')
ITERATION=$(echo "$FRONTMATTER" | grep '^iteration:' | sed 's/iteration: *//')

# Validate state file
if [[ -z "$PROJECT_SLUG" ]]; then
  echo "⚠️  Project work loop: State file corrupted (no project_slug)" >&2
  rm "$STATE_FILE"
  exit 0
fi

if [[ ! "$ITERATION" =~ ^[0-9]+$ ]]; then
  echo "⚠️  Project work loop: State file corrupted (invalid iteration: '$ITERATION')" >&2
  rm "$STATE_FILE"
  exit 0
fi

# Validate project still exists
PROJECT_DIR=".project-plan/$PROJECT_SLUG"
PROGRESS_FILE="$PROJECT_DIR/PROGRESS.md"

if [[ ! -f "$PROGRESS_FILE" ]]; then
  echo "⚠️  Project work loop: PROGRESS.md not found at $PROGRESS_FILE" >&2
  echo "   Project may have been deleted. Stopping loop." >&2
  rm "$STATE_FILE"
  exit 0
fi

# Count tasks in PROGRESS.md
# Tasks are lines matching "- [ ]" (pending) or "- [x]" (complete)
TOTAL_TASKS=$(grep -cE '^\- \[ \]|^\- \[x\]' "$PROGRESS_FILE" 2>/dev/null || echo "0")
COMPLETED_TASKS=$(grep -cE '^\- \[x\]' "$PROGRESS_FILE" 2>/dev/null || echo "0")
# Ensure numeric values for arithmetic
TOTAL_TASKS=${TOTAL_TASKS:-0}
COMPLETED_TASKS=${COMPLETED_TASKS:-0}
PENDING_TASKS=$((TOTAL_TASKS - COMPLETED_TASKS))

# Check if all tasks complete
if [[ $TOTAL_TASKS -gt 0 ]] && [[ $PENDING_TASKS -eq 0 ]]; then
  echo "✅ Project work loop complete: All $TOTAL_TASKS tasks done!"
  echo "   Project: $PROJECT_SLUG"
  echo "   Iterations: $ITERATION"
  rm "$STATE_FILE"
  exit 0
fi

# Check if no tasks at all (edge case)
if [[ $TOTAL_TASKS -eq 0 ]]; then
  echo "⚠️  Project work loop: No tasks found in PROGRESS.md" >&2
  echo "   Add tasks with '- [ ] Task description' format." >&2
  rm "$STATE_FILE"
  exit 0
fi

# Not complete - continue loop
NEXT_ITERATION=$((ITERATION + 1))

# Update iteration in state file atomically
TEMP_FILE="${STATE_FILE}.tmp.$$"
sed "s/^iteration: .*/iteration: $NEXT_ITERATION/" "$STATE_FILE" > "$TEMP_FILE"
mv "$TEMP_FILE" "$STATE_FILE"

# Build the work prompt that gets fed back
WORK_PROMPT=$(cat <<'PROMPT_EOF'
## Project Work Loop

### Your Task This Iteration

1. **Read Current State**
   - Read PROGRESS.md to find the highest priority PENDING task (look for `- [ ]`)
   - Read INDEX.md for patterns, constraints, and project context
   - Read NEXT_STEPS.md if it exists for detailed task instructions

2. **Implement**
   - Mark the task as "In Progress" in PROGRESS.md (optional but helpful)
   - Implement the task following project patterns from INDEX.md
   - Run tests/lint commands as specified in INDEX.md
   - Keep changes focused - do not over-engineer

3. **Update Documentation**
   - Mark task complete: change `- [ ]` to `- [x]` in PROGRESS.md
   - Update the completion count/percentage in PROGRESS.md
   - Add any NEW tasks discovered during implementation
   - Reprioritize if needed based on what you learned
   - Update INDEX.md only if patterns or constraints changed

4. **Reflect Before Continuing**
   - Did this task reveal anything that should change the plan?
   - Are there blockers for the next task that need user input?
   - If blocked, use AskUserQuestion - then continue working

### When to Use AskUserQuestion (Keep Working After!)
Use AskUserQuestion when you encounter:
- Multiple valid approaches that need user preference
- Ambiguous or contradictory requirements
- Missing external dependencies or credentials
- Unresolvable test/build failures
- Architectural decisions that need team input

After asking and receiving an answer, CONTINUE WORKING on the next task.

### Important
- Complete ONE task per iteration, then the loop continues automatically
- The loop stops when ALL tasks in PROGRESS.md are marked `- [x]`
- Focus on steady progress - quality over speed
PROMPT_EOF
)

# Build system message
PERCENT_DONE=0
if [[ $TOTAL_TASKS -gt 0 ]]; then
  PERCENT_DONE=$(( (COMPLETED_TASKS * 100) / TOTAL_TASKS ))
fi

SYSTEM_MSG="🔄 Project: $PROJECT_SLUG | Iteration $NEXT_ITERATION | Progress: $COMPLETED_TASKS/$TOTAL_TASKS tasks ($PERCENT_DONE%) | $PENDING_TASKS remaining"

# Output JSON to block the stop and feed prompt back
jq -n \
  --arg prompt "$WORK_PROMPT" \
  --arg msg "$SYSTEM_MSG" \
  '{
    "decision": "block",
    "reason": $prompt,
    "systemMessage": $msg
  }'

exit 0
