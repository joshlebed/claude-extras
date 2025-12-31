---
allowed-tools: Task, Bash, Read, Grep, Glob, Edit, MultiEdit
argument-hint: [repository-name]
description: Full PR review workflow with subagents (description -> review -> tech-lead -> implement)
---

## Context Detection

!`if [ -d .git ]; then echo "Repository: $(basename $(pwd))"; echo "Branch: $(git rev-parse --abbrev-ref HEAD)"; echo ""; echo "Changes:"; git diff --stat 2>/dev/null | tail -10; else echo "Multi-repo workspace detected:"; for repo in */; do [ -d "$repo/.git" ] && (cd "$repo" && changes=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' '); branch=$(git branch --show-current 2>/dev/null); if [ "$changes" -gt 0 ] || { [ "$branch" != "main" ] && [ "$branch" != "master" ]; }; then echo "  ${repo%/} (branch: $branch, changes: $changes)"; fi); done; fi`

## Your Task

**Arguments: $ARGUMENTS**

**First, determine the target repository:**

- **If in a git repository:** Work on the current directory
- **If in a multi-repo workspace:** Parse the first argument as repository name. If not specified, ask the user which one based on repos shown above. Then `cd` into that repository.

**Then execute the full PR workflow sequentially:**

### Step 1: Generate PR Description

Use the Task tool with `subagent_type: "pr-description-expert"`.

Prompt: "Generate a detailed PR description for the current changes."

**Capture the full output as `PR_DESCRIPTION`.**

---

### Step 2: Critical Review

Use the Task tool with `subagent_type: "pr-critical-reviewer"`.

Prompt:
```
Here is the PR description:

<pr-description>
{INSERT PR_DESCRIPTION FROM STEP 1}
</pr-description>

Review this PR critically. Examine the code changes and produce a prioritized list of issues.
```

**Capture the full output as `CRITICAL_REVIEW`.**

---

### Step 3: Tech Lead Decision

Use the Task tool with `subagent_type: "pr-tech-lead"`.

Prompt:
```
PR Description:
<pr-description>
{INSERT PR_DESCRIPTION FROM STEP 1}
</pr-description>

Critical Review:
<critical-review>
{INSERT CRITICAL_REVIEW FROM STEP 2}
</critical-review>

Based on the above, decide what MUST be fixed in this PR vs what should be follow-ups.
```

**Capture the full output as `TECH_LEAD_DECISION`.**

---

### Step 4: Implement Fixes

Use the Task tool with `subagent_type: "pr-senior-engineer"`.

Prompt:
```
PR Description:
<pr-description>
{INSERT PR_DESCRIPTION FROM STEP 1}
</pr-description>

Critical Review:
<critical-review>
{INSERT CRITICAL_REVIEW FROM STEP 2}
</critical-review>

Tech Lead Decision:
<tech-lead-decision>
{INSERT TECH_LEAD_DECISION FROM STEP 3}
</tech-lead-decision>

Implement all MUST FIX items and any quick wins from NICE TO HAVE.
Do NOT implement FOLLOW-UP items.
Run tests after making changes.
```

**Capture the full output as `IMPLEMENTATION_SUMMARY`.**

---

### Step 5: Final Summary

After all agents complete, present a summary:

1. **Repository**: (name of repo worked on)
2. **PR Description** (formatted, ready to paste into GitHub/GitLab)
3. **Tech Lead Decision Document** (MUST FIX / NICE TO HAVE / FOLLOW-UP)
4. **Implementation Summary**:
   - Files modified
   - Tests run and results
   - Issues encountered
5. **Recommended Next Steps** (if any FOLLOW-UP items exist)
