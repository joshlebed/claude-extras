---
allowed-tools: Task
argument-hint: <project-slug>
description: Autonomous work loop for project tasks
---

## Context

- Project: @.project-plan/$ARGUMENTS/
- Current status: !`grep -E "^\\*\\*Overall Status:\\*\\*|^## .* Progress|^- \\[x\\]|^- \\[ \\]" .project-plan/$ARGUMENTS/PROGRESS.md 2>/dev/null | head -10 || echo "Project not found"`

## Your Task

Launch the autonomous work agent for the **$ARGUMENTS** project.

Use the Task tool with:
- subagent_type: "work-agent"
- prompt: "Work on project at .project-plan/$ARGUMENTS/. The project files are in .project-plan/$ARGUMENTS/ including INDEX.md, PROGRESS.md, and NEXT_STEPS.md. Continue working through tasks until you encounter real blockers or questions that require user input."

The work-agent will:
1. Read project documentation (INDEX.md, PROGRESS.md, NEXT_STEPS.md)
2. Work through tasks continuously
3. Update progress documentation after each task
4. Only stop when hitting real blockers or needing user input
5. Provide checkpoint updates every 3 tasks (but keep working)

Simply launch the agent and let it run autonomously.
