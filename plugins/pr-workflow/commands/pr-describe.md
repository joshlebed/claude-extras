---
allowed-tools: Task, Bash, Read, Grep, Glob
argument-hint: [repository-name]
description: Generate a PR description from current git diff
---

## Context Detection

!`if [ -d .git ]; then echo "Repository: $(basename $(pwd))"; echo "Branch: $(git rev-parse --abbrev-ref HEAD)"; else echo "Multi-repo workspace detected:"; for repo in */; do [ -d "$repo/.git" ] && (cd "$repo" && changes=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' '); branch=$(git branch --show-current 2>/dev/null); if [ "$changes" -gt 0 ] || { [ "$branch" != "main" ] && [ "$branch" != "master" ]; }; then echo "  ${repo%/} (branch: $branch, changes: $changes)"; fi); done; fi`

## Your Task

**Arguments: $ARGUMENTS**

**If in a git repository (single-repo context):**
- Use the Task tool with `subagent_type: "pr-description-expert"` directly

**If in a multi-repo workspace:**
- Parse the first argument as the repository name
- If no repository specified, ask the user which one based on the repos with changes shown above
- `cd` into that repository first, then invoke the agent

Output the PR description in a format ready to paste into GitHub/GitLab.
