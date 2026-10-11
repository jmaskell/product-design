---
type: regex
target:
  source: file
  path: docs/product/audit.md
match: contains
flags: i
---
40%[\s\S]{0,300}UNKNOWN|UNKNOWN[\s\S]{0,300}40%
