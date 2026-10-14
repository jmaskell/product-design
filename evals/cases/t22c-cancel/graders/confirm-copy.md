---
type: llm
focus:
  source: file
  path: src/components/CancelRepair.tsx
---
PASS when all three hold: (1) the confirmation names the repair (its category or the word "repair") and says that cancelling can't be undone or what is lost; (2) the button that cancels the repair repeats the verb with its object, for example "Cancel repair"; (3) the button that closes without cancelling is not a bare "Cancel", "No", "Close" or "OK", and says what it keeps, for example "Keep repair". FAIL when any of the three fails.
