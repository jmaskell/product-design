---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/review.html
match: contains
flags: is
---
<h[1-3][^>]*>[^<]*summary.*?<h[1-3][^>]*>[^<]*who.{0,8}s involved.*?<h[1-3][^>]*>[^<]*journey.*?<h[1-3][^>]*>[^<]*screens.*?<h[1-3][^>]*>[^<]*questions
