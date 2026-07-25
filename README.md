🇬🇧 [English](README.md) | 🇦🇷 [Español](README.es.md)

# Optical Sensor for Bill Counting Machine — NYQUEN LABS

Custom replacement PCB and 3D-printed mounting bracket for a an optical encoder sensor board used in a bill-counting machine. See `REV_CONVENTION.md` for the full revision convention (rev A/B/C) and `CHANGELOG.md` for this project's revision history.

## Project Overview

**Problem:** the machine's optical encoder sensor board periodically stopped functioning, taking the counting machine out of service. The original board was difficult to source as a spare part.

**Solution:** reverse-engineered the sensor board's electrical interface, designed a drop-in replacement PCB, designed and 3D-printed a mounting bracket matching the original mounting geometry, and produced a batch of 50 units for the client's spare-parts inventory.

**Client:** operator of cash-handling / bill-counting equipment.

A full narrative write-up (with photos, once added) lives in `docs/case-study.docx`.

## Folder Structure

```
.
├── hardware/               # KiCad project (schematic, PCB, project-specific libraries)
│   └── libraries/          # Project-specific symbol/footprint libs
├── mechanical/             # FreeCAD, STEP, 3D-printed bracket (Git LFS)
├── firmware/               # Not applicable to this project (kept for template consistency)
├── fabrication-outputs/    # Snapshots of Gerbers/BOM/Pick&Place per revision
│   └── revA/
├── docs/                   # Case study, datasheets, validation notes (Git LFS for PDFs)
├── 3d-renders/             # Photos/renders for portfolio use (Git LFS)
├── scripts/                # Setup/utility scripts (see below)
├── REV_CONVENTION.md
├── CHANGELOG.md
├── .gitignore
└── .gitattributes
```

## Working with this repo (GitHub Desktop)

Day-to-day: edit in KiCad, then in GitHub Desktop use the **Changes** tab to commit (prefix messages per `REV_CONVENTION.md`: `sch:`, `pcb:`, `mech:`, `fab:`, `docs:`, `fix:`) and **Push origin**.

When a design is sent to fabrication: export outputs to `fabrication-outputs/revX/`, commit, then tag the commit as a revision — right-click the commit in the **History** tab → **Create Tag** → `revA` (or use `scripts/tag_revision.ps1` if you need an annotated tag with a message). Update `CHANGELOG.md` with the reason for that revision.

Full step-by-step setup (Git LFS install, cloning, etc.) is documented separately in the NYQUEN LABS internal workflow notes.

## About NYQUEN LABS

Hardware, firmware, and mechanical design services. Contact: damian.m.caputo@gmail.com
