# Convención de Revisiones — NYQUEN LABS

Aplica a todos los proyectos de hardware (KiCad + mecánica). Objetivo: que cualquier commit fabricado sea rastreable para siempre, y que el historial de Git refleje el ciclo real de una placa (diseño → fab → bring-up → fix → siguiente rev), no el ciclo de un repo de software.

## Principio general

A diferencia del software, en hardware **no conviene tener ramas de features divergentes viviendo mucho tiempo**: el diseño avanza mayormente lineal sobre `main`, y una "revisión" (rev A, B, C...) es una **foto congelada** del momento en que ese diseño se mandó a fabricar — no una rama.

## Estructura

| Elemento | Uso |
|---|---|
| Rama `main` | Estado actual/más reciente del diseño. Siempre debe abrir y compilar (ERC/DRC limpio) en KiCad. |
| Tag `revA`, `revB`, `revC`... | Se crea en el commit exacto que se mandó a fabricar. Es inmutable — nunca se reescribe. |
| Rama `fix/revB-bringup` (temporal) | Solo si aparecen bugs durante el bring-up de una rev ya fabricada y hay que iterar antes de la siguiente tanda. Se mergea a `main` y se borra al cerrar. |
| Carpeta `fabrication-outputs/revA/`, `revB/`... | Snapshot de los Gerbers/BOM/Pick&Place tal como se enviaron a fabricar en esa rev. No se sobreescribe nunca — cada rev tiene su propia carpeta. |

## Flujo paso a paso

1. Trabajás normalmente sobre `main`, commiteando avances (ver convención de mensajes abajo).
2. Cuando el diseño está listo para mandar a fabricar:
   - Corré ERC y DRC limpios en KiCad.
   - Exportá Gerbers/Drill/BOM/Pick&Place a `fabrication-outputs/revX/` (X = letra de la revisión).
   - Commiteá ese export: `git commit -m "fab: export revA outputs"`.
   - Taggeá ese commit: `git tag -a revA -m "Sent to fab: [fab house], [fecha], [motivo/versión]"`.
   - `git push origin main --tags`.
3. Si durante el bring-up de revA aparece un bug que requiere cambios antes de la próxima fabricación:
   - Abrís `fix/revA-bringup` desde el tag `revA`.
   - Iterás ahí, mergeás a `main` cuando esté validado.
4. Cuando el siguiente diseño esté listo para fabricar, repetís el paso 2 con `revB`.

## Convención de mensajes de commit

Prefijos cortos, en inglés, estilo conventional commits simplificado:

| Prefijo | Uso |
|---|---|
| `sch:` | Cambios en el esquemático |
| `pcb:` | Cambios en el layout de PCB |
| `fab:` | Exports de fabricación (gerbers, BOM, pick&place) |
| `mech:` | Cambios en mecánica (FreeCAD, STEP, soportes) |
| `fw:` | Firmware |
| `docs:` | Documentación (README, datasheets, reportes) |
| `fix:` | Corrección de un bug identificado en bring-up |

Ejemplo: `pcb: route power stage, add thermal relief on Q3`

## Naming de tags

`revA`, `revB`, `revC`... — una letra por cada vez que el diseño se envió a fabricar. Si necesitás sub-iteraciones dentro de la misma rev (ej. un segundo envío del mismo Gerber por error de fab), usá `revA.1`, `revA.2`.

## CHANGELOG.md

Cada tag de revisión debe tener una entrada correspondiente en `CHANGELOG.md` con: fecha, motivo del cambio respecto a la rev anterior, y estado (en bring-up / validada / con issues conocidos). Ver plantilla en `CHANGELOG.md`.
