---
allowed-tools: Bash, Read, Write, Glob, Grep, Task
argument-hint: <project-name>
description: Create project documentation from templates
---

## Context

- Templates location: @.agent-project-docs/\_templates/
- Existing projects: !`ls -d .agent-project-docs/*/ 2>/dev/null | grep -v _templates | xargs -I {} basename {} 2>/dev/null || echo "none"`

## Your Task

Create project documentation for: **$ARGUMENTS**

### Prerequisites

If `.agent-project-docs/_templates/` doesn't exist, run `/project-setup` first.

### Step 1: Create Project Directory

Generate a slug from the project name (lowercase, hyphens, no spaces):

- "My New Feature" -> `my-new-feature`
- "Add User Auth" -> `add-user-auth`

```bash
mkdir -p .agent-project-docs/<project-slug>
```

### Step 2: Read Templates

Read these template files:

- @.agent-project-docs/\_templates/README.md - Best practices guide
- @.agent-project-docs/\_templates/INDEX_TEMPLATE.md - INDEX.md template
- @.agent-project-docs/\_templates/NEXT_STEPS_TEMPLATE.md - NEXT_STEPS.md template

### Step 3: Analyze the Codebase

Based on our conversation context, explore the codebase to understand:

- Current patterns and architecture
- Files that will need changes
- Existing similar implementations to follow
- Dependencies and constraints

### Step 4: Create Documentation Files

**Always create:**

1. **INDEX.md** - Customize from template with:

   - Real implementation patterns from THIS codebase (not generic examples)
   - Actual hooks/components/utilities with import paths
   - Project-specific success criteria
   - Remove the "Instructions for Planning Agent" section

2. **PROGRESS.md** - Create with:
   - Prioritized task breakdown (High/Medium/Low)
   - Time estimates for each task
   - "Next Priority" section with first 3 tasks
   - Empty "Completed" and "In Progress" sections

**Create if 10+ tasks:**

3. **NEXT_STEPS.md** - Detailed task instructions with:
   - Exact file paths
   - Line numbers (approximate)
   - Code snippets (copy-paste ready)
   - Test cases for each task

### Step 5: Report to User

Show:

1. **Summary**: Total tasks, estimated hours, priority breakdown
2. **INDEX.md**: Full contents
3. **PROGRESS.md**: Full contents
4. **First 3 tasks**: What to do first

Ask: "Ready to start with `/project-cycle <slug>`?"
