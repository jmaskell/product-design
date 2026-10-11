---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/decisions.md
match: contains
---
Finding \(Tom Reed, comment[^\n]*\b(?:CRITICAL|SIGNIFICANT|MINOR|UNKNOWN)\b
