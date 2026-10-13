---
type: llm
focus:
  source: file
  path: src/components/RepairsList.tsx
---
PASS when the state shown for a tenant with no repairs says plainly that there are no repairs, and offers at most one action (for example, report a repair), with no more than two short lines of text. FAIL when it offers more than one action, includes a pep or reassurance line ("Good news!", "All caught up", "Nothing to worry about", an emoji), or runs longer than two lines.
