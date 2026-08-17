---
title: "Inicio"
tags: ["inicio", "dashboard", "moc"]
created: "2026-08-17"
updated: "2026-08-17"
status: "active"
priority: "high"
---

# 🏠 Inicio

> Dashboard del vault. Todo parte de acá.

## 🔴 Bug Bounty

[[Apuntes de Bug Bounty]] · [[IDOR - XSS - RCE]] · [[IDOR con OWASP ZAP]]

## 💰 Finanzas

[[Cuentas]] · [[Método de cobro Bug Bounty desde Argentina]] · [[OWNEX Payment Network]]

## 🚀 Proyectos

[[Apuntes de aprendizaje - OWNEX]] · [[Apuntes de desarrollo de software - OWNEX]] · [[Apuntes de Programación - OWNEX]] · [[Rastro - Comandos]]

## 🌱 Personal

[[Vision Board Final]] · [[Dropping Label]]

---

## 📊 Todas las notas

```dataview
TABLE priority AS Prioridad, status AS Estado, updated AS "Última actualización"
FROM ""
WHERE file.folder != "05 - Plantillas" AND file.folder != "06 - Daily Notes"
SORT priority ASC, updated DESC
```

## 🔥 Prioridad alta activa

```dataview
LIST
FROM ""
WHERE priority = "high" AND status = "active"
SORT updated DESC
```

## 🎯 Pendientes

```dataview
TASK
WHERE !completed
SORT file.ctime DESC
LIMIT 20
```

## 🆕 Notas recientes

```dataview
LIST
FROM ""
WHERE file.folder != "05 - Plantillas"
SORT file.mtime DESC
LIMIT 10
```
