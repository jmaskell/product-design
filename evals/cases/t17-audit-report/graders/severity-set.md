---
type: regex
target:
  source: file
  path: docs/product/audit.md
match: contains
---
\b(?:CRITICAL|SIGNIFICANT|MINOR)\b[\s\S]*?\b(?:CRITICAL|SIGNIFICANT|MINOR)\b
