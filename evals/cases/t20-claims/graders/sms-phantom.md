---
type: regex
target:
  source: file
  path: docs/product/audit.md
match: contains
flags: i
---
SMS[\s\S]{0,300}phantom|phantom[\s\S]{0,300}SMS
