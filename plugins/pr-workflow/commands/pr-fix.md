---
allowed-tools: Task, Bash, Read, Grep, Glob, Edit, MultiEdit
argument-hint: [repository-name] [tech-lead-decision]
description: Implement MUST FIX items from tech lead decision
---

## Context Detection

!`if [ -d .git ]; then echo "Repository: $(basename $(pwd))"; echo "Branch: $(git rev-parse --abbrev-ref HEAD)"; else echo "Multi-repo workspace detected:"; for repo in */; do [ -d "$repo/.git" ] && (cd "$repo" && changes=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' '); branch=$(git branch --show-current 2>/dev/null); if [ "$changes" -gt 0 ] || { [ "$branch" != "main" ] && [ "$branch" != "master" ]; }; then echo "  ${repo%/} (branch: $branch, changes: $changes)"; fi); done; fi`

## Your Task

**Arguments: $ARGUMENTS**

**If in a git repository (single-repo context):**

- Use the Task tool with `subagent_type: "pr-senior-engineer"` directly

**If in a multi-repo workspace:**

- Parse the first argument as the repository name
- If no repository specified, ask the user which one
- `cd` into that repository first, then invoke the agent

If a tech lead decision was provided, use it. Otherwise, suggest running `/pr-workflow:decide` first.

The senior engineer will:

1. Implement all MUST FIX items
2. Implement quick wins from NICE TO HAVE
3. Skip FOLLOW-UP items
4. Run tests and report results
