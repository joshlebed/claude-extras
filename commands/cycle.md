---
allowed-tools: Task, Bash, Read, Write, Edit, MultiEdit, Glob, Grep, AskUserQuestion, TodoWrite
argument-hint: <project-slug>
description: Autonomous work+review loop for project tasks
---

## Context

- Project: @.agent-project-docs/$ARGUMENTS/
- Current status: !`grep -E "^\\*\\*Overall Status:\\*\\*|^## .* Progress|^- \\[x\\]|^- \\[ \\]" .agent-project-docs/$ARGUMENTS/PROGRESS.md 2>/dev/null | head -10 || echo "Project not found"`

## Your Task

Work through tasks in **$ARGUMENTS** project, cycling between implementation and review.

### Before Starting

1. Read @.agent-project-docs/$ARGUMENTS/INDEX.md - Understand patterns and tools
2. Read @.agent-project-docs/$ARGUMENTS/PROGRESS.md - Find next pending task
3. Read @.agent-project-docs/$ARGUMENTS/NEXT_STEPS.md (if exists) - Get detailed instructions

### Work Cycle

Repeat this cycle until you need user input or complete 5 tasks:

#### IMPLEMENT

1. Pick the highest priority **pending** task from PROGRESS.md
2. Mark it as **In Progress** in PROGRESS.md (move to "In Progress" section)
3. Follow instructions from NEXT_STEPS.md if available
4. Implement the changes using patterns from INDEX.md
5. Run relevant lint/test commands

#### REVIEW

After each task, ask yourself:

1. Did implementation reveal anything that changes the plan?
2. Should any tasks be reprioritized based on what I learned?
3. Are there new tasks to add?
4. Should any tasks be removed or consolidated?

#### UPDATE

1. Mark task **complete** in PROGRESS.md (move to "Completed" section with date)
2. Update completion percentage
3. Update NEXT_STEPS.md if needed (mark done, add new tasks)
4. If plan changed significantly, update INDEX.md

### Stop Conditions

**Stop and ask user** when:

- You need a decision or clarification
- You hit a blocker you can't resolve
- You completed 5 tasks (checkpoint)
- All high-priority tasks are complete
- Something unexpected happened

### Checkpoint Report

At each stop, show:

```
## Project: $ARGUMENTS - Checkpoint

**Progress:** X% complete (X/Y tasks)

### Completed This Session
- Task 1: Brief description
- Task 2: Brief description

### Plan Changes (if any)
- Added: ...
- Removed: ...
- Reprioritized: ...

### Questions/Blockers (if any)
- Question 1
- Blocker 1

### Next Up
1. Next task (est: X min)
2. Following task (est: X min)

Continue? (y/n)
```

### Important Rules

- **One task at a time** - Complete fully before starting next
- **Update immediately** - Don't batch PROGRESS.md updates
- **Ask early** - If unsure, ask before implementing
- **Follow patterns** - Use existing patterns from INDEX.md, don't invent new ones
- **Test as you go** - Run tests/lint after each change
