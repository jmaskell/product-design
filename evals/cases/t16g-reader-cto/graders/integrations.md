---
type: llm
focus:
  source: file
  path: docs/product/actors.md
---
PASS when the file records the email provider as an actor or integration, names Postmark (or "the email provider"), and notes that it is in the United States or outside the UK. FAIL when no email provider is recorded, or the US location is missing.
