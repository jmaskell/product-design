---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/review.html
match: count:0
flags: is
---
changed since(?:(?!<h[1-3]).)*?decisions? \d
