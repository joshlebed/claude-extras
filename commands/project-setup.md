---
allowed-tools: Bash
description: Initialize project documentation structure with templates
---

## Context

This command sets up the `.agent-project-docs/` directory structure with templates for AI-assisted project planning and tracking.

- Check if already initialized: !`test -d .agent-project-docs/_templates && echo "Already initialized" || echo "Not initialized"`

## Your Task

Initialize the project documentation structure for AI-assisted workflows by running the plugin's install script.

### Run Installation

Execute the install script from the plugin:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/install-templates.sh"
```

If templates already exist and you want to overwrite them:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/install-templates.sh" --force
```

### What Gets Created

The script creates:

```
.agent-project-docs/
└── _templates/
    ├── INDEX_TEMPLATE.md          # Template for project INDEX.md
    ├── NEXT_STEPS_TEMPLATE.md     # Template for detailed task tracking
    ├── PROGRESS_TEMPLATE.md       # Template for progress tracking
    └── README.md                  # Human guide for using templates
```

It also adds `.agent-project-docs/` to `.gitignore` if the project uses git.

### After Installation

Report to the user:

```
Project documentation structure initialized!

Next steps:
1. Run /project-init <project-name> to create documentation for a specific project
2. Run /project-cycle <project-slug> to work through tasks
3. Run /project-status [project-slug] to check progress
```
