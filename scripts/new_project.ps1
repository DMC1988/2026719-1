# ============================================================
# new_project.ps1 — Scaffold a new hardware project from the
# NYQUEN LABS KiCad Git template. (PowerShell version, for
# Windows users working from GitHub Desktop.)
#
# Usage:
#   .\new_project.ps1 -ProjectName "amp-3w-encoder-fix" -Destination "D:\Electronica\Projects"
# ============================================================
param(
    [Parameter(Mandatory=$true)][string]$ProjectName,
    [Parameter(Mandatory=$true)][string]$Destination
)

$ErrorActionPreference = "Stop"
$TemplateDir = Split-Path -Parent $PSScriptRoot
$NewProjectPath = Join-Path $Destination $ProjectName

if (Test-Path $NewProjectPath) {
    Write-Error "Error: $NewProjectPath already exists."
    exit 1
}

Write-Host "Creating $NewProjectPath from template at $TemplateDir ..."
New-Item -ItemType Directory -Path $NewProjectPath | Out-Null

Copy-Item -Path (Join-Path $TemplateDir "*") -Destination $NewProjectPath -Recurse -Force -Exclude ".git"

# Replace placeholder project name in README and CHANGELOG
(Get-Content (Join-Path $NewProjectPath "README.md")) -replace '\[NOMBRE DEL PROYECTO\]', $ProjectName | Set-Content (Join-Path $NewProjectPath "README.md")
(Get-Content (Join-Path $NewProjectPath "CHANGELOG.md")) -replace '\[NOMBRE DEL PROYECTO\]', $ProjectName | Set-Content (Join-Path $NewProjectPath "CHANGELOG.md")

Set-Location $NewProjectPath
git init -q
git lfs install --local 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Warning "git-lfs not installed on this machine. Install it from https://git-lfs.com before committing large binary files."
}

git add .
git commit -q -m "chore: scaffold project from NYQUEN LABS KiCad template"
git branch -M main

Write-Host ""
Write-Host "Done. Project created at: $NewProjectPath"
Write-Host "Next steps:"
Write-Host "  1. Open this folder in GitHub Desktop: File > Add local repository"
Write-Host "  2. Open KiCad and create your .kicad_pro inside hardware\"
Write-Host "  3. Publish the repository to GitHub from the Desktop app (Publish repository button)"
