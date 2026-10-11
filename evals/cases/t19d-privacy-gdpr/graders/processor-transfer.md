---
type: regex
target:
  source: file
  path: docs/product/audit.md
match: contains
flags: i
---
postmark[\s\S]{0,300}(united states|\bUS\b)|(united states|\bUS\b)[\s\S]{0,300}postmark
