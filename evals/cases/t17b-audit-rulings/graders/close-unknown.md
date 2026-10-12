---
type: regex
target:
  source: file
  path: docs/product/journeys/repair-fixed.md
match: contains
flags: i
---
UNKNOWN[^\n]*\bF\d+|\bF\d+[^\n]*UNKNOWN
