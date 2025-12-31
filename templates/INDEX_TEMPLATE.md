# [PROJECT NAME] - Index

**Current Status:** 0% Complete (0/X tasks done)
**Last Updated:** [YYYY-MM-DD]

---

## 🎯 Quick Start

**You are:** Implementing [brief project description]

**Start here:**

1. Read `PROGRESS.md` - See what's done and what's next
2. Read `NEXT_STEPS.md` - Get exact next task with code snippets
3. Implement the changes
4. Update `PROGRESS.md` and `NEXT_STEPS.md` - Mark complete, update percentage, reorder tasks, make changes. This step is essential. You will often discover things while implementing that will change the plan or raise new questions about implementation. You should update the plan as much as possible and reorganize `PROGRESS.md` and `NEXT_STEPS.md` as needed. Surface all questions and important changes to the human.

---

## 📁 Documentation Files

### PROGRESS.md ⭐ **START HERE**

- Current completion status
- What's been implemented
- What remains (prioritized)
- Detailed completion tracking

### NEXT_STEPS.md 📋 **THEN GO HERE** (if exists)

- Prioritized list of remaining tasks
- Exact files and line numbers
- Code snippets for each task
- Recommended implementation order

### [FEATURE]\_GUIDE.md 📚 (if exists)

- How to use [specific patterns/hooks/components]
- Code examples
- Common pitfalls
- Testing approach

---

## ✅ Implementation Patterns

**[REPLACE THIS SECTION WITH 2-3 ACTUAL CODE PATTERNS FROM YOUR PROJECT]**

All the infrastructure is built. Just apply these patterns:

### Pattern 1: [Most Common Pattern]

```typescript
// Example code showing the pattern
import { something } from "@/somewhere";

const { value } = useSomething();

<Component disabled={!value}>Action</Component>;
```

### Pattern 2: [Second Most Common]

```typescript
// Another example
{
  condition && <Component>Action</Component>;
}
```

### Pattern 3: [Third Pattern] (optional)

```typescript
// Third example if needed
```

---

## 🔧 Available Tools

**[REPLACE WITH ACTUAL TOOLS/HOOKS/UTILITIES FOR YOUR PROJECT]**

### Hooks

- `useXYZ()` → Returns `{ a, b, c }`
- `useABC(id)` → Returns `{ x, y, z }`

### Components

- `<MyWrapper>` → Purpose and usage

### Utilities

- `CONSTANTS` from `@/path` → What they're for

---

## 🚦 Implementation Rules

### Always:

- ✅ Check `PROGRESS.md` before starting
- ✅ Update `PROGRESS.md` after completing each task
- ✅ Update completion percentage
- ✅ Use existing patterns (see above)
- ✅ Test with [specific testing approach]
- ✅ Run `npm run lint:fix` after changes (or relevant command)

### Never:

- ❌ Skip tasks - do them in order
- ❌ Create new patterns - use existing ones
- ❌ Batch completions - update after each task
- ❌ Use try-except or fallbacks (per project rules)

---

## 📊 Current Progress Summary

| Module     | Status         | Files |
| ---------- | -------------- | ----- |
| [Module 1] | ⏳ Not Started | 0/X   |
| [Module 2] | ⏳ Not Started | 0/X   |
| [Module 3] | ⏳ Not Started | 0/X   |

**Next Priority:** [What to do first]

---

## 🎯 Success Criteria

- [ ] [Specific requirement 1]
- [ ] [Specific requirement 2]
- [ ] [Specific requirement 3]
- [ ] No regressions in [what to preserve]
- [ ] All tests pass
- [ ] Build succeeds without errors

---

## 📞 When You Get Stuck

1. Check `PROGRESS.md` for notes and patterns
2. Check `[GUIDE].md` for examples (if exists)
3. Document blocker in `PROGRESS.md` under "Issues & Blockers"
4. Ask the human for clarification

---

## Project Context

**Purpose:** [1-2 sentence description of what this achieves]

**Key Constraints:**

- [Constraint 1 - e.g., must maintain backward compatibility]
- [Constraint 2 - e.g., follow existing pattern from FileX.tsx]
- [Constraint 3 - e.g., no breaking changes to API]

**Architecture Notes:**

- [How this fits into the system]
- [What layer is responsible for what]
- [Security/performance considerations]

---

**Last Updated:** [YYYY-MM-DD]

---

## 📋 Instructions for Planning Agent

When you create this INDEX.md for a new project:

### 1. Copy Template Structure

Copy this file to `.agent-project-docs/<project-slug>/INDEX.md`

### 2. Fill In Project Info

- **Title**: Replace `[PROJECT NAME]` with actual name
- **Status**: Set to `0% Complete (0/X tasks done)` initially
- **Quick Start**: Write 1 sentence describing what's being implemented

### 3. Add Real Implementation Patterns

**CRITICAL**: Don't leave generic examples!

- Find 2-3 most common patterns in the codebase
- Copy actual code (not pseudo-code)
- Show imports, hook usage, component structure
- Make it copy-paste ready

### 4. Document Available Tools

List actual hooks/components/utilities:

- Their exact import paths
- What they return/do
- When to use them

### 5. Set Up Progress Table

- List actual modules that will be changed
- Count actual files per module
- Set realistic priorities

### 6. Define Success Criteria

- Specific, measurable requirements
- What must still work (no regressions)
- Testing requirements

### 7. Add Project Context

- Why this change is needed
- Critical constraints (backward compatibility, patterns to follow)
- Architecture considerations
- Security/performance notes

### 8. Create Companion Files

**Always create:**

- `PROGRESS.md` with detailed task breakdown

**Create if 10+ tasks:**

- `NEXT_STEPS.md` with step-by-step instructions and code snippets

**Create if reusable pattern:**

- `[FEATURE]_GUIDE.md` with comprehensive examples
- `[FEATURE]_SUMMARY.md` with quick reference

**Don't create:**

- Verbose analysis documents
- Redundant file lists
- Implementation docs (put in NEXT_STEPS instead)

### 9. Keep It Focused

- INDEX.md should be 1-2 pages max
- Action-oriented (do this) not academic (here's why)
- Examples over explanations
- Show, don't tell

### 10. Remove This Section

Delete "Instructions for Planning Agent" before saving.

---

Template Version: 2025-12-23
