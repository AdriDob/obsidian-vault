---
title: "Bug Bounty - Comandos y Referencias"
tags: ["bug-bounty", "comandos", "referencia", "herramientas", "zap", "recon"]
created: "2026-08-20"
updated: "2026-08-28"
status: "active"
priority: "medium"
related: ["Apuntes de Bug Bounty", "IDOR - XSS - RCE", "IDOR con OWASP ZAP", "ZAP Notas"]
---

# 🐛 Bug Bounty - Comandos y Referencias

> **Migrado desde**: `07 - Archivos Desktop/Yo/Bug Bounty Comandos.md` (estaba vacío)
> **Contenido consolidado** desde notas sueltas y `ZAP notas.md`.

---

## 🔍 Reconocimiento Básico

```bash
# Subfinder - Subdominios
subfinder -d target.com -o subs.txt

# Katana - Crawling
katana -u https://target.com -o crawl.txt

# Httpx - Validar hosts vivos
httpx -l subs.txt -status-code -title -tech-detect -o alive.txt

# Waybackurls - URLs históricas
waybackurls target.com > wayback.txt

# Gau - GetAllUrls
gau target.com > gau.txt
```

---

## 🔍 IDOR Testing

```bash
# Búsqueda masiva de IDs numéricos
for i in {1..1000}; do curl -s "https://api.target.com/user/$i" | jq .; done

# Con ffuf
ffuf -u https://api.target.com/user/FUZZ -w wordlists/ids.txt -mc 200

# Autorize extension (Burp) - probar endpoints con diferentes usuarios
```

---

## 🕷️ OWASP ZAP - Flujo Típico

```bash
# Proxy: 127.0.0.1:8080
# Browser: Firefox/Chrome configurado con proxy
# 1. Abrir ZAP
# 2. Configurar proxy en navegador
# 3. Navegar app objetivo
# 4. Capturar requests
# 5. Repetir y modificar parámetros
# 6. Buscar: IDOR, auth bypass, headers raros, endpoints ocultos
```

**ZAP vs Burp**:
- 🟢 **ZAP**: Gratis, suficiente para empezar, scanner automático útil, menos usado en industria
- 🔴 **Burp**: Estándar mercado, mejor workflow manual, extensiones más potentes

---

## 📡 Endpoints Comunes a Probar

```
/api/v1/users/{id}
/api/v1/orders/{id}
/api/v1/documents/{id}
/api/v1/admin/users
/api/v1/profile
/api/v1/settings
```

---

## 🛠️ Herramientas Esenciales

| Herramienta | Uso |
|---|---|
| **subfinder** | Subdominios pasivos |
| **katana** | Crawling JS/SPA |
| **httpx** | Validación hosts, tech detect |
| **ffuf** | Fuzzing rápido |
| **nuclei** | Plantillas vulns conocidas |
| **ZAP/Burp** | Proxy, análisis manual, scanner |
| **waybackurls/gau** | URLs históricas |
| **dalfox** | XSS automation |

---

## 📋 Checklist Bug Bounty Session

- [ ] Recon: subfinder + katana + httpx
- [ ] URLs históricas: waybackurls + gau
- [ ] Fuzzing: ffuf en endpoints con IDs
- [ ] Auth testing: cambiar user/token, probar bypass
- [ ] IDOR: endpoints con parámetros numéricos
- [ ] XSS: dalfox + nucleii en params
- [ ] Documentar: request/response, pasos reproducción, impacto
- [ ] Reporte: título claro, severidad, PoC, impacto negocio

---

*Última actualización: 2026-08-28 | Consolidado desde notas sueltas*