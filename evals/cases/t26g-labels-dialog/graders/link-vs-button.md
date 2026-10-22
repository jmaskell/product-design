---
type: llm
focus:
  source: file
  path: src/tenant/SavedSearches.tsx
---
PASS when deleting is a <button>, and opening a saved search is a link (an <a> or router Link) if it goes to a separate page, or a button if it expands the search's homes in place. FAIL when deleting is a link, or when opening goes to a separate page through a button.
