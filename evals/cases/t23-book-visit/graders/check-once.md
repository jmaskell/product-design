---
type: llm
focus:
  source: file
  path: src/components/BookVisit.tsx
---
PASS when the check step shows the booking details (day, time) once and then a book button. FAIL when the check step repeats those details in a second sentence or list (for example "You're about to…", "You are booking…"), or lists the email and text there as well as on the result.
