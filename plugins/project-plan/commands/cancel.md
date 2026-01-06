---
description: "Cancel active project work loop"
allowed-tools: ["Bash(test -f .claude/project-plan-loop.local.md:*)", "Bash(rm .claude/project-plan-loop.local.md)", "Read(.claude/project-plan-loop.local.md)"]
---

# Cancel Work Loop

To cancel the project work loop:

1. Check if `.claude/project-plan-loop.local.md` exists using Bash: `test -f .claude/project-plan-loop.local.md && echo "EXISTS" || echo "NOT_FOUND"`

2. **If NOT_FOUND**: Say "No active project work loop found."

3. **If EXISTS**:
   - Read `.claude/project-plan-loop.local.md` to get:
     - `project_slug:` - the project being worked on
     - `iteration:` - how many iterations completed
   - Remove the file using Bash: `rm .claude/project-plan-loop.local.md`
   - Report: "Cancelled work loop for [project_slug] (was at iteration N)"
   - Remind user they can resume with `/project-plan:work [project_slug]`
