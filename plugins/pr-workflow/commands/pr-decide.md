---
allowed-tools: Task, Bash, Read, Grep, Glob
argument-hint: [repository-name] [critical-review-output]
description: Tech lead prioritization - decide MUST FIX vs FOLLOW-UP
---

## Context Detection

!`if [ -d .git ]; then echo "Repository: $(basename $(pwd))"; echo "Branch: $(git rev-parse --abbrev-ref HEAD)"; else echo "Multi-repo workspace detected:"; for repo in */; do [ -d "$repo/.git" ] && (cd "$repo" && changes=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' '); branch=$(git branch --show-current 2>/dev/null); if [ "$changes" -gt 0 ] || { [ "$branch" != "main" ] && [ "$branch" != "master" ]; }; then echo "  ${repo%/} (branch: $branch, changes: $changes)"; fi); done; fi`

## Your Task

**Arguments: $ARGUMENTS**

**If in a git repository (single-repo context):**
- Use the Task tool with `subagent_type: "pr-tech-lead"` directly

**If in a multi-repo workspace:**
- Parse the first argument as the repository name
- If no repository specified, ask the user which one
- `cd` into that repository first, then invoke the agent

If a critical review was provided, use it. Otherwise, suggest running `/pr-workflow:pr-review` first.

Output a decision document with:
1. MUST FIX IN THIS PR
2. NICE TO HAVE (IF QUICK)
3. FOLLOW-UP / SEPARATE PR
