🇬🇧 [English](README.md) | 🇦🇷 [Español](README.es.md)

# Sensor Optico para contador de billetes — NYQUEN LABS

Rediseño de PCB de repuesto y soporte 3D impreso para una placa de sensor óptico de encoder, usada en una máquina de contar billetes. Ver `REV_CONVENTION.md` para la convención completa de revisiones (rev A/B/C) y `CHANGELOG.md` para el historial de revisiones de este proyecto.

## Resumen del Proyecto

**Problema:** la placa de sensor óptico del encoder de la máquina dejaba de funcionar periódicamente, sacando de servicio a la contadora. La placa original era difícil de conseguir como repuesto.

**Solución:** se hizo ingeniería inversa de la interfaz eléctrica de la placa original, se diseñó una PCB de repuesto compatible, se diseñó e imprimió en 3D un soporte que replica la geometría de montaje original, y se produjo un lote de 50 unidades para el stock de repuestos del cliente.

**Cliente:** operador industrial de equipos de manejo de efectivo / contadoras de billetes.

El relato completo (con fotos, una vez agregadas) vive en `docs/case-study.docx`.

## Estructura de Carpetas

```
.
├── hardware/               # Proyecto KiCad (esquemático, PCB, librerías propias del proyecto)
│   └── libraries/          # Symbol/footprint libs específicas de este proyecto
├── mechanical/             # FreeCAD, STEP, soporte 3D impreso (Git LFS)
├── firmware/               # No aplica a este proyecto (se mantiene por consistencia del template)
├── fabrication-outputs/    # Snapshots de Gerbers/BOM/Pick&Place por revisión
│   └── revA/
├── docs/                   # Caso de estudio, datasheets, notas de validación (Git LFS para PDFs)
├── 3d-renders/             # Fotos/renders para uso en portfolio (Git LFS)
├── scripts/                # Scripts de setup/utilidades (ver abajo)
├── REV_CONVENTION.md
├── CHANGELOG.md
├── .gitignore
└── .gitattributes
```

## Trabajar en este repo (GitHub Desktop)

Día a día: editás en KiCad, y en GitHub Desktop usás la pestaña **Changes** para commitear (con los prefijos de `REV_CONVENTION.md`: `sch:`, `pcb:`, `mech:`, `fab:`, `docs:`, `fix:`) y **Push origin**.

Cuando un diseño se manda a fabricar: exportás los outputs a `fabrication-outputs/revX/`, commiteás, y taggeás ese commit como revisión — clic derecho sobre el commit en la pestaña **History** → **Create Tag** → `revA` (o usá `scripts/tag_revision.ps1` si necesitás un tag anotado con mensaje). Actualizá `CHANGELOG.md` con el motivo de esa revisión.

El setup completo paso a paso (instalación de Git LFS, clonado, etc.) está documentado en las notas internas de flujo de trabajo de NYQUEN LABS.

## Sobre NYQUEN LABS

Servicios de diseño de hardware, firmware y mecánica. Contacto: damian.m.caputo@gmail.com
