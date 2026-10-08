---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/review.html
match: contains
flags: is
---
summary.*?who.{0,8}s involved.*?journey.*?screens.*?questions
