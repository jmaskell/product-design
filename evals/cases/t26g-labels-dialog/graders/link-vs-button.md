---
type: llm
focus:
  source: file
  path: src/tenant/SavedSearches.tsx
---
PASS when opening a saved search is a link (an <a> or router Link that goes to its homes) and deleting is a <button>. FAIL when opening is a button or deleting is a link.
