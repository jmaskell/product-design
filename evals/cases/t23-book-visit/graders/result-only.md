---
type: llm
focus:
  source: file
  path: src/components/BookVisit.tsx
---
PASS when the booked state says what was booked (for example "Visit booked" plus the day and time) and lists no more than one follow-up (for example the text reminder). FAIL when it lists two or more side effects (email sent, text coming, landlord told, contractor told).
