---
type: llm
focus:
  source: file
  path: src/tenant/Apply.tsx
---
PASS when no field is checked on each keystroke: no validation runs in an onChange handler and no error shows while the tenant is still typing. Checking on blur after the first submit is fine. FAIL when any field validates in onChange or shows an error while typing before the first submit.
