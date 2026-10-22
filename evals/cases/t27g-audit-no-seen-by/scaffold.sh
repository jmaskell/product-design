#!/usr/bin/env bash
# The t17 audit fixture, plus a Terms table written before the Seen by column existed.
set -euo pipefail
bash "$(dirname "$0")/../../fixtures/model-with-history.sh"
cat >> PRODUCT.md <<'TERMS'

## Terms
| Term | Meaning | Avoid | Code name |
|---|---|---|---|
| Repair | A fault a tenant reports | job, ticket | Repair |
TERMS
