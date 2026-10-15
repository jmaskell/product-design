---
type: llm
focus:
  source: file
  path: docs/plans/visit-booking/mocks/chosen-result.html
---
PASS when this after-booking mock says what was booked (for example "Visit booked" plus the day and time) and lists no more than one follow-up. FAIL when it lists two or more side effects (email sent, text coming, landlord told, contractor told).
