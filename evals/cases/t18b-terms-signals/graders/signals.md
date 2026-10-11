---
type: regex
target:
  source: file
  path: docs/product/actors.md
match: contains
---
(?:Signal:[^\n]*source)(?:[\s\S]*?Signal:[^\n]*source){2}
