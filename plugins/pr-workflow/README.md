# pr-workflow

Automated PR workflow with specialized agents for description writing, critical review, tech lead decisions, and implementation.

## What This Plugin Does

Four specialized agents work together to review and improve your PRs:

1. **pr-description-expert** - Generates detailed, human-quality PR descriptions from your git diff
2. **pr-critical-reviewer** - Critically reviews code changes and produces prioritized issues
3. **pr-tech-lead** - Makes scope decisions: what MUST be fixed vs follow-ups
4. **pr-senior-engineer** - Implements the required fixes

## Installation

Add the marketplace (if not already added):

```bash
/plugin marketplace add joshlebed/claude-extras
```

Install the plugin:

```bash
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
    "pr-workflow@claude-extras": true
  }
}
```

## Smart Context Detection

The plugin automatically detects your workspace type:

| Context | Behavior |
|---------|----------|
| **Single repo** (`.git` in cwd) | Works on current directory |
| **Multi-repo workspace** | Lists repos with changes, accepts repo name as argument |

## Commands

| Command | Description |
|---------|-------------|
| `/pr-describe [repo]` | Generate PR description |
| `/pr-review [repo]` | Critical review of changes |
| `/pr-decide [repo]` | Tech lead prioritization |
| `/pr-fix [repo]` | Implement MUST FIX items |
| `/pr-workflow [repo]` | Full automated workflow |

The `[repo]` argument is only needed in multi-repo workspaces.

## Usage

### Full Automated Workflow

```
/pr-workflow
```

Runs all 4 agents sequentially:
1. Generate PR description
2. Critical review
3. Tech lead scope decisions
4. Implement fixes
5. Present summary

### Step-by-Step

```
/pr-describe      # Generate PR description
/pr-review        # Get critical review
/pr-decide        # Get tech lead priorities
/pr-fix           # Implement fixes
```

### Multi-Repo Workspace

```
/pr-workflow agent-framework    # Run on specific repo
/pr-describe crud-service       # Describe changes in crud-service
```

## Hooks

Two helpful hooks are included:

1. **PreToolUse** - Reminds you to run `/pr-describe` before `gh pr create` or `git push`
2. **Stop** - Reminds you to review agent outputs before creating your PR

### Disabling Hooks

Add to `.claude/settings.local.json`:

```json
{
  "hooks": {
    "PreToolUse": [],
    "Stop": []
  }
}
```

## Workflow Philosophy

- **Separation of concerns** - Each agent has one job
- **Incremental PRs** - Tech lead categorizes "fix now" vs "follow-up"
- **Honest uncertainty** - Agents flag unclear behavior rather than guessing
- **Scope control** - Engineers respect tech lead decisions

## How to Disable

```bash
/plugin uninstall pr-workflow@claude-extras
```

## License

MIT
