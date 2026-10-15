---
type: llm
focus:
  source: file
  path: src/email/visit-booked.ts
---
Judge the heading and the body only. Ignore the subject line. In code that builds both a text and an HTML version, judge each version on its own.
PASS when each fact (day, time, contractor) appears once in the heading and body together. FAIL when any of them appears twice.
