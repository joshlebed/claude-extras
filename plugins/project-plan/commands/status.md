---
allowed-tools: Read, Glob, Bash
argument-hint: [project-slug]
description: Show current project progress
---

## Context

- Available projects: !`ls -d .project-plan/*/ 2>/dev/null | grep -v _templates | xargs -I {} basename {} 2>/dev/null || echo "none"`
- Active work loops: !`ls .project-plan/*/loop-state.local.md 2>/dev/null | xargs -I {} dirname {} | xargs -I {} basename {} 2>/dev/null | tr '\n' ' ' || echo "none"`

## Your Task

Show status for project: **$ARGUMENTS**

If no project specified, list all projects with their status.

### For Specific Project

Read @.project-plan/$ARGUMENTS/PROGRESS.md and show:

```
## Project: $ARGUMENTS

**Status:** X% complete (X/Y tasks)
**Last Updated:** YYYY-MM-DD
**Work Loop:** Active (iteration N) / Not active

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
Continue with: /project-plan:work $ARGUMENTS
Cancel loop:   /project-plan:cancel
```

To check if work loop is active for this project, check if `.project-plan/<slug>/loop-state.local.md` exists.

### For All Projects

If no argument provided, scan all project directories:

```
## Active Projects

| Project | Status | Next Task | Work Loop |
|---------|--------|-----------|-----------|
| project-1 | 60% (6/10) | Implement X | Active |
| project-2 | 25% (2/8) | Fix Y | - |

Use: /project-plan:status <slug> for details
```
