---
type: regex
target:
  source: file
  path: docs/plans/contractor-date/review.html
match: contains
flags: is
---
<details(?![^>]*\bopen\b)[^>]*>.*?<table.*?</details>
