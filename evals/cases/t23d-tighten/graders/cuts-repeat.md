---
type: llm
focus:
  source: file
  path: src/components/ConfirmVisit.tsx
---
PASS when the sentence "You're about to book {contractor} for {when}." is gone, and no other sentence restates the booking (who and when together) that the list already shows. A line that names the contractor for another reason, such as the line with the phone number, does not count as a repeat. FAIL when the "You're about to book…" sentence, or a shortened form of it, is still there.
