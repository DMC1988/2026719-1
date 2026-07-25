# Revision Convention — NYQUEN LABS

Applies to all hardware projects (KiCad + mechanical). Goal: every fabricated commit stays traceable forever, and the Git history reflects the real lifecycle of a board (design → fab → bring-up → fix → next rev), not a software repo's lifecycle.

## General Principle

Unlike software, in hardware **it's not worth keeping long-lived divergent feature branches**: the design moves mostly linearly on `main`, and a "revision" (rev A, B, C...) is a **frozen snapshot** of the moment that design was sent to fabrication — not a branch.

## Structure

| Element | Use |
|---|---|
| `main` branch | Current/latest state of the design. Should always open and build clean (ERC/DRC clean) in KiCad. |
| `revA`, `revB`, `revC`... tag | Created on the exact commit that was sent to fabrication. Immutable — never rewritten. |
| `fix/revB-bringup` branch (temporary) | Only if bugs show up during bring-up of an already-fabricated rev and need to be iterated on before the next batch. Merged into `main` and deleted when closed. |
| `fabrication-outputs/revA/`, `revB/`... folder | Snapshot of the Gerbers/BOM/Pick&Place exactly as sent to fabrication for that rev. Never overwritten — each rev has its own folder. |

## Step-by-Step Flow

1. Work normally on `main`, committing progress (see commit message convention below).
2. When the design is ready to send to fabrication:
   - Run clean ERC and DRC in KiCad.
   - Export Gerbers/Drill/BOM/Pick&Place to `fabrication-outputs/revX/` (X = revision letter).
   - Commit that export: `git commit -m "fab: export revA outputs"`.
   - Tag that commit: `git tag -a revA -m "Sent to fab: [fab house], [date], [reason/version]"`.
   - `git push origin main --tags`.
3. If a bug shows up during revA's bring-up that requires changes before the next fabrication run:
   - Open `fix/revA-bringup` from the `revA` tag.
   - Iterate there, merge into `main` once validated.
4. When the next design is ready to fabricate, repeat step 2 with `revB`.

## Commit Message Convention

Short prefixes, in English, simplified conventional-commits style:

| Prefix | Use |
|---|---|
| `sch:` | Schematic changes |
| `pcb:` | PCB layout changes |
| `fab:` | Fabrication exports (gerbers, BOM, pick&place) |
| `mech:` | Mechanical changes (FreeCAD, STEP, brackets) |
| `fw:` | Firmware |
| `docs:` | Documentation (README, datasheets, reports) |
| `fix:` | Fix for a bug identified during bring-up |
| `proj:` | General project changes |

Example: `pcb: route power stage, add thermal relief on Q3`

## Tag Naming

`revA`, `revB`, `revC`... — one letter per time the design was sent to fabrication. If you need sub-iterations within the same rev (e.g., a second Gerber submission due to a fab error), use `revA.1`, `revA.2`.

## CHANGELOG.md

Every revision tag must have a corresponding entry in `CHANGELOG.md` with: date, reason for the change relative to the previous rev, and status (in bring-up / validated / with known issues). See the template in `CHANGELOG.md`.
