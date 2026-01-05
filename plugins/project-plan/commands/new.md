---
allowed-tools: Bash, Read, Write, Glob, Grep, Task
argument-hint: <prompt>
description: Create project documentation for a feature or task
---

## Context

- Ensure templates are installed:
  !`test -d .project-plan/_templates || bash "${CLAUDE_PLUGIN_ROOT}/scripts/install-templates.sh"`
- Templates location: @.project-plan/\_templates/
- Existing projects: !`ls -d .project-plan/*/ 2>/dev/null | grep -v _templates | xargs -I {} basename {} 2>/dev/null || echo "none"`

## Your Task

Create project documentation based on this prompt: **$ARGUMENTS**

The prompt above may contain:
- A project name/title (required)
- Additional instructions, preferences, or context from prior conversation (optional)

Examples:
- "Add User Authentication" - just a project name
- "Add User Authentication. Use OAuth2 and follow the existing auth middleware pattern." - project name with refinements
- "Implement the caching layer we discussed. Focus on Redis first, skip memcached for now." - references prior conversation

### Step 1: Create Project Directory

Extract the project name from the prompt and generate a slug (lowercase, hyphens, no spaces):

- "My New Feature" -> `my-new-feature`
- "Add User Auth. Use OAuth2..." -> `add-user-auth`

```bash
mkdir -p .project-plan/<project-slug>
```

### Step 2: Read Templates

Read these template files:

- @.project-plan/\_templates/README.md - Best practices guide
- @.project-plan/\_templates/INDEX_TEMPLATE.md - INDEX.md template
- @.project-plan/\_templates/PROGRESS_TEMPLATE.md - PROGRESS.md template
- @.project-plan/\_templates/NEXT_STEPS_TEMPLATE.md - NEXT_STEPS.md template (for complex projects)

### Step 3: Analyze the Codebase

Based on the prompt and any prior conversation context, explore the codebase to understand:

- Current patterns and architecture
- Files that will need changes
- Existing similar implementations to follow
- Dependencies and constraints

**Important:** If the prompt includes specific instructions, preferences, or constraints (e.g., "use OAuth2", "skip feature X", "follow pattern Y"), incorporate these into your analysis and planning.

### Step 4: Create Documentation Files

**Always create:**

1. **INDEX.md** - Customize from template with:

   - Real implementation patterns from THIS codebase (not generic examples)
   - Actual hooks/components/utilities with import paths
   - Project-specific success criteria
   - Any constraints or preferences specified in the user's prompt
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

Ask: "Ready to start with `/project-plan:work <slug>`?"
