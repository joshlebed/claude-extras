# claude-extras

A plugin marketplace for Claude Code with useful workflow automation plugins.

## Plugins

| Plugin                        | Description                                   |
| ----------------------------- | --------------------------------------------- |
| [project-plan](#project-plan) | Project planning for AI coding agents         |
| [pr-workflow](#pr-workflow)   | Automated PR workflow with specialized agents |

## Installation

### Add the Marketplace

```bash
/plugin marketplace add joshlebed/claude-extras
```

### Install Plugins

```bash
/plugin install project-plan@claude-extras
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
    "project-plan@claude-extras": true,
    "pr-workflow@claude-extras": true
  }
}
```

### Updates

To enable auto-updates for plugins:

- Run `/plugin` to open the plugin manager
- Select `Marketplaces`
- Choose `claude-extras` from the list
- Select `Enable auto-update`

or update manually with:

```bash
/plugin marketplace update claude-extras
/plugin update project-plan@claude-extras
/plugin update pr-workflow@claude-extras
```

---

## project-plan

Project planning for AI coding agents. Create structured docs, track progress, and run autonomous work cycles.

### Commands

| Command                       | Description                                     |
| ----------------------------- | ----------------------------------------------- |
| `/project-plan:new <prompt>`  | Create project documentation for a feature/task |
| `/project-plan:work [slug]`   | Start work loop (auto-selects most recent project) |
| `/project-plan:status [slug]` | Show project progress                           |
| `/project-plan:cancel`        | Cancel active work loop                         |

### Quick Start

```
/project-plan:new Add User Authentication    # Create project docs
/project-plan:work add-user-authentication   # Work through tasks
/project-plan:status                         # Check progress
```

The `new` command accepts a prompt that can include both a project name and additional instructions:

```
# Just a project name
/project-plan:new Add User Authentication

# Project name with additional context
/project-plan:new Add User Authentication. Use OAuth2 and follow the existing auth middleware pattern.

# Reference prior conversation
/project-plan:new Implement the caching layer we discussed. Focus on Redis first, skip memcached.
```

### When to Use

- Substantial projects (3+ hours of work)
- 10+ files to modify
- Complex refactoring across modules
- Projects spanning multiple sessions

[Full documentation](./plugins/project-plan/templates/README.md)

---

## pr-workflow

Automated PR workflow with specialized agents for description writing, critical review, tech lead decisions, and implementation.

### Agents

1. **pr-description-expert** - Generates detailed PR descriptions from git diff
2. **pr-critical-reviewer** - Produces prioritized list of issues and risks
3. **pr-tech-lead** - Decides MUST FIX vs FOLLOW-UP scope
4. **pr-senior-engineer** - Implements required fixes

### Commands

| Command                        | Description                |
| ------------------------------ | -------------------------- |
| `/pr-workflow:describe [repo]` | Generate PR description    |
| `/pr-workflow:review [repo]`   | Critical review of changes |
| `/pr-workflow:decide [repo]`   | Tech lead prioritization   |
| `/pr-workflow:fix [repo]`      | Implement MUST FIX items   |
| `/pr-workflow:workflow [repo]` | Full automated workflow    |

### Quick Start

```
/pr-workflow:workflow              # Run full workflow on current repo
/pr-workflow:workflow api          # Run on 'api' subdirectory (multi-repo)
```

Or step-by-step:

```
/pr-workflow:describe    # Generate description
/pr-workflow:review      # Get critical review
/pr-workflow:decide      # Tech lead priorities
/pr-workflow:fix         # Implement fixes
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
│   └── marketplace.json        # Marketplace definition
├── plugins/
│   ├── project-plan/           # project-plan plugin
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   ├── hooks/
│   │   ├── scripts/
│   │   └── templates/
│   └── pr-workflow/            # pr-workflow plugin
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── agents/
│       ├── commands/
│       └── hooks/
└── README.md
```

## Contributing

1. Fork the repository
2. Make changes
3. Test with `claude --plugin-dir ./plugins/project-plan` or `claude --plugin-dir ./plugins/pr-workflow`
4. Submit a pull request

## License

MIT
