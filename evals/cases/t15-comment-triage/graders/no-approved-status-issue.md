---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/issue.md
match: count:0
flags: im
---
^\s*(?:[-*]\s*)?(?:\*\*)?(?:status|gate|G[12])\b[^\n]*\bapproved\b
