#!/usr/bin/env bash
# Fails when shared skill text names a domain, actor type, stack or project file.
# Put your own project names in a gitignored .portability-banned file, one regex per line.
set -u
root="$(cd "$(dirname "$0")/.." && pwd)"
banned='patients?|clinicians?|psychiatr[[:alpha:]]*|clinical|Next\.js|React|Tailwind|shadcn|Supabase|AGENTS\.md'
if [ -f "$root/.portability-banned" ]; then
  extra=$(grep -v -E '^[[:space:]]*(#|$)' "$root/.portability-banned" | paste -sd '|' -)
  [ -n "$extra" ] && banned="$banned|$extra"
fi
dirs=()
for d in skills references templates; do [ -d "$root/$d" ] && dirs+=("$root/$d"); done
hits=$(grep -rniE "(^|[^[:alnum:]])($banned)([^[:alnum:]]|$)" "${dirs[@]}" 2>/dev/null \
  | grep -v 'portability-allow' || true)
if [ -n "$hits" ]; then echo "$hits"; echo "FAIL: project-specific words in shared skill text"; exit 1; fi
echo "PASS: portability"
