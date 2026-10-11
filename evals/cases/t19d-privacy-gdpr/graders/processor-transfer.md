---
type: regex
target:
  source: file
  path: docs/product/audit.md
match: contains
---
[Pp]ostmark[\s\S]{0,300}(United States|\bUS\b|\bUSA\b)|(United States|\bUS\b|\bUSA\b)[\s\S]{0,300}[Pp]ostmark
