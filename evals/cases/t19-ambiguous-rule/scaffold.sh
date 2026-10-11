#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../../fixtures/model-rules.sh"
LINE='- Fees charged to landlords must be fair and shown clearly. Source: Consumer Protection from Unfair Trading Regulations 2008; The Property Ombudsman Code of Practice. Interpretation: UNKNOWN.'
export LINE
LINE=$LINE perl -0pi -e 's/\n\n## Evidence on Hand/\n$ENV{LINE}\n\n## Evidence on Hand/' PRODUCT.md
