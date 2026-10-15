---
type: llm
focus:
  source: file
  path: src/components/ConfirmVisit.tsx
---
PASS when the heading of the check step (the screen before the booking is made) says the booking is not made yet, for example "Confirm your visit" or "Book this visit?". FAIL when the heading reads as if the visit is already booked or only asks the person to look ("Check your visit", "Your visit", "Visit details").
