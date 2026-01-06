# Development Guide

## Running Plugins Locally

Load plugins without installing:

```bash
# From repo root
claude --plugin-dir ./plugins/project-plan

# From anywhere (absolute path)
claude --plugin-dir /path/to/claude-extras/plugins/project-plan

# Load multiple plugins
claude --plugin-dir ./plugins/project-plan --plugin-dir ./plugins/pr-workflow

# From plugin directory
cd plugins/project-plan
claude --plugin-dir .
```

## Validating Plugins

Before committing changes:

```bash
claude plugin validate ./plugins/project-plan
```

This checks:

- Valid plugin.json structure
- Correct file paths and references
- Valid frontmatter in commands/agents
- Hook configuration validity

## Version Bumping

Update version in `.claude-plugin/plugin.json`, then:

```bash
git commit -am "Bump project-plan to v1.0.3"
git tag project-plan-v1.0.3
git push && git push --tags
```
