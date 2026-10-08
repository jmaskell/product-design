#!/usr/bin/env bash
# Fails when README.md drifts from skills/ and scripts/, or names a command.
set -u
root="$(cd "$(dirname "$0")/.." && pwd)"
readme="$root/README.md"
fail=0
[ -f "$readme" ] || { echo "README.md missing"; exit 1; }
table=$(grep -oE '^\| `[a-z-]+` \|' "$readme" | grep -oE '[a-z-]+')
for d in "$root"/skills/*/; do
  n=$(basename "$d")
  echo "$table" | grep -qx "$n" || { echo "README.md: skill '$n' is not in the skills table"; fail=1; }
done
for n in $table; do
  [ -f "$root/skills/$n/SKILL.md" ] || { echo "README.md: table names '$n' but skills/$n/SKILL.md does not exist"; fail=1; }
done
for s in $(grep -oE 'scripts/[A-Za-z0-9_.-]+\.sh' "$readme" | sort -u); do
  [ -f "$root/$s" ] || { echo "README.md: mentions $s, which does not exist"; fail=1; }
done
hits=$(grep -nE '(^|[[:space:](`])/[a-z][a-z-]*([^A-Za-z/-]|$)|(^|[^A-Za-z])commands/' "$readme" | grep -v 'https\?://' || true)
if [ -n "$hits" ]; then echo "$hits"; echo "README.md: references commands/ or a slash command"; fail=1; fi
[ $fail -eq 0 ] && echo "PASS: readme"; exit $fail
