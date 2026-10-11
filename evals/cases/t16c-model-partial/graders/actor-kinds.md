---
type: regex
target:
  source: file
  path: docs/product/actors.md
match: contains
---
(?:\|\s*(?:user|internal role|external actor|system)\s*\|)(?:[\s\S]*?(?:\|\s*(?:user|internal role|external actor|system)\s*\|)){2}
