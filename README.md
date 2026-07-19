# [NOMBRE DEL PROYECTO] — Template NYQUEN LABS

Plantilla reutilizable de repositorio para proyectos de hardware (KiCad 8.x + mecánica + opcionalmente firmware). Ver `REV_CONVENTION.md` para la convención completa de revisiones (rev A/B/C) y `CHANGELOG.md` para el historial de este proyecto.

## Estructura de carpetas

```
.
├── hardware/               # Proyecto KiCad (esquemático, PCB, librerías propias del proyecto)
│   └── libraries/          # Symbol/footprint libs específicas de este proyecto
├── mechanical/             # FreeCAD, STEP, soportes 3D (Git LFS)
├── firmware/               # Si el proyecto incluye firmware (opcional)
├── fabrication-outputs/    # Snapshots de Gerbers/BOM/Pick&Place por revisión
│   ├── revA/
│   └── revB/
├── docs/                   # Datasheets, reportes de pre-compliance, notas de bring-up (Git LFS para PDFs)
├── 3d-renders/             # Imágenes/renders para portfolio (Git LFS)
├── scripts/                # Scripts de setup y utilidades de este template
├── REV_CONVENTION.md
├── CHANGELOG.md
├── .gitignore
└── .gitattributes
```

## Setup inicial (una sola vez por máquina) — flujo con GitHub Desktop

1. Instalar **Git LFS**: [git-lfs.com](https://git-lfs.com) → descargar el instalador de Windows → ejecutar. GitHub Desktop usa el Git LFS instalado en el sistema, no trae uno propio integrado.
2. Abrir GitHub Desktop → **File → Options → Integrations** → confirmar qué shell externa tenés configurada (Git Bash, PowerShell o CMD). Si instalaste "Git for Windows" en algún momento (trae Git Bash), podés correr los scripts `.sh` de este template desde ahí. Si no, usá las versiones `.ps1` (PowerShell) que están en `scripts/` — no necesitan nada adicional, PowerShell ya viene con Windows.

## Crear un proyecto nuevo a partir de este template

**Opción A — GitHub Template Repo (recomendado, 100% con Desktop + web, sin terminal):**

1. Subí esta carpeta como un repo nuevo a GitHub (podés arrastrar la carpeta a GitHub Desktop: **File → Add local repository** → **Publish repository**).
2. En GitHub.com, andá al repo → **Settings** → tildá **Template repository**.
3. Para cada proyecto nuevo: en GitHub.com, abrí el repo template → botón verde **"Use this template" → Create a new repository** → le ponés nombre (privado) → Create.
4. En GitHub Desktop: **File → Clone repository** → elegí el repo recién creado → Clone.
5. Reemplazá a mano `[NOMBRE DEL PROYECTO]` en `README.md` y `CHANGELOG.md`.

**Opción B — Script local, sin pasar por GitHub Template (más rápido si todavía no subiste el template):**

PowerShell (recomendado en Windows sin Git Bash):
```powershell
.\scripts\new_project.ps1 -ProjectName "nombre-del-proyecto" -Destination "D:\Electronica\Projects"
```
Después: en GitHub Desktop → **File → Add local repository** → apuntá a la carpeta creada → **Publish repository**.

Git Bash (si lo tenés instalado):
```bash
./scripts/new_project.sh nombre-del-proyecto /ruta/donde/crear
```

## Flujo de trabajo diario (todo en la GUI de Desktop)

1. Trabajás normalmente en KiCad sobre la carpeta del repo.
2. En GitHub Desktop: los cambios aparecen listados en la pestaña **Changes**. Escribís el mensaje de commit (usá los prefijos de `REV_CONVENTION.md`: `pcb:`, `sch:`, `fab:`, etc.) → **Commit to main**.
3. **Push origin** (botón arriba) para subir a GitHub.

No hace falta terminal para el día a día — el terminal/scripts solo simplifican el scaffolding inicial y el tagging de revisiones.

## Cuando el diseño se manda a fabricar (crear una revisión)

Ver el detalle completo en `REV_CONVENTION.md`. Resumen con GitHub Desktop:

1. Exportá Gerbers/BOM/Pick&Place a `fabrication-outputs/revA/` (desde KiCad o `kicad-cli`).
2. En Desktop: commiteá ese export con mensaje `fab: export revA outputs` → **Push origin**.
3. Taggear la revisión — dos formas:
   - **Por GUI (más simple):** pestaña **History** → clic derecho sobre el commit que acabás de subir → **Create Tag** → escribí `revA` → Enter. GitHub Desktop empuja el tag automáticamente en el próximo Push.
   - **Por script**, si preferís el mensaje descriptivo completo (`git tag -a` con `-m`, que la GUI de Desktop no pide):
     ```powershell
     .\scripts\tag_revision.ps1 -RevLabel "revA" -Message "Sent to fab: JLCPCB, 2026-07-20"
     ```
     Luego **Push origin** desde Desktop para subir el tag.
4. Actualizá `CHANGELOG.md` con el motivo de la revisión y commiteá.

## Notas sobre Git LFS y GitHub

El plan gratuito de GitHub incluye 1 GB de almacenamiento LFS y 1 GB/mes de ancho de banda por cuenta, compartido entre todos los repos. Si un proyecto acumula muchos STEP/gerbers pesados y te acercás al límite, opciones: comprar packs de datos LFS (barato, USD 5/mes por 50GB adicionales), o mover `fabrication-outputs/` de revisiones viejas a almacenamiento externo (manteniendo solo la rev vigente en LFS activo).

## Checklist antes de enviar a fabricar (recordatorio, no reemplaza tu propio checklist técnico)

- [ ] ERC limpio (0 errores, warnings revisados)
- [ ] DRC limpio (0 errores, warnings revisados)
- [ ] BOM verificado (componentes disponibles, sin duplicados de referencia)
- [ ] Gerbers revisados visualmente (capa por capa) antes de exportar
- [ ] `CHANGELOG.md` actualizado con el motivo de esta revisión
