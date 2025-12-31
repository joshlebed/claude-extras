# claude-extras

A plugin marketplace for Claude Code with useful workflow automation plugins.

## Plugins

| Plugin                      | Description                                   |
| --------------------------- | --------------------------------------------- |
| [plan-smart](#plan-smart)   | Smart project planning for AI coding agents   |
| [pr-workflow](#pr-workflow) | Automated PR workflow with specialized agents |

## Installation

### Add the Marketplace

```bash
/plugin marketplace add joshlebed/claude-extras
```

### Install Plugins

```bash
/plugin install plan-smart@claude-extras
/plugin install pr-workflow@claude-extras
```

### Team Sharing

Add to your project's `.claude/settings.json`:

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
    "plan-smart@claude-extras": true,
    "pr-workflow@claude-extras": true
  }
}
```

### Updates

```bash
/plugin marketplace update claude-extras
/plugin update plan-smart@claude-extras
/plugin update pr-workflow@claude-extras
```

---

## plan-smart

Smart project planning for AI coding agents. Create structured docs, track progress, and run autonomous work cycles.

### Commands

| Command          | Description                                     |
| ---------------- | ----------------------------------------------- |
| `/setup`         | Initialize templates in `.agent-project-docs/`  |
| `/init <name>`   | Create project documentation for a feature/task |
| `/cycle <slug>`  | Autonomous work loop with progress updates      |
| `/status [slug]` | Show project progress                           |

### Quick Start

```
/setup                           # Initialize templates
/init Add User Authentication    # Create project docs
/cycle add-user-authentication   # Work through tasks
/status                          # Check progress
```

### When to Use

- Substantial projects (3+ hours of work)
- 10+ files to modify
- Complex refactoring across modules
- Projects spanning multiple sessions

[Full documentation](./templates/README.md)

---

## pr-workflow

Automated PR workflow with specialized agents for description writing, critical review, tech lead decisions, and implementation.

### Agents

1. **pr-description-expert** - Generates detailed PR descriptions from git diff
2. **pr-critical-reviewer** - Produces prioritized list of issues and risks
3. **pr-tech-lead** - Decides MUST FIX vs FOLLOW-UP scope
4. **pr-senior-engineer** - Implements required fixes

### Commands

| Command               | Description                |
| --------------------- | -------------------------- |
| `/pr-describe [repo]` | Generate PR description    |
| `/pr-review [repo]`   | Critical review of changes |
| `/pr-decide [repo]`   | Tech lead prioritization   |
| `/pr-fix [repo]`      | Implement MUST FIX items   |
| `/pr-workflow [repo]` | Full automated workflow    |

### Quick Start

```
/pr-workflow              # Run full workflow on current repo
/pr-workflow api          # Run on 'api' subdirectory (multi-repo)
```

Or step-by-step:

```
/pr-describe    # Generate description
/pr-review      # Get critical review
/pr-decide      # Tech lead priorities
/pr-fix         # Implement fixes
```

### Smart Context Detection

- **Single repo** (`.git` in cwd): Works immediately
- **Multi-repo workspace**: Lists repos, accepts repo name as argument

[Full documentation](./plugins/pr-workflow/README.md)

---

## Repository Structure

```
claude-extras/
├── .claude-plugin/
│   ├── marketplace.json        # Marketplace definition
│   └── plugin.json             # plan-smart plugin metadata
├── commands/                   # plan-smart commands
│   ├── setup.md
│   ├── init.md
│   ├── cycle.md
│   └── status.md
├── templates/                  # plan-smart templates
├── plugins/
│   └── pr-workflow/            # pr-workflow plugin
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── agents/
│       ├── commands/
│       ├── hooks/
│       └── README.md
├── scripts/
└── README.md
```

## Contributing

1. Fork the repository
2. Make changes
3. Test with `claude --plugin-dir ./` (for plan-smart) or `claude --plugin-dir ./plugins/pr-workflow` (for pr-workflow)
4. Submit a pull request

## License

MIT
