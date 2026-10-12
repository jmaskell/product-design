---
type: regex
target:
  source: file
  path: docs/product/journeys/repair-fixed.md
match: contains
flags: im
---
^\|.*(?:48\s*h|daily|remind|chase).*\|\s*$
