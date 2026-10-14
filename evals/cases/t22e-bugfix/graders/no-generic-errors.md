---
type: regex
target:
  source: file
  path: src/components/RepairForm.tsx
match: count:0
flags: i
---
something went wrong|an error (?:has )?occurred|\berror \d{3}\b
