---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/review.html
match: contains
flags: is
---
<h[1-3][^>]*>\s*summary.*?<h[1-3][^>]*>\s*who.{0,8}s involved.*?<h[1-3][^>]*>[^<]*journey.*?<h[1-3][^>]*>\s*screens.*?<h[1-3][^>]*>\s*questions
