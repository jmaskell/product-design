---
type: regex
target:
  source: file
  path: docs/plans/visit-booking/mocks/chosen-check.html
match: contains
---
(?:href|action)="[^"]*chosen-result\.html[^"]*"
