---
type: llm
focus:
  source: file
  path: src/tenant/AddressForm.tsx
---
PASS when the tenant isn't asked to type the county: the county field is left out, or it is filled from the postcode lookup and the tenant doesn't have to enter it. FAIL when the form shows an empty county field the tenant must fill in.
