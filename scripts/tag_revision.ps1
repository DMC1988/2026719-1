# ============================================================
# tag_revision.ps1 — Tag the current commit as a frozen
# hardware revision (revA, revB, ...), per REV_CONVENTION.md.
# (PowerShell version. Only needed if you don't want to use
# GitHub Desktop's own "Create Tag" option on a commit in the
# History tab — see README.md for the GUI-only equivalent.)
#
# Usage:
#   .\tag_revision.ps1 -RevLabel "revA" -Message "Sent to fab: JLCPCB, 2026-07-20"
# ============================================================
param(
    [Parameter(Mandatory=$true)][string]$RevLabel,
    [Parameter(Mandatory=$true)][string]$Message
)

$ErrorActionPreference = "Stop"

if ($RevLabel -notmatch '^rev[A-Z](\.[0-9]+)?$') {
    Write-Warning "'$RevLabel' doesn't match the expected pattern (revA, revB, revA.1, ...)."
    $confirm = Read-Host "Continue anyway? [y/N]"
    if ($confirm -notmatch '^[Yy]$') { exit 1 }
}

git rev-parse $RevLabel 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Error "Tag '$RevLabel' already exists. Tags are immutable per REV_CONVENTION.md — use $RevLabel.1 for a re-send instead."
    exit 1
}

$status = git diff-index --quiet HEAD --
if ($LASTEXITCODE -ne 0) {
    Write-Warning "You have uncommitted changes. The tag will point to the last commit, which may not include them."
    $confirm = Read-Host "Continue anyway? [y/N]"
    if ($confirm -notmatch '^[Yy]$') { exit 1 }
}

git tag -a $RevLabel -m $Message
Write-Host "Tagged current commit as '$RevLabel'."
Write-Host "Don't forget to update CHANGELOG.md, then push tags from GitHub Desktop (Repository > Push, tags go with it) or: git push origin main --tags"
