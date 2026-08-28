---
title: "Plan de Trading - Setup PC (Legacy - Ver Trading Setup en 02 - Finanzas/ y 01 - Bug Bounty/)"
tags: ["trading", "legacy", "setup", "pc", "hardware", "tradingview", "mt5", "ibkr", "risk-management", "journal"]
created: "2026-01-16"
updated: "2026-08-28"
status: "archived"
priority: "low"
related: ["📈 Plantillas Estrategia Inversión", "📊 Portfolio Tracker Setup", "🌍 Brokers Internacionales para Argentinos", "📱 Mejores Brokers Móvil Acciones"]
---

# 🖥️ Plan de Trading PC - Guía Legacy (Archivada)

> **⚠️ NOTA LEGACY**: Migrada desde `Obsidian/Adri/Plan de Trading.md`. El contenido de **inversión** (IBKR, ETFs, largo plazo) se fusionó en `02 - Finanzas/`. El contenido de **trading activo** (MT5, Forex, Futuros, setup técnico) pertenece a `01 - Bug Bounty/` o `03 - Proyectos/` si es trading algorítmico.

---

## 🗺️ Dónde Está Cada Cosa Ahora

| Sección Original | Nueva Ubicación | Qué Encontrás |
|------------------|-----------------|---------------|
| **Filosofía: 1 plataforma analizar, 1 ejecutar, 1 gestionar** | `📈 Plantillas Estrategia Inversión` → Plantilla 1 (IPS) | IPS completo con reglas de ejecución |
| **Hardware: PC + 2 Monitores** | `📈 Plantillas Estrategia Inversión` → Plantilla 1 | Sección "Setup Físico" en IPS |
| **TradingView (Análisis)** | `📱 Mejores Brokers Móvil Acciones` → Comparativa features | TradingView embebido en Cocos/IBKR/XTB |
| **MetaTrader 5 (Ejecución Forex/Futuros)** | `01 - Bug Bounty/` → Nota nueva `Trading Setup MT5.md` | Setup MT5 brokers (XM, Exness, IC Markets) |
| **IBKR (Etapa Avanzada: ETFs/Acciones/Opciones)** | `🌍 Brokers Internacionales para Argentinos` → Deep Dive IBKR | IBKR GlobalTrader vs Mobile vs TWS |
| **Timeframes: 1H/4H/Diario + 5m/15m** | `📈 Plantillas Estrategia Inversión` → Plantilla 1 | Reglas de entrada/salida en IPS |
| **Indicadores: EMA 50/200, RSI 14, Fibonacci, S/R** | `📈 Plantillas Estrategia Inversión` → Plantilla 1 | Setup técnico en IPS |
| **Gestión Riesgo: 1-2%, RR 1:2, Max 3-5 trades/día** | `📈 Plantillas Estrategia Inversión` → Plantilla 1 | Reglas obligatorias en IPS |
| **Diario: Notion/Excel/Sheets** | `📊 Portfolio Tracker Setup` → Opción B (Notion) | Trading Journal DB en Notion |
| **Setup Físico: Escritorio, silla, auriculares** | `📈 Plantillas Estrategia Inversión` → Plantilla 1 | Checklist físico en IPS |
| **Perfiles: Principiante/Intermedio/Avanzado** | `📈 Plantillas Estrategia Inversión` → Plantilla 2 | Modelos A/B/C + DCA + Rebalanceo |

---

## 🎯 Resumen Ejecutivo: Tu Trading/Inversión Actualizado

### **Si sos INVERSOR (Largo Plazo / Patrimonio)**
```
📍 UBICACIÓN: 02 - Finanzas/
├── IPS Personal → [[📈 Plantillas Estrategia Inversión]] (Plantilla 1)
├── Asset Allocation → [[📈 Plantillas Estrategia Inversión]] (Plantilla 2: Modelo B Moderado)
├── DCA Automatizado → [[📈 Plantillas Estrategia Inversión]] (Plantilla 3) + [[⚡ Automatizaciones Financieras]]
├── Rebalanceo Trimestral → [[📈 Plantillas Estrategia Inversión]] (Plantilla 4)
├── Broker Principal → IBKR GlobalTrader (ETFs) + IOL (CEDEARs)
├── Tracker → [[📊 Portfolio Tracker Setup]] (Sheets + Notion)
└── Fiscal → [[🇦🇷 Guía Fiscal Inversiones Argentina 2026]]
```

### **Si sos TRADER ACTIVO (Forex / Futuros / Intradía / Scalping)**
```
📍 UBICACIÓN: 01 - Bug Bounty/  (crear nota nueva)
├── Setup MT5 → Brokers: XM / Exness / IC Markets / Pepperstone
├── Análisis → TradingView (gráficos) + MT5 (ejecución)
├── Risk Management → 1-2% risk, RR 1:2, max 3-5 trades/día
├── Journal → Notion DB "Trading Journal" (ver Portfolio Tracker Setup)
├── Horarios → London Open / NY Open / Overlap
└── Pares Principales → EUR/USD, GBP/USD, USD/JPY, XAU/USD, Indices (US30, NAS100)
```

### **Si sos TRADER ALGORÍTMICO / QUANT**
```
📍 UBICACIÓN: 03 - Proyectos/  (crear nota nueva)
├── Infra → Python + IBKR API / MT5 Python / Binance API
├── Data → Polygon.io / Twelve Data / Yahoo Finance / Crypto APIs
├── Backtesting → VectorBT / Backtrader / Zipline
├── Execution → IBKR API / Binance API / MT5 via Python
├── Risk → Kelly Criterion / Volatility Targeting / Drawdown Controls
└── Monitoring → Grafana + Prometheus / Telegram Alerts
```

---

## 📋 Contenido Original (Referencia Histórica)

### Filosofía
- 1 plataforma para analizar (TradingView)
- 1 para ejecutar (MT5 / IBKR)
- 1 para gestionar riesgo/seguimiento
- Cero distracciones, todo replicable

### Hardware Mínimo
- CPU: i5/Ryzen 5+
- RAM: 16 GB mínimo
- SSD obligatorio
- **2 Monitores (ideal)**: Monitor 1 Análisis (HTF), Monitor 2 Ejecución (TF entrada + MT5)

### Software Core
| Herramienta | Uso | Brokers Compatibles |
|-------------|-----|---------------------|
| **TradingView** ⭐⭐⭐⭐⭐ | Análisis: tendencias, S/R, Fibonacci, RSI, EMAs | Todos (web/app) |
| **MetaTrader 5** ⭐⭐⭐⭐⭐ | Ejecución: Forex, Índices, Swing/Intradía | XM, Exness, RoboForex, IC Markets |
| **Interactive Brokers** | Inversión: ETFs, Acciones, Opciones reales, Largo plazo | IBKR directo |

### Timeframes
- **Análisis**: 1H / 4H / Diario
- **Entrada**: 5m / 15m
- **Nunca operar sin contexto HTF**

### Indicadores (Pocos y Bien Usados)
- EMA 50, EMA 200
- RSI (14)
- Fibonacci
- Zonas S/R (manual)
- **No sobrecargar**

### Gestión de Riesgo (Obligatorio)
- Riesgo por trade: **1-2%**
- RR mínimo: **1:2**
- Máx trades/día: **3-5**
- **Stop SIEMPRE**
- El 90% pierde por no respetar esto

### Control y Seguimiento
- Diario en Notion / Excel / Google Sheets
- Registrar: Par, Setup, Emoción, Resultado
- **Esto te hace rentable, no el indicador**

### Setup Físico
- Escritorio ordenado, teclado cómodo, mouse preciso, silla decente, auriculares focus
- **Trading = concentración, no adrenalina**

### Perfiles
| Nivel | Setup |
|-------|-------|
| **Principiante** | TradingView + MT5 Demo 1-2 meses, 1 par (EUR/USD) |
| **Intermedio** | 2 pares, Alerts, Journal serio |
| **Avanzado** | TradingView Pro + MT5 + IBKR, Diversificación real |

---

## 🔗 Accesos Rápidos a lo Nuevo

| Para... | Ir A |
|---------|------|
| **Crear tu IPS (Investment Policy Statement)** | `[[📈 Plantillas Estrategia Inversión]]` → Plantilla 1 |
| **Definir Asset Allocation según tu perfil** | `[[📈 Plantillas Estrategia Inversión]]` → Plantilla 2 (Modelos A/B/C) |
| **Automatizar DCA semanal/quincenal/mensual** | `[[📈 Plantillas Estrategia Inversión]]` → Plantilla 3 + `[[⚡ Automatizaciones Financieras]]` |
| **Ejecutar rebalanceo trimestral sin emociones** | `[[📈 Plantillas Estrategia Inversión]]` → Plantilla 4 (Checklist) |
| **Decidir Lump Sum vs DCA para ingreso grande** | `[[📈 Plantillas Estrategia Inversión]]` → Plantilla 5 |
| **Stress test tu portfolio vs 2008/2020/2022** | `[[📈 Plantillas Estrategia Inversión]]` → Plantilla 6 |
| **Registrar cada decisión para aprender** | `[[📈 Plantillas Estrategia Inversión]]` → Plantilla 7 (Decision Journal) |
| **Setup MT5 para Forex/Futuros** | Crear `01 - Bug Bounty/Trading Setup MT5.md` |
| **Tracker portfolio unificado (acciones+cripto+efectivo)** | `[[📊 Portfolio Tracker Setup]]` |

---

## 🗂️ Archivo: Migración Completada

- ✅ Contenido de **inversión** (IBKR, ETFs, largo plazo) → `02 - Finanzas/` (10 notas nuevas)
- ✅ Contenido de **trading activo** (MT5, Forex, setup técnico) → `01 - Bug Bounty/` (pendiente nota dedicada)
- ✅ Filosofía, risk management, journal → `📈 Plantillas Estrategia Inversión` (IPS + Plantillas)
- ✅ Hardware, setup físico → IPS (Plantilla 1) + Portfolio Tracker Setup
- ✅ Estructura unificada con frontmatter estándar, tags, enlaces bidireccionales

---

*Migración completada: 2026-08-28 | Vault unificado: `Obsidian Vault/` | Carpeta origen `Adri/` pendiente de eliminación*