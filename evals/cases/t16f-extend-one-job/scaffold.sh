#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings-code/." .
f="$(dirname "$0")/../../fixtures/lettings"
mkdir -p docs/product/journeys
cp "$f/PRODUCT.md" PRODUCT.md
cp "$f/docs/product/actors.md" docs/product/actors.md
cp "$f/docs/product/journeys/repair-fixed.md" docs/product/journeys/repair-fixed.md
