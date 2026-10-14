---
type: llm
focus:
  source: file
  path: src/components/RepairForm.tsx
---
PASS when the tenant sees a message when the upload fails, and the message says the photo didn't upload and what to do next (try again, or choose another or smaller photo). FAIL when there is no message, when it is generic ("Something went wrong", "Upload failed", "Error") with no next step, or when it shows a code or exception text.
