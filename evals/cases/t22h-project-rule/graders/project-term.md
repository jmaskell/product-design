---
type: llm
focus:
  source: file
  path: src/email/contractor-reminder.ts
---
PASS when the email's subject and body text call the work a "job" and never use the word "repair" or "repairs". Code identifiers (variable, parameter and function names) do not count. FAIL when the subject or body text says "repair", or never names the work as a job.
