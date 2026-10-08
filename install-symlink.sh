#!/usr/bin/env bash
# Symlink commands into ~/.claude/commands/. Edits in this repo go live immediately.
set -e
target="$HOME/.claude/commands"
mkdir -p "$target"
repo="$(cd "$(dirname "$0")" && pwd)"
ln -sf "$repo/commands"/*.md "$target/"
echo "Linked $(ls "$repo/commands"/ | wc -l | tr -d ' ') commands into $target/"
