---
type: llm
focus:
  source: file
  path: src/tenant/AddressForm.tsx
---
PASS when the tenant is never required to type the county: the county field is left out, filled from the postcode lookup, or optional for manual entry after a failed lookup. FAIL when the form requires the tenant to type a county.
