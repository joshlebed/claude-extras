# Code Agent Quick Start - Planning & Setup

**You are:** A planning agent creating documentation for a code implementation project.

## Your Task

Create a complete documentation structure for the project the human described.

## Steps

### 1. Create Directory Structure

```bash
mkdir -p .agent-project-docs/<project-slug>
```

The `.agent-project-docs/` directory should already exist with `_templates/` inside.

### 2. Create These Files

1. **INDEX.md** - Copy from `.agent-project-docs/_templates/INDEX_TEMPLATE.md` and customize
2. **PROGRESS.md** - Create from structure below
3. **[PROJECT]\_OVERVIEW.md** - High-level summary (1-2 pages)
4. **[PROJECT]\_ANALYSIS.md** - Detailed feature analysis (3-5 pages)
5. **[PROJECT]\_FILES.md** - Prioritized file list with estimates
6. **[PROJECT]\_IMPLEMENTATION.md** - Exact locations with line numbers

### 3. Naming Conventions

Replace placeholders:

- `[PROJECT NAME]`: "ReadOnly Role Support"
- `<project-slug>`: "readonly-support" (for directory: `.agent-project-docs/readonly-support`)
- `[PROJECT]`: "READONLY" (for file prefixes: `READONLY_OVERVIEW.md`)
- `[project]`: "readonly support" (in prose)

### 4. Analyze the Codebase

**Be thorough:**

- Search for all relevant files
- Understand current patterns
- Identify dependencies
- Find edge cases
- Look for similar existing implementations

**Document in ANALYSIS.md:**

- Current state of each feature
- What needs to change
- Why it needs to change
- How to implement it
- Risks and gotchas

### 5. Create PROGRESS.md Structure

```markdown
# [Project Name] - Progress Tracker

**Last Updated:** YYYY-MM-DD
**Overall Status:** 0% Complete
**Estimated Total:** X-Y hours

---

## ✅ Completed Items

_None yet_

---

## 🚧 In Progress

_None yet_

---

## ⏳ Pending - High Priority

### [Feature Area 1]

- [ ] **[Specific task]**
  - File: `path/to/file.ts`
  - Action: Brief description
  - Est: X min
  - Priority: High because [reason]

### [Feature Area 2]

...

---

## ⏳ Pending - Medium Priority

[Same structure]

---

## ⏳ Pending - Low Priority

[Same structure]

---

## 🎯 Next Priority

**Start here when implementing:**

1. [First task] (Est: X min)
2. [Second task] (Est: X min)
3. [Third task] (Est: X min)

---

## 📝 Implementation Notes

### Patterns to Follow

- [Existing pattern 1 from codebase]
- [Existing pattern 2 from codebase]

### Testing Checklist

- [ ] [Test approach 1]
- [ ] [Test approach 2]

---

## 🔄 Reprioritization Log

### YYYY-MM-DD - Initial Planning

- **High Priority:** [Reasoning - usually core functionality]
- **Medium Priority:** [Reasoning - usually nice-to-haves]
- **Low Priority:** [Reasoning - usually polish/optimization]

---

## 💡 Decisions & Assumptions

- [Key decision 1 and rationale]
- [Key assumption 1 that might need validation]
```

### 6. Prioritization Guidelines

**High Priority:**

- Core functionality that must work
- Breaking changes that block other work
- Security or data integrity issues
- Features users will immediately notice

**Medium Priority:**

- Nice-to-have improvements
- Edge cases for core features
- Developer experience improvements
- Non-critical UI polish

**Low Priority:**

- Optimizations
- Cleanup and refactoring
- Documentation
- Future-proofing

### 7. Time Estimation

**Be realistic:**

- Simple file change: 5-15 min
- Component update: 15-30 min
- New component: 30-60 min
- Complex refactor: 1-2 hours
- Add 50% buffer for unknowns

**Total estimates:**

- Give ranges (e.g., "14-19 hours")
- Break into phases if > 8 hours
- Note dependencies

### 8. FILES.md Format

```markdown
# [Project Name] - Files to Modify

## High Priority (X-Y hours)

### path/to/file1.ts (Est: 20 min)

- Add [specific feature]
- Update [specific code]
- [Why it's needed]

### path/to/file2.tsx (Est: 45 min)

- [Changes needed]

## Medium Priority (X-Y hours)

[Same structure]

## Low Priority (X-Y hours)

[Same structure]
```

### 9. IMPLEMENTATION.md Format

````markdown
# [Project Name] - Implementation Details

## Feature 1: [Name]

### File: /absolute/path/to/file.ts

**Lines 45-60** (approximate)

```typescript
// Current code excerpt
```
````

**Action:** Add null check before accessing property

**New code:**

```typescript
// Example of what to add
```

**Priority:** High
**Estimate:** 10 min

---

## Feature 2: [Name]

[Same structure]

```

### 10. Quality Checks

Before showing human:
- [ ] All file paths are absolute
- [ ] Time estimates are realistic
- [ ] Priorities have clear reasoning
- [ ] Patterns from codebase are documented
- [ ] Testing approach is specified
- [ ] Next 3-5 priorities are clear
- [ ] No placeholders like [TODO] remain
- [ ] INDEX.md has project-specific info

### 11. Report to Human

Show them PROGRESS.md and summarize:
```

Created [project] documentation in .agent-project-docs/<project-slug>/:

Summary:

- Total estimated work: X-Y hours across Z files
- High Priority: A hours (core features)
- Medium Priority: B hours (enhancements)
- Low Priority: C hours (polish)

Next priorities:

1. [First item] (X min)
2. [Second item] (Y min)
3. [Third item] (Z min)

Ready to start implementation when you approve.

```

---

## Common Mistakes to Avoid

❌ Vague tasks like "update authentication"
✅ Specific tasks like "Add isReadOnly check to login handler (LoginPage.tsx:45)"

❌ Missing time estimates
✅ Every task has realistic estimate

❌ No explanation of priorities
✅ Each priority level has reasoning

❌ Copying patterns without understanding
✅ Document actual patterns found in THIS codebase

❌ Line numbers without file context
✅ Full path + line range + what to change

---

Last Updated: 2025-12-23
```
