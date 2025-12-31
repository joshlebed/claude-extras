# Claude Project Workflows

A Claude Code plugin that provides structured project documentation and task management workflows for AI coding agents. This plugin helps you plan, track, and execute multi-task software projects with clear progress visibility.

## What This Plugin Does

- **Structured Project Planning**: Create organized documentation for complex projects with templates for INDEX.md, PROGRESS.md, and NEXT_STEPS.md
- **Autonomous Work Cycles**: Run `/project-cycle` to let Claude work through tasks with built-in checkpoints and progress updates
- **Progress Tracking**: Always know what's done, what's in progress, and what's next with `/project-status`
- **Pattern-Based Implementation**: Document codebase patterns so Claude follows existing conventions

## Installation

### From GitHub

First, add the repository as a marketplace:

```bash
/plugin marketplace add joshlebed/claude-project-workflows
```

Then install the plugin:

```bash
/plugin install claude-project-workflows@joshlebed/claude-project-workflows
```

### Team Sharing

To share the plugin with your team, add this to your project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "project-workflows": {
      "source": {
        "source": "github",
        "repo": "joshlebed/claude-project-workflows"
      }
    }
  },
  "enabledPlugins": {
    "claude-project-workflows@project-workflows": true
  }
}
```

When team members trust the repository folder, Claude Code automatically prompts them to install the marketplace and plugin.

### From Local Directory (Development)

```bash
claude --plugin-dir /path/to/claude-project-workflows
```

### Updates

To get plugin updates:

```bash
/plugin marketplace update project-workflows
```

## Commands

| Command                  | Description                                                               |
| ------------------------ | ------------------------------------------------------------------------- |
| `/project-setup`         | Initialize `.agent-project-docs/_templates/` with documentation templates |
| `/project-init <name>`   | Create project documentation for a new feature/task                       |
| `/project-cycle <slug>`  | Autonomous work loop - implements tasks and updates progress              |
| `/project-status [slug]` | Show project progress (all projects if no slug)                           |

## Quick Start

### 1. Set Up Templates

Run `/project-setup` to initialize the template structure in your project:

```
/project-setup
```

This creates:

```
.agent-project-docs/
└── _templates/
    ├── INDEX_TEMPLATE.md
    ├── NEXT_STEPS_TEMPLATE.md
    ├── PROGRESS_TEMPLATE.md
    └── README.md
```

### 2. Initialize a Project

Start a new project with `/project-init`:

```
/project-init Add User Authentication
```

This creates:

```
.agent-project-docs/
├── _templates/
└── add-user-authentication/
    ├── INDEX.md      # Quick start + patterns
    ├── PROGRESS.md   # Task tracking
    └── NEXT_STEPS.md # Detailed instructions (if 10+ tasks)
```

### 3. Work Through Tasks

Start the autonomous work cycle:

```
/project-cycle add-user-authentication
```

Claude will:

1. Read project documentation
2. Pick the next priority task
3. Implement changes
4. Update progress
5. Stop for checkpoint after 5 tasks or when blocked

### 4. Check Progress

View status anytime:

```
/project-status add-user-authentication
```

Or see all projects:

```
/project-status
```

## Documentation Structure

### INDEX.md (Always Created)

The agent's entry point containing:

- Quick start instructions
- Implementation patterns from YOUR codebase
- Available hooks/components/utilities
- Success criteria

### PROGRESS.md (Always Created)

Live progress tracker with:

- Completion percentage
- Completed tasks (with dates)
- In-progress tasks
- Pending tasks (prioritized: High/Medium/Low)
- Blockers and notes

### NEXT_STEPS.md (For Complex Projects)

Detailed task instructions with:

- Exact file paths and line numbers
- Code snippets (copy-paste ready)
- Test cases per task
- Implementation order

## Best Practices

### When to Use This Plugin

- Substantial projects (3+ hours of work)
- 10+ files to modify
- Complex refactoring across modules
- Projects spanning multiple sessions

### When NOT to Use

- Single file changes
- Quick bug fixes (< 1 hour)
- Simple find-and-replace operations

### Keeping Claude On Track

**After each task:**

```
Mark task X as complete in PROGRESS.md. Update percentage. Show what's next.
```

**When priorities change:**

```
Update PROGRESS.md: move [task] to high priority because [reason].
```

**After context limit or break:**

```
Read all files in @.agent-project-docs/<slug>/ starting with INDEX.md. Summarize what's done and what's next.
```

## Project Structure

```
claude-project-workflows/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── commands/
│   ├── project-setup.md     # Initialize templates
│   ├── project-init.md      # Create project docs
│   ├── project-cycle.md     # Autonomous work loop
│   └── project-status.md    # Show progress
├── templates/
│   ├── INDEX_TEMPLATE.md
│   ├── NEXT_STEPS_TEMPLATE.md
│   ├── PROGRESS_TEMPLATE.md
│   └── README.md
├── scripts/
│   └── install-templates.sh # Manual template installer
└── README.md
```

## Configuration

### Excluding from Git

The setup process automatically adds `.agent-project-docs/` to your `.gitignore`. Project documentation is typically ephemeral and not committed.

If you want to commit project docs (for team handoffs), remove the `.gitignore` entry:

```bash
# Remove from .gitignore
sed -i '' '/\.agent-project-docs/d' .gitignore
```

### Customizing Templates

After running `/project-setup`, edit files in `.agent-project-docs/_templates/` to customize for your team's workflow.

## Troubleshooting

### "Templates not found"

Run `/project-setup` first to initialize the template structure.

### "Project not found"

Check the project slug matches a directory in `.agent-project-docs/`:

```bash
ls .agent-project-docs/
```

### Progress not updating

Remind Claude:

```
Update PROGRESS.md immediately after completing each task. Don't batch updates.
```

## How to Disable

Remove the plugin:

```bash
/plugin uninstall claude-project-workflows
```

Or temporarily disable by removing from your settings.

## Contributing

1. Fork the repository
2. Make changes
3. Test with `claude --plugin-dir ./claude-project-workflows`
4. Validate with `claude plugin validate .`
5. Submit a pull request

## License

MIT

## Credits

Based on workflows developed for the Kepler development workspace.
