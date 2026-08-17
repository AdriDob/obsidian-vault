---
title: "IDOR Professional con OWASP ZAP - Guía Completa"
tags: ["seguridad", "owasp-zap", "idor", "web-security"]
created: "2024-01-01"
updated: "2026-08-17"
status: "active"
priority: "high"
related: ["Apuntes de Bug Bounty", "IDOR - XSS - RCE"]
---
# 🕵️ IDOR Professional con OWASP ZAP

## 🎯 Introducción

Las vulnerabilidades **IDOR** (Insecure Direct Object Reference) son críticas para identificar en pruebas de seguridad. Esta guía completa te enseñará a encontrarlas y explotarlas éticamente usando **OWASP ZAP**.

## 📋 Conceptos Fundamentales

### ¿Qué es un IDOR?

El **IDOR** ocurre cuando una aplicación web permite a un usuario acceder directamente a recursos internos utilizando identificadores que puede manipular. A diferencia de otros tipos de vulnerabilidades, el IDOR explota fallos en el **control de acceso** más que en la validación de entrada.

### 🎯 Características Clave

| Característica | Descripción |
|---------------|-------------|
| **Acceso no autorizado** | El usuario puede ver datos de otros usuarios |
| **Manipulación de IDs** | Cambiar IDs en URLs o peticiones API |
| **Fallo de autorización** | El servidor no verifica permisos correctamente |
| **Facilidad de explotación** | Alta - requiere conocimientos técnicos básicos |

## 🛠️ Configuración de OWASP ZAP para IDOR

### 🔧 Pasos de Configuración Inicial

```bash
# Instalar OWASP ZAP
# Opción 1: Desde repositorios
sudo apt install zaproxy

# Opción 2: Desde el sitio oficial
# Descargar https://www.zaproxy.org/download/

# Iniciar ZAP
zap -

# Configurar proxy en el navegador
# - Proxy HTTP: localhost
# - Puerto: 8080
# - No interceptar hasta configurar
```

### 🔧 Configuración Avanzada

```json
{
  "api": {
    "enabled": true,
    "port": 2375,
    "host": "127.0.0.1"
  },
  "session": {
    "type": "local",
    "newSession": false
  },
  "ids": {
    "enabled": true,
    "update": true
  }
}
```

## 🔍 Flujo de Trabajo para Detectar IDOR

### Paso 1: Mapeo y Descubrimiento

1. **Spider** - Dejar que ZAP explore la aplicación automáticamente
2. **Discovery** - Identificar todos los endpoints y parámetros
3. **Parameter mapping** - Mapear cada parámetro de cada endpoint

### Paso 2: Prueba de IDOR

```http
# Solicitud original (usuario Autenticado A)
GET /api/usuarios/101/datos
Cookie: session=abc123

# Solicitud de prueba (intentando acceder como usuario B)
GET /api/usuarios/201/datos  
Cookie: session=def456

# Análisis de respuesta
# Si recibimos datos del usuario 201 → VULNERABLE IDOR
# Si recibimos error 403/401 → No vulnerable (correctamente protegido)
```

### Paso 3: Documentación del Finding

```markdown
# Finding: IDOR en /api/usuarios/:id

## Descripción
El identificador de usuario es predecible y no tiene control de acceso adecuado.

## Steps to Reproduce
1. Loguearse como Usuario A
2. Navegar a `/api/usuarios/101/datos`
3. Modificar el ID a `201`
4. Observar respuesta con datos del usuario 201

## Severidad
Alta

## Evidence
- Petición original: GET /api/usuarios/101/datos
- Petición modificada: GET /api/usuarios/201/datos
- Respuesta: Datos del usuario 201 mostrados al usuario 1

## Recomendación
Implementar verificación de permisos basados en roles (RBAC) y validar que el usuario autenticado es el propietario del recurso solicitado.
```
