---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/decisions.md
match: contains
---
Finding \(Priya Shah, comment[^\n]*\b(?:CRITICAL|SIGNIFICANT|MINOR|UNKNOWN)\b
