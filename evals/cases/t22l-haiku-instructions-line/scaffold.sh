#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../../fixtures/lettings-ui-copy-rules.sh"
printf '# Lettings portal\n\nBefore adding or changing user-facing strings, use product-design:writing-ui-copy.\n' > CLAUDE.md
