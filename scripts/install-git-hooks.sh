#!/usr/bin/env bash
# One-time setup: symlink the versioned hooks under scripts/git-hooks
# into .git/hooks so they run on every commit. Re-run after a fresh
# clone or if .git/hooks gets clobbered.

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
SRC="$ROOT/scripts/git-hooks"
DST="$ROOT/.git/hooks"

mkdir -p "$DST"

for hook in "$SRC"/*; do
  name="$(basename "$hook")"
  ln -sf "../../scripts/git-hooks/$name" "$DST/$name"
  chmod +x "$hook"
  echo "linked $name"
done

echo ""
echo "✅ git hooks installed."
echo "   Try: 'git commit' will now run gitleaks before allowing the commit."
