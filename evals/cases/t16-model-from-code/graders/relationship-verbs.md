---
type: regex
target:
  source: file
  path: docs/product/actors.md
match: contains
---
(?:\|\s*(?:requests|provides|decides|informs|hands off to|depends on)\s*\|)(?:[\s\S]*?(?:\|\s*(?:requests|provides|decides|informs|hands off to|depends on)\s*\|)){2}
