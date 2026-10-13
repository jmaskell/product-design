---
type: regex
target:
  source: file
  path: src/components/RepairForm.tsx
match: count:0
flags: i
---
["'`>][^"'`<>{}\n]*(?:\binvalid\b|something went wrong|an error (?:has )?occurred)
