# [PROJECT NAME] - Next Steps

**Current Status:** X% Complete (X/Y tasks)
**Next Priority:** [Module/Feature Name]
**Estimated Remaining Time:** X-Y hours

---

## 🎯 What To Do Next

Start with **Task 1** below and work through sequentially.

---

## Task 1: [Short Descriptive Name] (X min)

### File

`/absolute/path/to/file.tsx`

### What to Do

[One sentence describing the change]

### Implementation

1. Import the required items:

```typescript
import { something } from "@/somewhere";
import { another } from "@/another-place";
```

2. Add the hook/state (around line XX):

```typescript
const { value, action } = useSomething();
```

3. Find [specific element] (around line YY) and wrap/modify it:

```typescript
{
  value && <Component onClick={action}>Do Thing</Component>;
}
```

### Test

- [Specific test case 1]
- [Specific test case 2]
- [What should NOT work]

---

## Task 2: [Next Task] (X min)

### File

`/absolute/path/to/file.tsx`

### What to Do

[Description]

### Implementation

[Same structure as Task 1]

---

## Task 3: [Complex Task] (XX min) ⚠️ COMPLEX

### File

`/absolute/path/to/complex-file.tsx`

### What to Do

[Multiple changes needed]

### Implementation Steps

#### Step 1: [First Part]

```typescript
// Code for first part
```

#### Step 2: [Second Part]

```typescript
// Code for second part
```

#### Step 3: [Third Part]

```typescript
// Code for third part
```

### Test

- [Comprehensive test cases for complex task]

---

## Lower Priority Tasks (Optional)

These can be done later if time permits:

### Task X: [Lower Priority] (X min)

**File:** `/path/to/file.tsx`

- [Brief description of what to do]

### Task Y: [Another Optional] (X min)

**File:** `/path/to/file.tsx`

- [Brief description]

---

## 📋 After Each Task

1. Save the file
2. Run: `npm run lint:fix` (or appropriate command)
3. Check for TypeScript errors
4. Update `PROGRESS.md` - mark task complete, update percentage
5. Test manually if possible
6. Move to next task

---

## 🎯 Completion Checklist

- [ ] Task 1: [Name]
- [ ] Task 2: [Name]
- [ ] Task 3: [Name]
- [ ] Task 4: [Name]
- [ ] ...
- [ ] Optional Task X (if time)
- [ ] Optional Task Y (if time)

---

## 🚀 When All Core Tasks Are Done

1. Run full build: `npm run build` (or appropriate)
2. Test with all [relevant scenarios]
3. Update PROGRESS.md to 100%
4. Show human what was completed

---

## 📋 Instructions for Planning Agent

When creating this file:

### 1. Only Create This File If:

- Project has 10+ distinct tasks
- Tasks are complex enough to need detailed instructions
- Code snippets would be helpful (not obvious)

### 2. For Each Task Include:

- **Exact file path** (absolute, not relative)
- **Line numbers** (approximate, note they may shift)
- **Code snippets** (copy-paste ready, not pseudo-code)
- **Specific test cases** (not "test it works")

### 3. Organize by Priority:

- High priority tasks first
- Optional tasks at the end
- Group related tasks together

### 4. Make It Actionable:

```
✅ Good: "Wrap the Delete button (line 86) with PermissionTooltip"
❌ Bad: "Add permission checks to buttons"

✅ Good: "Import useTeamPermissions from @/hooks/useTeamPermissions"
❌ Bad: "Import the permissions hook"

✅ Good: "Test with read_only role - button should be hidden"
❌ Bad: "Test that it works for different roles"
```

### 5. Include Code Context:

- Show imports at the top
- Show where hook is called
- Show complete component structure if complex
- Include the wrapping/parent elements

### 6. Estimate Time Realistically:

- Simple button disable: 5-10 min
- Modal update: 10-15 min
- Complex component: 30-60 min
- Entire page refactor: 60-90 min

### 7. Mark Complex Tasks:

Use ⚠️ COMPLEX flag for tasks that:

- Touch 5+ places in one file
- Require understanding context
- Have multiple implementation steps
- Could easily go wrong

### 8. Delete This Section

Remove "Instructions for Planning Agent" before saving.

---

Template Version: 2025-12-23
