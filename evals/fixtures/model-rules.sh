#!/usr/bin/env bash
# Usage: model-rules.sh [overlay] — copies lettings-code, the lettings model, and (with "overlay") lettings-extra.
set -euo pipefail
fx="$(cd "$(dirname "$0")" && pwd)"
cp -R "$fx/lettings-code/." .
[ "${1:-}" = overlay ] && cp -R "$fx/lettings-extra/." .
cp "$fx/lettings/PRODUCT.md" PRODUCT.md
mkdir -p docs/product/journeys
cp "$fx/lettings/docs/product/actors.md" docs/product/actors.md
cp "$fx/lettings/docs/product/journeys/repair-fixed.md" docs/product/journeys/repair-fixed.md
