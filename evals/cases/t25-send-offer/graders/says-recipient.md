---
type: llm
focus:
  source: file
  path: src/agent/SendOffer.tsx
---
PASS when, before the agent presses the send button, the screen names who will be emailed (the applicant's name or email address) in a line near the button. FAIL when the screen doesn't say who receives the email before the press.
