---
type: llm
focus:
  source: file
  path: docs/plans/contractor-date/review.html
---
PASS when the Summary section is a list or short lines (outcome, trigger, today, this change), each sentence 20 words or fewer, with the evidence labels kept. FAIL when a sentence joins two unrelated facts (for example the trigger and the scope), or a sentence passes 20 words. A sentence that describes one action in two verbs ("searches email and reads the date out") is one fact.
