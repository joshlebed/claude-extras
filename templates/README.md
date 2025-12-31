# Project Documentation Template - Human Guide

## Quick Start

### 1. Create Project Documentation

After exploring the codebase, ask your AI agent:

```
Based on our conversation, create project documentation using the templates at @.agent-project-docs/_templates/

Name the project and create an appropriate directory (e.g., @.agent-project-docs/my-feature/).
Follow the best practices in the template README.
Show me INDEX.md and PROGRESS.md when done.
```

### 2. Review and Approve

Check the generated docs:

**INDEX.md:**

- Clear quick start?
- Implementation patterns visible?
- Links to next steps?

**PROGRESS.md:**

- Reasonable time estimates?
- Correct priorities?
- Percentage complete tracked?

**NEXT_STEPS.md (if complex project):**

- Step-by-step tasks?
- Code snippets provided?
- Clear sequencing?

### 3. Start Implementation

```
Follow INDEX.md in @.agent-project-docs/<project-slug>/ and implement the next priority task.
Update PROGRESS.md and NEXT_STEPS.md after each task.
If you need to ask the engineering team for clarification, more information, a decision, or a recommendation, ask as soon as possible before you continue.
```

### 4. Review and Update Documentation (Optional)

```
Look at @.agent-project-docs/<project-slug>/INDEX.md, @.agent-project-docs/<project-slug>/PROGRESS.md, @.agent-project-docs/<project-slug>/NEXT_STEPS.md, and related files.
Given the current status of the project, is there anything that needs to be updated?
If so, update the relevant files.
If you need to update the plan, update @.agent-project-docs/<project-slug>/INDEX.md, @.agent-project-docs/<project-slug>/PROGRESS.md, and @.agent-project-docs/<project-slug>/NEXT_STEPS.md.
If you need to ask the engineering team for clarification, more information, a decision, or a recommendation, ask as soon as possible before you continue.
```

---

## Core Documentation Structure

### Essential Files (Always Create)

1. **INDEX.md** - Agent's entry point

   - Quick start workflow
   - Implementation patterns (with code examples)
   - Links to other docs
   - Keep to 1-2 pages max

2. **PROGRESS.md** - Live progress tracker
   - What's completed (with dates)
   - What's in progress
   - What's pending (prioritized)
   - Progress percentage and time estimates
   - Update after EVERY task

### Optional Files (Only If Needed)

3. **NEXT_STEPS.md** - For complex projects (10+ tasks)

   - Numbered task list with exact instructions
   - Code snippets for each task
   - File paths and line numbers
   - Testing criteria per task

4. **[FEATURE]\_GUIDE.md** - For reusable patterns

   - When agent will use same pattern 5+ times
   - Code examples
   - Common pitfalls
   - Testing approach

5. **[FEATURE]\_SUMMARY.md** - Quick reference
   - Permission matrices
   - Decision tables
   - Backend verification status

### Files to AVOID Creating

❌ **ANALYSIS.md** - Too verbose, info goes in PROGRESS.md
❌ **FILES.md** - File lists go in NEXT_STEPS.md with tasks
❌ **IMPLEMENTATION.md** - Exact code goes in NEXT_STEPS.md
❌ Multiple overlapping docs - Consolidate!

---

## Keeping Agent On Track

### After each task:

```
Mark task X as complete in PROGRESS.md.
Update the percentage complete.
Show me what you did and what's next.
```

### When priorities change:

```
Update PROGRESS.md: move [task] to high priority because [reason].
Add note to reprioritization log.
```

### When agent gets stuck:

```
Document the blocker in PROGRESS.md under "Issues & Blockers".
Describe what you tried.
Ask me for guidance.
```

### To check progress:

```
Show current completion percentage and next 3 tasks from PROGRESS.md.
```

### To give feedback:

```
In [file], [specific issue]. Fix it to [correct approach].
Document this pattern in PROGRESS.md so you remember.
```

### After context limit or long break:

```
Read all files in @.agent-project-docs/<project-slug>/ starting with INDEX.md.
Summarize: what's done, current state, next priority.
```

---

## Documentation Best Practices

### ✅ DO

**Keep it focused:**

- Each file has ONE clear purpose
- Remove info once it's no longer useful
- Consolidate overlapping content

**Make it action-oriented:**

- "Do this next" >> "Here's background info"
- Code snippets >> Long explanations
- Step-by-step >> Comprehensive analysis

**Track progress visibly:**

- Update percentage after each task
- Show remaining time estimates
- Mark completed items immediately

**Provide examples:**

- Code patterns with actual syntax
- Copy-paste ready snippets
- Working reference implementations

### ❌ DON'T

**Create noise:**

- Don't make 10 docs when 5 will do
- Don't duplicate info across files
- Don't keep outdated info

**Be vague:**

- Don't say "update the file" - give line numbers
- Don't say "follow the pattern" - show the code
- Don't say "implement X" - break into steps

**Lose track:**

- Don't batch progress updates
- Don't let PROGRESS.md get stale
- Don't skip updating completion percentage

---

## When to Use This Template

✅ **Use for:**

- Multi-day projects (3+ hours of work)
- 10+ files to modify
- Unclear scope needing research
- Complex refactoring across modules
- Projects spanning multiple sessions

❌ **Skip for:**

- Single file changes
- Quick bug fixes (< 1 hour)
- Well-defined small tasks
- Simple find-and-replace operations

---

## Example: Good vs Bad Structure

### ❌ Bad (Too Much)

```
.agent-project-docs/<project>/
├── INDEX.md
├── PROGRESS.md
├── PROJECT_OVERVIEW.md       ← Redundant with INDEX
├── PROJECT_ANALYSIS.md        ← Too verbose
├── PROJECT_FILES.md           ← Belongs in NEXT_STEPS
├── PROJECT_IMPLEMENTATION.md  ← Belongs in NEXT_STEPS
├── PROJECT_TESTING.md         ← Belongs in PROGRESS
├── PROJECT_DECISIONS.md       ← Belongs in PROGRESS
└── PROJECT_NOTES.md           ← Belongs in PROGRESS
```

### ✅ Good (Focused)

```
.agent-project-docs/<project>/
├── INDEX.md          ← Quick start + patterns
├── PROGRESS.md       ← Live tracking + decisions
├── NEXT_STEPS.md     ← Task-by-task guide (if complex)
└── HOOKS_GUIDE.md    ← Reusable pattern guide (if needed)
```

---

## Template Update Log

### 2025-12-23

- Restructured to use `.agent-project-docs/` umbrella directory
- Templates now live in `_templates/` subdirectory
- Updated all path references for new structure

### 2025-10-23

- Added learnings from readonly-frontend project
- Emphasized action-oriented documentation
- Recommended NEXT_STEPS.md for complex projects
- Discouraged verbose ANALYSIS/FILES/IMPLEMENTATION docs
- Added examples of good vs bad structure

### 2025-10-22

- Initial template creation

---

Last Updated: 2025-12-23
