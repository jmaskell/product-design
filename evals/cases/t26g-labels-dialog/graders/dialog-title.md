---
type: llm
focus:
  source: file
  path: src/tenant/SavedSearches.tsx
---
PASS when the confirm dialog's title names the action or the saved search (for example 'Delete "2-bed in Leeds"?'). FAIL when the title is generic, such as 'Are you sure?' or 'Confirm'.
