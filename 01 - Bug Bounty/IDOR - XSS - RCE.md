---
title: "IDOR, XSS y RCE - Guía Completa"
tags: ["seguridad", "web-security", "vulnerabilidades", "OWASP"]
created: "2024-01-01"
updated: "2024-08-13"
status: "active"
priority: "high"
related: ["Apuntes de Bug Bounty", "IDOR con OWASP ZAP"]
---
# 🚨 Vulnerabilidades Web Críticas

## 🎯 IDOR (Insecure Direct Object Reference)

### ¿Qué es?
El **IDOR** ocurre cuando una aplicación web permite a un usuario acceder directamente a recursos internos, como archivos, bases de datos o registros, utilizando identificadores que el usuario puede manipular.

### 🔍 Cómo identificar IDOR

1. **Cambiar parámetros en la URL** - Modificar `user_id=100` a `user_id=101`
2. **Interceptar peticiones HTTP** - Usar ZAP, Burp Suite
3. **Probar con diferentes IDs** - Enumeración de identificadores
4. **Verificar control de acceso** - El servidor debe negar acceso no autorizado

### 💡 Ejemplo práctico

```
# Solicitud original
GET /api/users/100/datos

# Intento de IDOR
GET /api/users/101/datos  ← Si responde con datos del usuario 101 → VULNERABLE
```

### 🛡️ Mitigación

- **Validación del lado del servidor** - Verificar permisos por usuario
- **Tokenización** - Usar tokens en lugar de IDs directos  
- **Auditoría de logs** - Monitorear accesos sospechosos
- **Principio de mínimo privilegio** - Solo dar acceso necesario

---
## 🌐 XSS (Cross-Site Scripting)

### ¿Qué es?
El **XSS** consiste en inyectar código malicioso en una web que se ejecuta en el navegador de otras personas.

### Tipos principales

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| **Reflejado** | El código se refleja en la respuesta | URL parameters |
| **Almacenado** | El código se guarda en la base de datos | Comentarios, foros |
| **DOM-based** | El código se ejecuta en el DOM | `document.location.href` |

### 💉 Ejemplo de payload XSS básico

```html
<script>alert('XSS')</script>
```

### 🛡️ Prevención XSS

- **Escape de salida** - Siempre escapar datos antes de mostrar
- **Content Security Policy (CSP)** - Restrictir recursos cargables
- **Input validation** - Validar y sanitizar toda entrada
- **HttpOnly en cookies** - Prevenir acceso via JavaScript

---
## ⚠️ RCE (Remote Code Execution)

### ¿Qué es?
El **RCE** permite ejecutar código arbitrario en el servidor objetivo.

### Vectores comunes

1. **File inclusion** - Local/Remote File Inclusion (LFI/RFI)
2. **Deserialization** - Objetos mal formados en deserialización
3. **Command injection** - Inyección de comandos del sistema
4. **Template injection** - Motor de plantillas vulnerable

### 🛡️ Mitigación RCE

- **Input validation estricta** - Nunca confiar en entradas del usuario
- **Actualizaciones de seguridad** - Mantener todo al día
- **Principio de menor privilegio** - El servidor no debe tener permisos excesivos
- **WAF rules** - Firewall de aplicaciones web

---
## 📚 Recursos Adicionales

- [OWASP Top 10](https://owasp.org/www-project-top-ten/) - Estándar de la industria
- [PortSwigger Web Security Testing Guide](https://portswigger.net/web-security/testing) - Guía completa
- [CWE-787](https://cwe.mitre.org/data/definitions/787.html) - CWE para Out-of-bounds Write

---
*📝 Última actualización: 13/08/2024 | 🎯 Enfoque: Comprensión profunda de vulnerabilidades críticas*
