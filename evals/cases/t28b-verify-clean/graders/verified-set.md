---
type: regex
target:
  source: file
  path: docs/plans/refund-request/journey.md
match: contains
flags: m
---
^verified:\s*\d{4}-\d{2}-\d{2}
