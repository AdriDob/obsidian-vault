---
title: "Inicio"
tags: ["inicio", "dashboard", "moc"]
created: "2026-08-17"
updated: "2026-08-28"
status: "active"
priority: "high"
---

# 🏠 Inicio

> Dashboard del vault. Todo parte de acá.

---

## 🔴 Bug Bounty

[[Apuntes de Bug Bounty]] · [[IDOR - XSS - RCE]] · [[IDOR con OWASP ZAP]] · [[Bug Bounty Comandos]] · [[Extensiones Brave YouTube]] · [[ZAP Notas]]

---

## 💰 Finanzas

### 📊 Dashboard & Tracking
[[Cuentas]] · [[📊 Portfolio Tracker Setup]] · [[💸 Presupuesto y Cashflow System]] · [[📈 Plantillas Estrategia Inversión]] · [[⚡ Automatizaciones Financieras]]

### 🏦 Inversión Argentina (CEDEARs + Bonos + Brokers AR)
[[📱 Mejores Brokers Móvil Acciones]] · [[🏦 CEDEARs Guía Completa]] · [[📱 Mejores Apps de Inversión para el Teléfono]]

### 🌍 Inversión Internacional (ETFs + Acciones + Brokers Globales)
[[🌍 Brokers Internacionales para Argentinos]] · [[🧩 Matriz Comparativa Apps Finanzas Completas]]

### 🪙 Cripto & Autocustodia
[[🔐 Custodia Cripto Wallets Seguridad]] · [[🧩 Matriz Comparativa Apps Finanzas Completas#Caso 3: Cripto]]

### 🇦🇷 Fiscal & Legal (Argentina)
[[🇦🇷 Guía Fiscal Inversiones Argentina 2026]] · [[Método de cobro Bug Bounty desde Argentina]]

### 📋 Referencias Legacy (Archivadas)
[[📋 Finanzas Personales - Guía Rápida (Legacy)]] · [[📋 Plan de Trading - Setup PC (Legacy)]]

---

## 🚀 Proyectos

### 🎯 OWNEX / Rastro (Principal)
[[Especificaciones y Prompts Principales]] · [[Guía Instalación Windows]] · [[OWNEX Payment Network]] · [[Rastro - Comandos Rápidos]] · [[Rastro - Comandos]] · [[Apuntes de aprendizaje - OWNEX]] · [[Apuntes de desarrollo de software - OWNEX]] · [[Apuntes de Programación - OWNEX]] · [[Next.js Dashboard Template - Referencia]]

### 🛠️ Desarrollo & Referencias
[[Rastro - Comandos]] · [[Bug Bounty Comandos]]

---

## 🌱 Personal

### 🎯 Planes de Vida
[[Plan maestro de prioridades]] · [[Mudanza]] · [[Análisis Alquiler vs Compra Monte Grande]] · [[Vision Board Final]] · [[Dropping Label]] · [[Nota para el Próximo Dueño de la PC]] · [[Lista de Tareas Técnicas y Personales]]

### 🎮 Juegos & Ocio
[[Juegos recordatorio]]

### 🔐 Keys & Config (Sensible - No Sync)
[[KEYS]] · [[registro]]

---

## 📦 Archivo / Referencias
[[Misceláneo/MISC]] · [[07 - Archivos Desktop/]] (archivos sueltos pendientes organización)

---

## 📊 Dataview Dashboards

### 📋 Todas las notas (excluye plantillas y daily notes)
```dataview
TABLE priority AS Prioridad, status AS Estado, updated AS "Última actualización"
FROM ""
WHERE file.folder != "05 - Plantillas" AND file.folder != "06 - Daily Notes"
SORT priority ASC, updated DESC
```

### 🔥 Prioridad alta activa
```dataview
LIST
FROM ""
WHERE priority = "high" AND status = "active"
SORT updated DESC
```

### 🎯 Pendientes (Tasks no completadas)
```dataview
TASK
WHERE !completed
SORT file.ctime DESC
LIMIT 20
```

### 🆕 Notas recientes
```dataview
LIST
FROM ""
WHERE file.folder != "05 - Plantillas"
SORT file.mtime DESC
LIMIT 10
```

---

## 🗂️ Estructura de Carpetas (Resumen)

```
00 - Inicio/           ← Este dashboard
01 - Bug Bounty/       ← Notas bug bounty, comandos, ZAP
02 - Finanzas/         ← Hub financiero completo (14 notas)
03 - Proyectos/        ← OWNEX, Rastro, Next.js template
04 - Personal/         ← Planes vida, mudanza, tareas, juegos
05 - Plantillas/       ← Templates para notas nuevas
06 - Daily Notes/      ← Notas diarias (vacío)
07 - Archivos Desktop/ ← Archivos sueltos importados (3 pendientes)
Misceláneo/            ← MISC
```

---

*Última actualización: 2026-08-28 | Vault unificado: 61 notas .md*