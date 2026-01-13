---
description: "Cancel project work loop"
argument-hint: "[project-slug]"
allowed-tools: ["Bash", "Read"]
---

# Cancel Work Loop

Project root: !`echo "${PROJECT_PLAN_ROOT_DIR:-.}"`

To cancel a project work loop:

1. **If a project slug was provided** (e.g., `/project-plan:cancel my-project`):
   - Check if `${PROJECT_PLAN_ROOT_DIR:-.}/.project-plan/<slug>/loop-state.local.md` exists
   - If it exists, read it to get the iteration count, then remove it
   - Report: "Cancelled work loop for [slug] (was at iteration N)"

2. **If no project slug was provided**:
   - List all active loops: `ls "${PROJECT_PLAN_ROOT_DIR:-.}/.project-plan"/*/loop-state.local.md 2>/dev/null`
   - If none found: Say "No active project work loops found."
   - If one found: Cancel it automatically
   - If multiple found: List them and ask the user which one to cancel

3. After canceling, remind the user they can resume with `/project-plan:work [slug]`

## Important Notes

- State files are stored per-project at `${PROJECT_PLAN_ROOT_DIR:-.}/.project-plan/<slug>/loop-state.local.md`
- Multiple Claude instances can have separate loops for different projects
- Canceling removes the state file, which stops the loop for that project
- The stop hook automatically cleans up when all tasks are complete - manual cancel is only needed for early termination
