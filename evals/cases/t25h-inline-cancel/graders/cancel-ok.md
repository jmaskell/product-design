---
type: llm
focus:
  source: file
  path: src/agent/ApplicantPage.tsx
---
PASS when the button that closes the inline confirm without withdrawing reads 'Cancel'. FAIL when it reads anything else, such as 'Keep applicant', 'Go back', 'No' or 'Don't withdraw'.
