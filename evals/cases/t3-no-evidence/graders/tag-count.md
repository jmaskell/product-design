---
type: regex
target:
  source: file
  path: docs/plans/repair-frustration/issue.md
match: contains
---
(?:KNOWN \(|INFERRED \(|ASSUMED|UNKNOWN)(?:[\s\S]*?(?:KNOWN \(|INFERRED \(|ASSUMED|UNKNOWN)){4}
