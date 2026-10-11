#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../../fixtures/model-rules.sh"
perl -pi -e 's#^- Domain rules: none#- Domain rules: docs/domain-rules.md#' AGENTS.md
cat > docs/domain-rules.md <<'R'
# Domain rules
- Tenancy deposits must be protected in a government-approved scheme within 30 days. Source: Housing Act 2004 s213.
- Deposits are capped at five weeks' rent. Source: Tenant Fees Act 2019.
R
