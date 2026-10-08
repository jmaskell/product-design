#!/usr/bin/env bash
# Copy commands into ~/.claude/commands/ (frozen — won't update on git pull).
set -e
target="$HOME/.claude/commands"
mkdir -p "$target"
repo="$(cd "$(dirname "$0")" && pwd)"
cp "$repo/commands"/*.md "$target/"
echo "Copied $(ls "$repo/commands"/ | wc -l | tr -d ' ') commands into $target/"
