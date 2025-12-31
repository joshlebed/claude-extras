# plan-smart

Smart project planning for AI coding agents. Create structured docs, track progress, and run autonomous work cycles.

## What This Plugin Does

- **Structured Project Planning**: Create organized documentation with INDEX.md, PROGRESS.md, and NEXT_STEPS.md
- **Autonomous Work Cycles**: Run `/cycle` to let Claude work through tasks with built-in checkpoints
- **Progress Tracking**: Always know what's done and what's next with `/status`
- **Pattern-Based Implementation**: Document codebase patterns so Claude follows existing conventions

## Installation

### From GitHub

Add the marketplace:

```bash
/plugin marketplace add joshlebed/claude-extras
```

Install the plugin:

```bash
/plugin install plan-smart@claude-extras
```

### Team Sharing

Add this to your project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "claude-extras": {
      "source": {
        "source": "github",
        "repo": "joshlebed/claude-extras"
      }
    }
  },
  "enabledPlugins": {
    "plan-smart@claude-extras": true
  }
}
```

When team members trust the repository folder, Claude Code prompts them to install.

### Local Development

```bash
claude --plugin-dir /path/to/claude-project-workflows
```

### Updates

Refresh marketplace:

```bash
/plugin marketplace update claude-extras
```

Update plugin:

```bash
/plugin update plan-smart@claude-extras
```

**Note:** Third-party marketplaces have auto-update disabled by default. Enable via `/plugin` UI under Marketplaces tab.

## Commands

| Command          | Description                                          |
| ---------------- | ---------------------------------------------------- |
| `/setup`         | Initialize templates in `.agent-project-docs/`       |
| `/init <name>`   | Create project documentation for a feature/task      |
| `/cycle <slug>`  | Autonomous work loop with progress updates           |
| `/status [slug]` | Show project progress (all projects if no slug)      |

## Quick Start

### 1. Set Up Templates

```
/setup
```

Creates:

```
.agent-project-docs/
└── _templates/
    ├── INDEX_TEMPLATE.md
    ├── NEXT_STEPS_TEMPLATE.md
    ├── PROGRESS_TEMPLATE.md
    └── README.md
```

### 2. Initialize a Project

```
/init Add User Authentication
```

Creates:

```
.agent-project-docs/
├── _templates/
└── add-user-authentication/
    ├── INDEX.md      # Quick start + patterns
    ├── PROGRESS.md   # Task tracking
    └── NEXT_STEPS.md # Detailed instructions (if 10+ tasks)
```

### 3. Work Through Tasks

```
/cycle add-user-authentication
```

Claude will:

1. Read project documentation
2. Pick the next priority task
3. Implement changes
4. Update progress
5. Stop for checkpoint after 5 tasks or when blocked

### 4. Check Progress

```
/status add-user-authentication
```

Or see all projects:

```
/status
```

## Documentation Structure

### INDEX.md (Always Created)

- Quick start instructions
- Implementation patterns from YOUR codebase
- Available hooks/components/utilities
- Success criteria

### PROGRESS.md (Always Created)

- Completion percentage
- Completed tasks (with dates)
- In-progress tasks
- Pending tasks (prioritized: High/Medium/Low)
- Blockers and notes

### NEXT_STEPS.md (For Complex Projects)

- Exact file paths and line numbers
- Code snippets (copy-paste ready)
- Test cases per task
- Implementation order

## Best Practices

### When to Use

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
claude-extras/
├── .claude-plugin/
│   ├── marketplace.json     # Marketplace definition
│   └── plugin.json          # Plugin metadata
├── commands/
│   ├── setup.md             # Initialize templates
│   ├── init.md              # Create project docs
│   ├── cycle.md             # Autonomous work loop
│   └── status.md            # Show progress
├── templates/
│   ├── INDEX_TEMPLATE.md
│   ├── NEXT_STEPS_TEMPLATE.md
│   ├── PROGRESS_TEMPLATE.md
│   └── README.md
├── scripts/
│   └── install-templates.sh
└── README.md
```

## Configuration

### Excluding from Git

Setup automatically adds `.agent-project-docs/` to `.gitignore`.

To commit project docs (for team handoffs):

```bash
sed -i '' '/\.agent-project-docs/d' .gitignore
```

### Customizing Templates

After `/setup`, edit files in `.agent-project-docs/_templates/`.

## Troubleshooting

### "Templates not found"

Run `/setup` first.

### "Project not found"

Check the slug matches a directory:

```bash
ls .agent-project-docs/
```

### Progress not updating

Remind Claude:

```
Update PROGRESS.md immediately after completing each task. Don't batch updates.
```

## How to Disable

```bash
/plugin uninstall plan-smart
```

## Contributing

1. Fork the repository
2. Make changes
3. Test with `claude --plugin-dir ./claude-extras`
4. Validate with `claude plugin validate .`
5. Submit a pull request

## License

MIT
