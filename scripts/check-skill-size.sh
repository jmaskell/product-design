#!/usr/bin/env bash
# Fails when a SKILL.md body is over its word limit or its description breaks the contract.
set -u
root="$(cd "$(dirname "$0")/.." && pwd)"
fail=0
for f in "$root"/skills/*/SKILL.md; do
  name=$(basename "$(dirname "$f")")
  limit=500; [ "$name" = "designing-products" ] && limit=400
  body_words=$(awk 'BEGIN{n=0} /^---$/{n++; next} n>=2' "$f" | wc -w | tr -d ' ')
  desc=$(awk '/^description:/{sub(/^description: */,""); print; exit}' "$f")
  if [ "$body_words" -gt "$limit" ]; then echo "$f: body $body_words words > $limit"; fail=1; fi
  if [ "${#desc}" -ge 500 ]; then echo "$f: description ${#desc} chars >= 500"; fail=1; fi
  case "$desc" in "Use when"*) ;; *) echo "$f: description must start 'Use when'"; fail=1;; esac
done
[ $fail -eq 0 ] && echo "PASS: skill size" ; exit $fail
