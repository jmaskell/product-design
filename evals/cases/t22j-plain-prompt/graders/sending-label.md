---
type: llm
focus:
  source: file
  path: src/components/RepairForm.tsx
---
PASS when the button's sending-state label says what is happening to the person's report with a verb (for example "Sending report…" or "Reporting repair…"). FAIL when it is generic ("Loading…", "Please wait", "Submitting…", "Processing…") or the change adds no sending-state label.
