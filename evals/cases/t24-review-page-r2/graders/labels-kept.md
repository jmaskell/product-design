---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/review.html
match: contains
---
(?:KNOWN \(|INFERRED \(|ASSUMED|UNKNOWN)(?:[\s\S]*?(?:KNOWN \(|INFERRED \(|ASSUMED|UNKNOWN)){3}
