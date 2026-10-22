---
type: llm
focus:
  source: file
  path: src/components/RepairForm.tsx
---
PASS when the form shows a busy state as soon as the upload starts and shows progress (a percentage, a bar, or a running status) while it uploads. FAIL when there is only a spinner with no progress, or nothing shows until the upload ends.
