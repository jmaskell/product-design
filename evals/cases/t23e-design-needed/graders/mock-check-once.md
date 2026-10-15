---
type: llm
focus:
  source: file
  path: docs/plans/visit-booking/mocks/chosen-check.html
---
PASS when this check-step mock shows the booking details (day, time) once and then a book button. FAIL when it repeats those details in a second sentence or list (for example "You're about to…"), or lists the email and text that will follow.
