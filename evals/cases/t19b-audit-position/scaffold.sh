#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../../fixtures/model-rules.sh" overlay
LINE='- Lost-key fee. Rule: a lost-key charge may cover reasonable costs only. Source: Tenant Fees Act 2019, Schedule 1. Interpretation: a flat £45 fee is a reasonable cost; it is below our average locksmith invoice (£62 in 2025). Why the risk is acceptable: the fee is under the evidenced cost. KNOWN (owner, 2026-09-01)
- Tenant data retention. Rule: keep personal data no longer than needed. Source: UK GDPR Article 5(1)(e). Interpretation: we keep tenant records for 6 years after the tenancy ends (the limitation period), then delete them. KNOWN (owner, 2026-09-01)'
export LINE
perl -0pi -e 's/\n\n## Evidence on Hand/\n$ENV{LINE}\n\n## Evidence on Hand/' PRODUCT.md
cat >> PRODUCT.md <<'T'

## Terms
| Term | Meaning | Avoid | Code name |
|---|---|---|---|
| Repair | A problem a tenant reports and the agency gets fixed | ticket, job | repairs |
T
SIG='
Signals:
- T1 Signal: repairs closed with no tenant chase (source: event repair_closed)
- A1 Signal: repairs reported per week (source: event repair_reported)'
export SIG
perl -0pi -e 's/(\| Repairs inbox \| system \| — \|\n)/$1$ENV{SIG}\n/' docs/product/actors.md
