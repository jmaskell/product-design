#!/usr/bin/env bash
# Copies lettings-ui and adds a project copy rule: contractor-facing copy says "job".
set -euo pipefail
fx="$(cd "$(dirname "$0")" && pwd)"
cp -R "$fx/lettings-ui/." .
printf -- '- Copy examples: docs/copy-examples.md\n' >> AGENTS.md
mkdir -p docs
cat > docs/copy-examples.md <<'EOF'
# Copy examples

Rules:
- Contractor-facing copy says "job", never "repair". Tenants report repairs; contractors do jobs.

| Before | After | Why |
|---|---|---|
| "Repair approved at 4 Mill Lane" (contractor email) | "Job approved at 4 Mill Lane" | Contractor-facing: job |
EOF
