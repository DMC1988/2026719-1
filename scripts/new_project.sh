#!/usr/bin/env bash
# ============================================================
# new_project.sh — Scaffold a new hardware project from the
# NYQUEN LABS KiCad Git template.
#
# Usage:
#   ./new_project.sh <project-name> <destination-dir>
#
# Example:
#   ./new_project.sh amp-3w-encoder-fix ~/Electronica/Projects
# ============================================================
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 <project-name> <destination-dir>"
  exit 1
fi

PROJECT_NAME="$1"
DEST_DIR="$2"
TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NEW_PROJECT_PATH="${DEST_DIR%/}/${PROJECT_NAME}"

if [ -e "$NEW_PROJECT_PATH" ]; then
  echo "Error: $NEW_PROJECT_PATH already exists."
  exit 1
fi

echo "Creating $NEW_PROJECT_PATH from template at $TEMPLATE_DIR ..."
mkdir -p "$NEW_PROJECT_PATH"

# Copy everything except the template's own .git (if it has one)
if command -v rsync >/dev/null 2>&1; then
  rsync -a --exclude '.git' "$TEMPLATE_DIR"/ "$NEW_PROJECT_PATH"/
else
  cp -a "$TEMPLATE_DIR"/. "$NEW_PROJECT_PATH"/
  rm -rf "$NEW_PROJECT_PATH/.git"
fi

# Replace placeholder project name in README and CHANGELOG
if command -v sed >/dev/null 2>&1; then
  sed -i.bak "s/\[NOMBRE DEL PROYECTO\]/${PROJECT_NAME}/g" "$NEW_PROJECT_PATH/README.md" "$NEW_PROJECT_PATH/CHANGELOG.md"
  rm -f "$NEW_PROJECT_PATH/README.md.bak" "$NEW_PROJECT_PATH/CHANGELOG.md.bak"
fi

cd "$NEW_PROJECT_PATH"
git init -q
git lfs install --local >/dev/null 2>&1 || echo "Warning: git-lfs not installed (or install failed) on this machine. Install it before committing large binary files: https://git-lfs.com"

git add .
git commit -q -m "chore: scaffold project from NYQUEN LABS KiCad template"
git branch -M main

echo ""
echo "Done. Project created at: $NEW_PROJECT_PATH"
echo "Next steps:"
echo "  1. Open KiCad and create your .kicad_pro inside hardware/"
echo "  2. git remote add origin git@github.com:<your-user>/${PROJECT_NAME}.git"
echo "  3. git push -u origin main"
