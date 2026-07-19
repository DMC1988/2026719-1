#!/usr/bin/env bash
# ============================================================
# tag_revision.sh — Tag the current commit as a frozen
# hardware revision (revA, revB, ...), per REV_CONVENTION.md.
#
# This only handles the Git tagging step. Exporting Gerbers/
# BOM/Pick&Place to fabrication-outputs/<rev>/ and committing
# them is a separate, prior step (manual, from KiCad or
# kicad-cli) — do that and `git add`/`git commit` it first.
#
# Usage:
#   ./tag_revision.sh <revLabel> "<message>"
#
# Example:
#   ./tag_revision.sh revA "Sent to fab: JLCPCB, 2026-07-20"
# ============================================================
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 <revLabel e.g. revA> \"<message>\""
  exit 1
fi

REV_LABEL="$1"
MESSAGE="$2"

if ! [[ "$REV_LABEL" =~ ^rev[A-Z](\.[0-9]+)?$ ]]; then
  echo "Warning: '$REV_LABEL' doesn't match the expected pattern (revA, revB, revA.1, ...)."
  read -p "Continue anyway? [y/N] " CONFIRM
  [[ "$CONFIRM" =~ ^[Yy]$ ]] || exit 1
fi

if git rev-parse "$REV_LABEL" >/dev/null 2>&1; then
  echo "Error: tag '$REV_LABEL' already exists. Tags are immutable per REV_CONVENTION.md — use ${REV_LABEL}.1 for a re-send instead."
  exit 1
fi

# Sanity check: warn if there are uncommitted changes
if ! git diff-index --quiet HEAD --; then
  echo "Warning: you have uncommitted changes. The tag will point to the last commit, which may not include them."
  read -p "Continue anyway? [y/N] " CONFIRM
  [[ "$CONFIRM" =~ ^[Yy]$ ]] || exit 1
fi

git tag -a "$REV_LABEL" -m "$MESSAGE"
echo "Tagged current commit as '$REV_LABEL'."
echo "Don't forget to update CHANGELOG.md and push tags: git push origin main --tags"
