---
type: llm
focus:
  source: file
  path: src/tenant/SavedSearches.tsx
---
PASS when no button label contains 'the', 'a' or 'your' (for example 'Delete search', not 'Delete the search' or 'Delete your search'). FAIL when any button label contains one of those words.
