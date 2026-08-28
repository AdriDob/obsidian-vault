---
title: "OWNEX Desktop — Guía de Instalación y Primer Uso (Windows)"
tags: ["ownex", "instalacion", "windows", "desktop", "release", "troubleshooting"]
created: "2026-08-20"
updated: "2026-08-28"
status: "active"
priority: "high"
related: ["Especificaciones y Prompts Principales", "OWNEX Payment Network", "Rastro - Comandos"]
---

# 📦 OWNEX Desktop — Guía de Instalación y Primer Uso (Windows)

> Esta guía te lleva de la mano: instalación → primer arranque → verificación de datos reales → estado óptimo. Sigue los pasos en orden.

---

## 1. Requisitos

| Requisito | Detalle |
|---|---|
| Windows | 10 u 11 (64 bits) |
| Disco libre | ~1,5 GB |
| RAM | 4 GB recomendado (mínimo 2 GB) |
| Internet | Necesario solo para descubrimiento de targets/oportunidades |

> **No necesitas instalar Python, Node ni nada más: todo viene dentro del instalador.**

---

## 2. Instalación

1. Copiá `OWNEX-Desktop-Alpha-Setup.exe` al directorio deseado (o ejecutalo directo).
2. Ejecutalo con doble clic.
   - Si Windows SmartScreen advierte: build no firmado (debug alpha) → **"More info" → "Run anyway"**.
3. Seguí el asistente (directorio por defecto: `%LOCALAPPDATA%\Programs\OWNEX\`).
4. Al terminar, ejecutá **OWNEX Desktop** desde escritorio/menú Inicio.

**✅ Deberías ver:** Ventana OWNEX (fondo oscuro, sidebar con 8 secciones: MISSION, INTELLIGENCE, SURFACE, FINDINGS, REPORTS, OPERATIONS, TERMINAL, SYSTEM).

---

## 3. Primer Arranque — Qué Está Pasando

La app es **autocontenida**: el backend (API + pipeline + scheduler) arranca **dentro del mismo proceso** en `http://127.0.0.1:8000`.

1. Ventana aparece **al instante** (~3 s).
2. Durante **30-60 s** el backend inicia: crea BD (`database/catseye.db`), corre boot, arranca servicios.
   - MISSION Control puede mostrar `Source: local` o `--` → normal.
   - **Auto-refresh cada 10 s** → pasa a `Source: api` con datos reales.
3. Cuando MISSION muestre `Source: api` con conteos → **sistema operativo**.

**✅ Deberías ver (1-2 min):**
- `Backend API: online` en SYSTEM
- KPIs con números reales (targets, findings, activity)
- TERMINAL funcionando (shell real vía WebSocket)

---

## 4. Verificación de Datos Reales

1. SYSTEM → `Backend API: online`, `Scheduler: running`
2. Navegador/curl → `http://127.0.0.1:8000/api/health` → `200 {"status": "ok"}`
3. Esperar unos min: scheduler descubre y escanea targets automáticamente
   - Pipeline: discover → recon → hipótesis → validación → reporte
   - SURFACE lista targets con `endpoint_count`

---

## 5. Migrar Datos desde Otra PC (Opcional)

**PC Origen (Linux/desktop):**
```bash
python run.py --migrate-export ~/OWNEX_MIGRATE.zip
# Si >1 GB: python run.py --migrate-export --no-targets
```

**PC Destino (Windows):** En carpeta instalada:
```bash
OWNEX-Desktop-Alpha.exe --migrate C:\ruta\OWNEX_MIGRATE.zip
```

> Verifica checksums, restaura datos, preserva IdentityVault. Licencia ligada a HWID (reactivar si cambió).

---

## 6. Estado Óptimo — Checklist Día 1

| Check | Cómo | Esperado |
|---|---|---|
| App abierta y estable | Ejecutar app | Ventana viva, sin errores |
| Backend online | SYSTEM → Backend API | `online` |
| Pipeline corriendo | SYSTEM → Scheduler | `running` |
| Datos reales visibles | MISSION | `Source: api` + KPIs con números |
| Terminal OK | TERMINAL | Shell interactivo (`help`, `dir`) |
| Primeros targets | SURFACE (5-10 min) | Targets con `endpoint_count ≥ 1` |

---

## 7. Troubleshooting Rápido

| Síntoma | Causa | Solución |
|---|---|---|
| SmartScreen warning | Build sin firma | "More info" → "Run anyway" |
| App se cierra al arrancar | Antivirus/Defender | Excluir carpeta instalación |
| MISSION siempre `Source: local` | Backend tarda en bootear | Esperar 2 min. Si persiste, cerrar y reabrir |
| `database is locked` al migrar | App ya abrió BD | Cerrar app antes de importar |
| Puerto 8000 ocupado | Otro backend dev | Cerrar otro proceso |
| Terminal no conecta | Backend iniciando | Esperar `online` en SYSTEM |

---

## 8. Seguridad

- **100% local**: escucha solo en `127.0.0.1` (loopback). Nada expuesto a red.
- Datos en carpeta instalación (`database/`, `data/`).
- Sin telemetría ni cloud. Descubrimiento usa APIs públicas (HackerOne, Bugcrowd, etc.).

---

*Migrado desde `07 - Archivos Desktop/OWNEX pruebas/README-INSTALACION.md`*