---
title: "Apuntes de Bug Bounty"
tags: ["bug-bounty", "seguridad", "terminal", "owasp"]
created: "2024-01-01"
updated: "2026-08-17"
status: "active"
priority: "high"
related: ["IDOR - XSS - RCE", "IDOR con OWASP ZAP", "Método de cobro Bug Bounty desde Argentina"]
---
# 🧰 🐧 SETUP REAL DE BUG BOUNTY (TERMINAL)

## 🔥 1. BASE SYSTEM

**Sistema operativo:** Linux (WSL2) + Terminal

### 📦 1.1 Requisitos previos

- Windows 10/11 o macOS
- WSL2 activado (`wsl --install -d Ubuntu`)
- Sudo/root privileges

### 📦 1.2 Instalación de herramientas

```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependencias esenciales
sudo apt install -y git curl wget zip unzip curl

# Instalar Node.js (para algunas herramientas)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Instalar Turbo Intruder (opcional pero recomendado)
# https://portswigger.net/intruder/turbo-intruder
```

### 📦 1.3 Configuración de la terminal

```bash
# Configurar .bashrc o .zshrc
echo 'export PATH="$PATH:/home/user/.local/bin"' >> ~/.bashrc
source ~/.bashrc

# Configurar alias útiles
alias bug='code /path/to/bounty/scripts/'
alias w='code ~/Obsidian\ Vault/'
alias zs='code ~/ZS-Assets/'
```

## 📊 2. Metodología

### 📋 2.1 Bug Bounty Lifecycle

1. **Reconocimiento** - Información gathering
2. **Escaneo** - Herramientas automáticas
3. **Análisis** - Revisión manual de findings
4. **Explotación** - Pruebas de concepto (PoC)
5. **Reporte** - documentación formal

### 📊 2.3 Tabla de prioridades

| Severidad | Significado | Acción |
|-----------|-------------|--------|
| 🔴 **Crítica** | Acceso no autorizado a datos sensibles | Reporte inmediato |
| 🟠 **Alta** | Impacto significativo en la operación | Reporte en 24h |
| 🟡 **Media** | Funcionalidad comprometida | Reporte en semana |
| 🟢 **Baja** | Problema estético o menor | Reporte opcional |

## 🛠️ 3. Herramientas Esenciales

| Categoría | Herramienta | Licencia |
|-----------|-------------|----------|
| **Proxy** | OWASP ZAP | GPL |
| **Scanner** | Nikto / OWASP ZAP | Open Source |
| **Explotación** | Burp Suite Professional | Propietaria |
| **Payloads** | nuclei | MIT |
| **Template** | nuclei-templates | MIT |

## 📋 4. Checklist Semanal

- [ ] Actualizar diccionarios de palabras clave
- [ ] Revisar nuevos CVE's publicados
- [ ] Probar herramientas recién lanzadas
- [ ] Actualizar notas del vault
- [ ] Revisar status de findings en curso

## 📅 5. Próximos pasos

- [ ] Configurar alertas de nuevos CVE's
- [ ] Crear templates de reporte personalizados
- [ ] Integrar con sistema de ticketera
- [ ] Automatizar parte del reconocimiento

---
*📝 Última actualización: 13/08/2024 | 🎯 Próximo hito: Lograr primer $1,000 USD en recompensas*
