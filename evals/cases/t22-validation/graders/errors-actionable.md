---
type: llm
focus:
  source: file
  path: src/components/RepairForm.tsx
---
PASS when every validation message the change adds tells the tenant what to do to fix the input (for example, names the minimum length, or says to choose a photo under 10MB), in plain words. FAIL when any message only states the problem ("Invalid", "Required", "Too short", "File too large"), shows an error code, or blames the tenant ("You entered…").
