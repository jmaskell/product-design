---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/issue.md
match: count:0
flags: im
---
^\s*(?:#+\s*)?(?:\|\s*)?(?:[-*]\s*)?(?:\*\*)?(?:status|gate(?:\s+G[12])?|G[12])(?:\*\*)?\s*[:|]?\s*(?:\*\*)?\s*approved\b
