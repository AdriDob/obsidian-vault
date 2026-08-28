---
title: "OWNEX - Especificaciones y Prompts Principales"
tags: ["ownex", "proyecto", "especificaciones", "prompts", "bug-bounty", "android", "commits"]
created: "2026-08-20"
updated: "2026-08-28"
status: "active"
priority: "high"
related: ["Apuntes de aprendizaje - OWNEX", "Apuntes de desarrollo de software - OWNEX", "Apuntes de Programación - OWNEX", "OWNEX Payment Network", "Rastro - Comandos"]
---

# 🎯 OWNEX - Especificaciones y Prompts Principales

> **Proyecto principal**: Rastro (bug bounty automation tool) + OWNEX Desktop/Windows
> **Migrado desde**: `07 - Archivos Desktop/OWNEX.md`

---

## 📋 Principio Fundamental

> **CE (SIEMPRE ACLARAR QUE CUIDE LA BASE EXISTENTE DE CÓDIGO SI LE PIDO ALGO QUE YA TIENE. SI YA ESTÁ QUE LO PULA)**

---

## 🎯 Visión del Sistema

**Ciclo programado y asistido por IA para bug bounty, de élite. Simplificado.**

- Descubre bountys de todo tipo de toda la web
- Ejecuta pruebas automatizadas
- Prepara el mejor reporte posible listo para subir con enlaces directos
- Para que lo pueda usar y monitorear cualquier persona interesada en ciberseguridad
- Debe garantizar las recompensas máximas posibles
- Reportes de calidad, flujo de trabajo impecable
- Conectado a OWASP ZAP (accesibilidad para personas de escasos recursos)

---

## 🔄 Plan del Sistema (Ciclo Automático)

```
Analizá el estado completo del proyecto
    ↓
Elegí automáticamente el siguiente trabajo con mayor impacto para:
  ├── Aumentar tasa de vulnerabilidades encontradas
  ├── Calidad de las evidencias
  ├── Calidad de los reportes
  └── Probabilidad de obtener recompensas reales
    ↓
Justificá la decisión
    ↓
Implementá la mejora
    ↓
Verificá que todo siga funcionando correctamente
    ↓
CONTINUAR
```

---

## 📝 Prompt para Commits Profesionales

**Objetivo**: Commit limpio, seguro, bien documentado.

**Tareas**:
1. Revisar TODOS los cambios del working tree
2. Agrupar por categoría: Feature, Fix, Refactor, Performance, Security, Tests, Documentation, Build, Release
3. Detectar archivos que NO deberían commitearse (.env, secrets, tokens, API keys, temp, caches, logs, __pycache__, dist, archivos personales, backups)
4. Verificar .gitignore
5. Si hay info sensible: NO commitear, mostrar archivo exacto
6. Resumen: archivos modificados/nuevos/eliminados, líneas +/- 
7. Mensaje Conventional Commits (feat:, fix:, refactor:, perf:, test:, docs:, build:, chore:, release:)
8. Descripción extensa: qué, por qué, impacto, breaking changes, riesgos, próximos pasos
9. Esperar aprobación antes de `git add/commit/push`

---

## 📱 Prompt para Desarrollo Android (ORION/RASTRO)

**Objetivo**: Trabajar EXCLUSIVAMENTE sobre versión Android de Rastro.

**Prioridades**: Estabilidad → UX → Rendimiento → Integración backend → Compatibilidad futura

**Reglas Obligatorias**:
- No modificar backend salvo absolutamente necesario
- No modificar versión Desktop
- No romper compatibilidad Windows
- No cambiar APIs sin justificar
- Mantener arquitectura limpia
- No deuda técnica innecesaria

**Antes de escribir código**:
1. Analizar arquitectura existente
2. Detectar dependencias
3. Detectar regresiones posibles
4. Explicar plan
5. Esperar aprobación si cambio grande

**Por cada tarea**: explicar qué, archivos, por qué, riesgos, impacto esperado

**Prioridades Funcionales Android**:
- Inicio rápido, Login, Gestión licencia, Targets, Findings, Reports, Dashboard, Notificaciones, Sincronización, Modo offline, Caché local, Reintentos auto, Pull to refresh, Dark mode, Manejo errores, Loading states, Animaciones suaves, Navegación fluida

**Calidad**: Memory leaks, race conditions, null safety, lifecycle, rendimiento, batería, red, almacenamiento

**Networking**: Timeouts, retry, cancelación requests, manejo offline, sync incremental, JWT/licencias

**UI**: Material Design moderno - rápida, limpia, profesional, consistente, simple. Evitar: pantallas vacías, loaders infinitos, errores silenciosos, botones sin feedback, bloqueos UI

**Código**: Pequeño, modular, reversible, documentado. Al finalizar: archivos modificados, líneas +/- , riesgos, próximos pasos, confianza (★★★★★)

---

## 🚀 Bloqueadores Críticos para Completar Rastro (MVP)

### **BLOQUEADOR 1: Persistencia Endpoints en BD**
- `ReconRunner.run_pipeline()` genera JSON en `targets/{name}/endpoints/normalized_endpoints.json`
- **NUNCA guarda en tabla `endpoints` de SQLite**
- Archivos: `database/models.py`, `core/recon/parser.py`, `core/recon/runner.py`, `main.py`

### **BLOQUEADOR 2: Error Handling Robusto**
- POST `/scans` en `main.py`: crash sin logs si subfinder/katana/httpx fallan
- Sin estado de ejecución, sin mensajes útiles
- Archivos: nuevo `core/recon/dependency_checker.py`, refactorizar `main.py`

### **BLOQUEADOR 3: Validación de Inputs**
- POST `/targets`, `/endpoints` sin validación
- Path traversal vulnerability: `target_id="../../../etc/passwd"` aceptado
- Archivos: nuevo `core/security/input_validator.py`, integrar en `main.py`

---

*Última actualización: 2026-08-28 | Contenido migrado y estructurado desde `07 - Archivos Desktop/OWNEX.md`*