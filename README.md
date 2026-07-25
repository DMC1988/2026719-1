🇬🇧 [English](README.md) | 🇦🇷 [Español](README.es.md)

# Optical Sensor for bill-counting Machine — NYQUEN LABS

Custom replacement PCB and 3D-printed mounting bracket for a discontinued optical encoder sensor board used in a bill-counting machine. See `REV_CONVENTION.md` for the full revision convention (rev A/B/C) and `CHANGELOG.md` for this project's revision history.

## Project Overview

**Problem:** the machine's optical encoder sensor board periodically stopped functioning, taking the counting machine out of service. The original board was difficult to source as a spare part.

**Solution:** reverse-engineered the sensor board's electrical interface, designed a drop-in replacement PCB (low-voltage signal board, no mains exposure), designed and 3D-printed a mounting bracket matching the original mounting geometry, and produced a batch of 50 units for the client's spare-parts inventory.

**Client:** industrial operator of cash-handling / bill-counting equipment (name withheld — this project predates NYQUEN LABS as a formal practice).

A full narrative write-up (with photos, once added) lives in `docs/case-study.docx`.

## Images

<!-- Replace the paths below with the actual image filenames once added to 3d-renders/. Recommended formats: .jpg/.png, keep file sizes reasonable (they're tracked via Git LFS). -->

**Finished project:**

![Finished project](\docs\img\IMG_20260724_184310.bmp)

**Render:**

![Render](3d-renders/finished-project.bmp)


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

## About NYQUEN LABS

Hardware, firmware, and mechanical design services. Contact: damian.m.caputo@gmail.com
