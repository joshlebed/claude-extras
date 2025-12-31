---
allowed-tools: Task, Bash, Read, Grep, Glob
argument-hint: [repository-name] [pr-description]
description: Run critical review on current PR changes
---

## Context Detection

!`if [ -d .git ]; then echo "Repository: $(basename $(pwd))"; echo "Branch: $(git rev-parse --abbrev-ref HEAD)"; else echo "Multi-repo workspace detected:"; for repo in */; do [ -d "$repo/.git" ] && (cd "$repo" && changes=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' '); branch=$(git branch --show-current 2>/dev/null); if [ "$changes" -gt 0 ] || { [ "$branch" != "main" ] && [ "$branch" != "master" ]; }; then echo "  ${repo%/} (branch: $branch, changes: $changes)"; fi); done; fi`

## Your Task

**Arguments: $ARGUMENTS**

**If in a git repository (single-repo context):**

- Use the Task tool with `subagent_type: "pr-critical-reviewer"` directly

**If in a multi-repo workspace:**

- Parse the first argument as the repository name
- If no repository specified, ask the user which one
- `cd` into that repository first, then invoke the agent

If a PR description was provided, pass it to the reviewer. Otherwise, suggest running `/pr-workflow:describe` first.

Produce a structured review with:

- Blocking issues (MUST FIX)
- Strong recommendations (SHOULD FIX)
- Non-blocking suggestions (NICE TO HAVE)
- Questions / clarifications
