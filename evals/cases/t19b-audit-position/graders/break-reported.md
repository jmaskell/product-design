---
type: regex
target:
  source: file
  path: docs/product/audit.md
match: contains
---
purge-tenants\.ts[\s\S]{0,400}6 years|6 years[\s\S]{0,400}purge-tenants\.ts
