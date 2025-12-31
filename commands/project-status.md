---
allowed-tools: Read, Glob, Bash
argument-hint: [project-slug]
description: Show current project progress
---

## Context

- Available projects: !`ls -d .agent-project-docs/*/ 2>/dev/null | grep -v _templates | xargs -I {} basename {} 2>/dev/null || echo "none"`

## Your Task

Show status for project: **$ARGUMENTS**

If no project specified, list all projects with their status.

### For Specific Project

Read @.agent-project-docs/$ARGUMENTS/PROGRESS.md and show:

```
## Project: $ARGUMENTS

**Status:** X% complete (X/Y tasks)
**Last Updated:** YYYY-MM-DD

### Completed
- Task 1
- Task 2

### In Progress
- Current task (if any)

### Next 3 Priorities
1. Task name (est: X min)
2. Task name (est: X min)
3. Task name (est: X min)

### Blockers (if any)
- Blocker description

---
Continue with: /project-cycle $ARGUMENTS
```

### For All Projects

If no argument provided, scan all project directories:

```
## Active Projects

| Project | Status | Next Task |
|---------|--------|-----------|
| project-1 | 60% (6/10) | Implement X |
| project-2 | 25% (2/8) | Fix Y |

Use: /project-status <slug> for details
```
