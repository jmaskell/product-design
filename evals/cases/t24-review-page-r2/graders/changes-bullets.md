---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/review.html
match: contains
flags: is
---
<h[1-3][^>]*>[^<]*changed since[^<]*</h[1-3]>\s*<ul>(?:\s*<li>.*?</li>){3,}\s*</ul>
