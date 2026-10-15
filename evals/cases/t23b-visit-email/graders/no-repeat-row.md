---
type: llm
focus:
  source: file
  path: src/email/visit-booked.ts
---
Judge the heading and the body only. Ignore the subject line.
PASS when no labelled row or line in the body (for example "Day:", "Date:", "Time:", "When:", "Contractor:") repeats the day, time or contractor that the heading already gives. FAIL when the heading gives them and the body then lists any of them again.
