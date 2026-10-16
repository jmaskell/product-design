#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
bash "$(dirname "$0")/../../fixtures/plan-contractor-date.sh" g2
echo '- Review space: site ./publish.sh https://reviews.example.test' >> AGENTS.md
cat > publish.sh <<'EOT'
#!/bin/sh
# Stand-in for the owner's deploy script: records what it would publish.
{ echo "args: $*"; ls docs/plans/*/review.html; } > .published
echo "Published to https://reviews.example.test/"
EOT
chmod +x publish.sh
