---
type: regex
target:
  source: file
  path: docs/product/audit.md
match: contains
---
^(?=[\s\S]*\b250\b)(?=[\s\S]*\b500\b)(?=[\s\S]*rules\.ts)
