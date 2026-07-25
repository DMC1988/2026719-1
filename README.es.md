🇬🇧 [English](README.md) | 🇦🇷 [Español](README.es.md)

# SensorOptico_ContadorBilletes — NYQUEN LABS

Rediseño de PCB de repuesto y soporte 3D impreso para una placa de sensor óptico de encoder discontinuada, usada en una máquina de contar billetes. Ver `REV_CONVENTION.md` para la convención completa de revisiones (rev A/B/C) y `CHANGELOG.md` para el historial de revisiones de este proyecto.

## Resumen del Proyecto

**Problema:** la placa de sensor óptico del encoder de la máquina dejaba de funcionar periódicamente, sacando de servicio a la contadora. La placa original era difícil de conseguir como repuesto.

**Solución:** se hizo ingeniería inversa de la interfaz eléctrica de la placa original, se diseñó una PCB de repuesto compatible (placa de señal de baja tensión, sin exposición a mains), se diseñó e imprimió en 3D un soporte que replica la geometría de montaje original, y se produjo un lote de 50 unidades para el stock de repuestos del cliente.

**Cliente:** operador industrial de equipos de manejo de efectivo / contadoras de billetes (nombre reservado — este proyecto es anterior a NYQUEN LABS como práctica formal).

El relato completo (con fotos, una vez agregadas) vive en `docs/case-study.docx`.

## Imágenes

<!-- Reemplazar las rutas de abajo por los nombres reales de archivo una vez agregados a 3d-renders/. Formatos recomendados: .jpg/.png, mantené el tamaño de archivo razonable (se versionan vía Git LFS). -->

**Proyecto terminado:**

![Proyecto terminado](\docs\img\IMG_20260724_184310.jpg)

**Render:**

![Render](33d-renders/finished-project.bmp)

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

## Sobre NYQUEN LABS

Servicios de diseño de hardware, firmware y mecánica. Contacto: damian.m.caputo@gmail.com
