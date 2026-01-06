---
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/scripts/setup-work-loop.sh *)
argument-hint: "[project-slug]"
description: Start work loop (auto-selects most recent project if no slug)
---

## Setup Work Loop

Run the setup script to activate the work loop:

```bash
${CLAUDE_PLUGIN_ROOT}/scripts/setup-work-loop.sh $ARGUMENTS
```

If no project slug is provided, the script auto-selects the most recently edited project and tells you which one.

After setup completes, the Stop hook will keep you in a continuous work loop until all tasks in PROGRESS.md are complete.

## Your First Task

Once the loop is active, the script output tells you which project was selected. Begin working:

1. **Read Current State**
   - Read the project's `PROGRESS.md` to find the highest priority PENDING task
   - Read the project's `INDEX.md` for patterns and constraints
   - Read `NEXT_STEPS.md` if it exists for detailed instructions

2. **Implement**
   - Implement the task following project patterns
   - Run tests/lint as specified in INDEX.md
   - Keep changes focused

3. **Update Documentation**
   - Mark task complete in PROGRESS.md (change `- [ ]` to `- [x]`)
   - Update completion count
   - Add any new tasks discovered
   - Update INDEX.md if patterns changed

4. **Continue**
   - When you try to stop, the hook feeds the work prompt back automatically
   - Loop continues until all tasks are marked complete

## When to Ask for Input

Use **AskUserQuestion** when you encounter:
- Multiple valid approaches needing user preference
- Ambiguous requirements
- Missing dependencies/credentials
- Unresolvable failures
- Architectural decisions needing team input

After asking, continue working on the next task.

## Canceling

Use `/project-plan:cancel` to stop the loop early.
