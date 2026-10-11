---
type: regex
target:
  source: file
  path: docs/product/audit.md
match: contains
flags: is
---
(?:250[\s\S]{0,600}500[\s\S]{0,600}rules\.ts|rules\.ts[\s\S]{0,600}(?:250[\s\S]{0,600}500|500[\s\S]{0,600}250)|500[\s\S]{0,600}250[\s\S]{0,600}rules\.ts)
