#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../../fixtures/model-rules.sh" overlay
LINE='- Privacy regime: UK GDPR (the agency and its tenants are in the UK). Interpretation: UNKNOWN.'
export LINE
perl -0pi -e 's/\n\n## Evidence on Hand/\n$ENV{LINE}\n\n## Evidence on Hand/' PRODUCT.md
