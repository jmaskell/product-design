---
type: regex
target:
  source: file
  path: docs/product/actors.md
match: contains
---
(?:\b[A-Z]{1,2}\d\b)(?:[\s\S]*?(?:\b[A-Z]{1,2}\d\b)){2}
