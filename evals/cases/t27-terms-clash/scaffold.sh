#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
cat >> PRODUCT.md <<'EOF'

## Terms
| Term | Meaning | Avoid | Code name | Seen by |
|---|---|---|---|---|
| Tenancy plan | The rent, deposit and term a tenant accepts | offer terms | TenancyPlan | Tenant |
EOF
