---
title: "Presupuesto y Cashflow System: Método YNAB/50-30-20, Categorías, Automatización, Revisión Mensual"
tags: ["finanzas", "presupuesto", "cashflow", "ynab", "50-30-20", "automatizacion", "revision-mensual", "argentina"]
created: "2026-08-28"
updated: "2026-08-28"
status: "active"
priority: "high"
related: ["Portfolio Tracker Setup", "Matriz Comparativa Apps Finanzas Completas", "Guía Fiscal Inversiones Argentina 2026", "Automatizaciones Financieras"]
---

# 💸 Presupuesto y Cashflow System (2026)

> **Dinero sin presupuesto = dinero que se escapa**. Sistema práctico para Argentina: inflación, multi-moneda, ingresos variables (bug bounty/freelance).

---

## 🎯 Filosofía: 4 Reglas de Oro (YNAB Adaptado)

| Regla | Principio | Aplicación Argentina |
|-------|-----------|---------------------|
| **1. Give Every Dollar a Job** | Cada peso/USD tiene destino antes de gastarse | Incluir "Inflación Buffer" como categoría obligatoria |
| **2. Embrace True Expenses** | Gastos grandes/irregulares → cuotas mensuales | Seguros, patentes, impuestos, regalos, mantenimiento → fondo mensual |
| **3. Roll with the Punches** | Mover dinero entre categorías cuando cambia realidad | Inflación sube comida → mover de "Ocio" a "Alimentación" sin culpa |
| **4. Age Your Money** | Vivir de ingresos del mes anterior (no paycheck-to-paycheck) | Objetivo: **30+ días de antigüedad del dinero** |

---

## 📊 Estructura de Categorías (Multi-Moneda ARS/USD)

### **Ingresos (Orden de Prioridad)**
```
💰 INGRESOS
├── 🇺🇸 USD Income (Bug Bounty, Freelance, Export Services)
│   ├── Takenos/Wise/Payoneer → USD Account
│   └── Conversión programada: 70% Inversión / 30% Gasto ARS
├── 🇦🇷 ARS Income (Sueldo, Honorarios locales, Alquileres)
│   └── Cuenta ARS principal (Mercado Pago / Banco)
└── 💎 Crypto Income (Staking, Airdrops, DeFi yield)
    └── Wallet → Convertir USDC → USD Account / Inversión
```

### **Gastos: Jerarquía 4 Niveles**

#### **Nivel 1: Supervivencia (No Negociable)**
| Categoría | % Target ARS | % Target USD | Frecuencia | Notas |
|-----------|--------------|--------------|------------|-------|
| 🏠 **Vivienda** (Alquiler/Expensas/Impuestos) | 25-35% | - | Mensual | Prioridad #1 |
| 🍽️ **Alimentación** (Supermercado, Delivery básico) | 15-20% | - | Semanal | Incluye inflación buffer |
| 🏥 **Salud** (Prepaga, Medicamentos, Emergencias) | 5-10% | - | Mensual/Eventual | Fondo emergencia médica |
| 🚌 **Transporte** (Combustible, Servicios, Uber esencial) | 5-8% | - | Mensual | |
| 📱 **Comunicaciones** (Celular, Internet, Streaming básico) | 3-5% | - | Mensual | |
| **Subtotal Supervivencia** | **53-78%** | - | | **Meta: <65% ARS Income** |

#### **Nivel 2: Calidad de Vida (Discrecional)**
| Categoría | % Target | Frecuencia | Regla |
|-----------|----------|------------|-------|
| 🎮 **Ocio/Entretenimiento** | 5-10% | Mensual | "Fun money" sin culpa |
| 👕 **Ropa/Cuidado Personal** | 3-5% | Trimestral | Fondo acumulativo |
| 🎓 **Educación/Desarrollo** | 3-5% | Mensual | Cursos, libros, suscripciones pro |
| 🎁 **Regalos/Eventos** | 2-3% | Mensual | Fondo acumulativo (navidad, cumples) |
| 🏋️ **Deporte/Gimnasio** | 2-4% | Mensual | Salud preventiva |
| **Subtotal Calidad Vida** | **15-27%** | | **Meta: 15-20% ARS Income** |

#### **Nivel 3: Construcción Patrimonial (Inversión = Gasto Obligatorio)**
| Categoría | Vehicle | % Target | Prioridad |
|-----------|---------|----------|-----------|
| 🏦 **Emergencia** (3-6 meses gastos) | FCI Money Market / MP / Ualá | 10% hasta completar | **#1** |
| 📈 **Inversión AR** (CEDEARs, Bonos, FCI) | IOL / Cocos / Balanz | 15-20% | **#2** |
| 🌍 **Inversión Global** (ETFs, Acciones) | IBKR / Trading 212 | 15-25% | **#3** |
| 🪙 **Cripto** (BTC, ETH, Stablecoins) | Binance → Cold Storage | 5-10% | **#4** |
| 🏠 **Bienes Raíces / Grandes Metas** | Ahorro específico | Variable | Según meta |
| **Subtotal Patrimonial** | | **45-70%** | **Meta: >30% Total Income** |

#### **Nivel 4: Inflación & Buffer (Específico Argentina)**
| Categoría | % Target | Mecánica |
|-----------|----------|----------|
| 📉 **Inflación Buffer** | 5-10% ARS Income | Diferencia real vs presupuestado → absorbe sorpresas |
| 🔄 **Reexpresión Monetaria** | Automática | Recalcular montos ARS mensual por IPC/BCRA |

---

## 💱 Sistema Multi-Moneda: ARS / USD / USDC

### **Cuentas Físicas (Buckets Reales)**
```
┌────────────────────────────────────────────────────────────┐
│  🇺🇸 CUENTA USD (Wise / Takenos / IBKR Cash)               │
│  ├── Ingresos USD directos                                 │
│  ├── Reserva 1-2 meses gastos USD (viajes, suscripciones)  │
│  ├── Funding IBKR / Trading 212 (auto-invest)              │
│  └── Excedente → Conversión programada a ARS/Inversión     │
├────────────────────────────────────────────────────────────┤
│  🇦🇷 CUENTA ARS PRINCIPAL (Mercado Pago / Banco / Ualá)    │
│  ├── Ingresos ARS                                          │
│  ├── Conversión USD→ARS (semanal/quincenal, monto fijo)    │
│  ├── Gastos supervivencia + calidad vida (auto-debito)     │
│  └── Buffer 1 mes gastos ARS                               │
├────────────────────────────────────────────────────────────┤
│  🪙 CUENTA STABLECOINS (Binance / Belo / DolarApp / Cold)  │
│  ├── USDC/USDT rendimientos (5-15% APY)                    │
│  ├── Gasto tarjeta (Belo/DolarApp)                         │
│  ├── Bridge USD↔ARS (P2P)                                  │
│  └── Reserva oportunidad (comprar dips)                    │
└────────────────────────────────────────────────────────────┘
```

### **Flujo Mensual Automatizado**
```
1ro-5to DÍA MES:
├── 📥 Recibir ingresos USD (Takenos/Wise) → Cuenta USD
├── 🔄 Convertir 70% USD→ARS (Takenos P2P / Wise) → Cuenta ARS
├── 💰 Pagar tarjetas / servicios (auto-debito Cuenta ARS)
├── 📊 Revisar presupuesto mes anterior → Ajustar categorías
├── 📈 Ejecutar inversiones programadas (DCA):
│   ├── IBKR: Auto-invest ETFs (SPY, QQQ, VT) → % USD Income
│   ├── IOL: Auto-comprar CEDEARs/FCI → % ARS Disponible
│   └── Binance: DCA BTC/ETH/USDC → % Crypto Budget
└── 📝 Registrar todo en Portfolio Tracker + YNAB/Actual/Sheets
```

---

## 🛠️ Herramientas: Comparativa 2026

| Herramienta | Tipo | Costo | Multi-Moneda | Automatización | Ideal Para |
|-------------|------|-------|--------------|----------------|------------|
| **YNAB (You Need A Budget)** | SaaS Web/Móvil | $99/año | ⚠️ Manual (1 moneda base) | Bank sync (US/EU), API limitada | Metodología pura, disciplina |
| **Actual Budget** | Self-hosted / Cloud | Gratis / $4/mes | ✅ Nativo multi-moneda | Bank sync (Nordigen/Gocardless), API abierta | **Mejor FOSS, multi-moneda real** |
| **Google Sheets + Forms** | DIY | Gratis | ✅ Total control | Apps Script, n8n, Zapier | **Control total, gratis, programable** |
| **Excel + Power Query** | Desktop | Licencia Office | ✅ Total control | Power Automate, VBA | Usuarios Office, offline |
| **Notion + Databases** | SaaS | Gratis / $8/mes | ✅ Flexible | n8n, Make, API | Visual, knowledge base integrado |
| **Fintonic / Wallet (Apps AR)** | Móvil | Gratis | ❌ Solo ARS | Bank sync AR (read-only) | Vista rápida, no presupuesto real |
| **Monarch Money** | SaaS | $50-100/año | ✅ USD + Crypto | Plaid (US), manual AR | US residents con cuentas AR |

> 🏆 **Mi stack 2026**: **Actual Budget (self-hosted en VPS)** + **Google Sheets (dashboard fiscal/inversión)** + **Notion (knowledge base + metas)**.

---

## 📋 Setup Actual Budget (Self-Hosted) - Guía Rápida

### **Instalación (VPS $5-10/mes o Raspberry Pi)**
```bash
# Docker Compose (actualbudget/actual-server)
version: '3.8'
services:
  actual-server:
    image: actualbudget/actual-server:latest
    ports:
      - "5006:5006"
    environment:
      - ACTUAL_UPLOAD_FILE_SIZE_LIMIT=50MB
      - ACTUAL_HTTPS=false  # Usar reverse proxy nginx + Let's Encrypt
    volumes:
      - ./data:/data
    restart: unless-stopped

# Nginx reverse proxy + SSL
# Acceso: https://budget.tudominio.com
```

### **Configuración Inicial**
```
1. Crear presupuesto: "Presupuesto Principal 2026"
2. Moneda base: ARS (para gastos diarios)
3. Añadir monedas: USD, USDC (Settings → Currencies)
4. Crear cuentas (Accounts):
   ├── MP/Ualá (ARS) → Sync: Manual CSV / Nordigen si soportado
   ├── Wise/Takenos (USD) → Sync: Manual CSV
   ├── Binance (USDC) → Sync: Manual CSV / API custom
   ├── IBKR (USD) → Sync: Manual CSV (Flex Queries)
   └── Efectivo (ARS/USD) → Manual
5. Importar CSV histórico (últimos 3-6 meses) → Categorizar masivamente
6. Definir categorías (ver estructura arriba) + Targets mensuales
7. Configurar reglas de renombrado/auto-categorización
8. Activar "Roll over" para categorías acumulativas (Regalos, Ropa, Médico)
```

### **Automatización Import (n8n / GitHub Actions / Cron)**
```python
# sync_bank_csv.py - Ejecutar diario 6am
import actualbudget
import pandas as pd

# 1. Descargar CSV cuentas (email/portal/browser automation)
# 2. Normalizar: Date, Payee, Amount, Currency, Account
# 3. Push a Actual via API
client = actualbudget.Client(url="https://budget.tudominio.com", password="...")
for tx in normalized_transactions:
    client.create_transaction(account_id=tx.account, data=tx)

# 4. Notificar Telegram: "Synced X transactions from Y accounts"
```

---

## 📅 Rituales: Cadencia de Revisión

| Frecuencia | Actividad | Duración | Herramienta |
|------------|-----------|----------|-------------|
| **Diario (5 min)** | Capturar gasto efectivo / revisar alertas | 5 min | App móvil Actual / Notion Quick Capture |
| **Semanal (30 min)** | Reconciliar cuentas / categorizar pendientes / mover buffers | 30 min | Actual Budget + Sheets |
| **Mensual (90 min)** | **REVISIÓN COMPLETA** (ver checklist abajo) | 90 min | Sheets Dashboard + Notion + Contador (trimestral) |
| **Trimestral (3 hrs)** | Revisión estratégica: metas, asset allocation, fiscal | 3 hrs | Portfolio Tracker + Contador |
| **Anual (1 día)** | Planificación anual: metas, presupuesto base, seguros, impuestos | 1 día | Todo el stack + Contador + Familia |

---

## ✅ Checklist Revisión Mensual (90 Min)

```
[ ] 1. RECONCILIACIÓN (15 min)
    [ ] Actual Budget: Todas las cuentas cuadradas (saldo real = saldo app)
    [ ] Identificar transacciones sin categorizar → Categorizar
    [ ] Detectar duplicados / errores importación

[ ] 2. PRESUPUESTO VS REAL (20 min)
    [ ] Comparar: Target vs Actual por categoría (Nivel 1-4)
    [ ] Identificar >3 categorías con desviación >15%
    [ ] Aplicar Regla 3: Mover dinero entre categorías (Roll with punches)
    [ ] Actualizar targets próximo mes (estacionalidad, inflación)

[ ] 3. CASH FLOW PROYECTADO (15 min)
    [ ] Ingresos confirmados próximo mes (USD + ARS)
    [ ] Gastos fijos confirmados (alquiler, servicios, suscripciones)
    [ ] Gastos variables estimados (comida, transporte, ocio)
    [ ] Superávit/Déficit proyectado → Decisión: Invertir / Ahorrar / Ajustar

[ ] 4. INVERSIONES PROGRAMADAS (15 min)
    [ ] Verificar DCA ejecutadas (IBKR, IOL, Binance)
    [ ] Rebalancear si desviación >5% targets (ver Portfolio Tracker)
    [ ] Registrar en Fiscal_Events (dividendos, staking, trades)

[ ] 4. MÉTRICAS CLAVE (10 min)
    [ ] Tasa Ahorro = (Inversiones + Emergencia) / Ingreso Total → Target >30%
    [ ] Días Antigüedad Dinero (YNAB Age of Money) → Target >30 días
    [ ] Gasto Supervivencia / Ingreso ARS → Target <65%
    [ ] Inflación Real vs Presupuestada → Ajustar Buffer

[ ] 5. ACCIONES (15 min)
    [ ] Listar 3-5 acciones concretas para próximo mes
    [ ] Asignar responsable (Vos / Pareja / Automatización)
    [ ] Poner en Notion "Acciones Mes" con fecha límite
```

---

## 📈 Métricas de Salud Financiera (Dashboard)

| Métrica | Fórmula | Target Saludable | Alerta Roja |
|---------|---------|------------------|-------------|
| **Tasa Ahorro Neta** | (Inversiones + ΔEmergencia) / Ingreso Neto Total | **> 30%** | < 15% |
| **Días Antigüedad Dinero** | Promedio ponderado días desde ingreso hasta gasto | **> 30 días** | < 14 días |
| **Ratio Supervivencia** | Gasto Nivel 1 / Ingreso ARS | **< 65%** | > 80% |
| **Fondo Emergencia** | Saldo Emergencia / Gasto Mensual Promedio | **> 6 meses** | < 3 meses |
| **Deuda Neta** | Deudas (tarjeta, préstamos) - Efectivo disponible | **$0 o negativo** | > 1 mes ingresos |
| **Inflación Personal** | (Gasto Real Mes N / Gasto Real Mes N-1) - 1 | ≈ IPC Oficial | >> IPC (lifestyle creep) |
| **Cobertura Inversión** | Valor Portfolio / (Gasto Anual × 25) | **> 1.0 (FI)** | < 0.3 |

---

## 🇦🇷 Adaptaciones Argentina: Inflación & Ingresos Variables

### **Inflación: Reexpresión Mensual Automática (Sheets/App Script)**
```javascript
// Ejecutar 1ro de cada mes: Actualizar targets ARS por IPC
function updateInflationTargets() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const config = ss.getSheetByName('Config');
  const ipcMensual = config.getRange('B1').getValue(); // Ej: 0.045 = 4.5%
  
  const budget = ss.getSheetByName('Budget_Targets');
  const data = budget.getRange('A2:D100').getValues();
  
  data.forEach((row, i) => {
    if (row[2] === 'ARS') { // Columna C = Moneda
      const newTarget = row[3] * (1 + ipcMensual); // Columna D = Target
      budget.getRange(i+2, 4).setValue(Math.round(newTarget));
    }
  });
}
```

### **Ingresos Variables (Bug Bounty / Freelance): Fondo de Estabilización**
```
┌─────────────────────────────────────────────────────────────┐
│  FONDO ESTABILIZACIÓN INGRESOS (FEI)                        │
│  ├── Recibe: 100% ingresos variables USD                    │
│  ├── Paga: "Sueldo ficticio" fijo mensual a Cuenta ARS     │
│  │   (Promedio últimos 12 meses × 0.8 seguridad)            │
│  ├── Acumula: Excedente en meses buenos                     │
│  ├── Cubre: Déficit en meses malos (sin tocar presupuesto)  │
│  └── Tope: 12 meses "sueldo ficticio" → Excedente a Inversión│
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 Plantillas Listas para Usar

### **Google Sheets: Presupuesto Maestro**
```
Hoja 1: CONFIG (IPC, TC, Targets %, Cuentas, Categorías)
Hoja 2: INGRESOS_LOG (Fecha, Fuente, Moneda, Monto, Categoría, Notas)
Hoja 3: GASTOS_LOG (Fecha, Cuenta, Categoría, Subcategoría, Monto, Moneda, Descripción)
Hoja 4: BUDGET_TARGETS (Categoría, Target_ARS, Target_USD, Acumulativo_Sí/No)
Hoja 5: MONTHLY_SUMMARY (Pivot: Mes x Categoría → Real vs Target vs %)
Hoja 6: CASHFLOW_PROJECTION (Próximos 12 meses: Ingresos, Gastos, Superávit, Inversión)
Hoja 7: METRICS_DASHBOARD (KPIs arriba + Gráficos: Sparklines, Waterfall, Sankey)
Hoja 8: INFLATION_ADJUSTMENT (Historial IPC, Factor acum, Proyección)
```

### **Notion: "Presupuesto 2026" Page**
```
├── 📊 Dashboard (Linked DB: Monthly Summary + Metrics)
├── 🎯 Metas Anuales (Targets: Ahorro, Inversión, Deuda, Emergencia)
├── 📅 Rituales (Checklists Diario/Semanal/Mensual/Trimestral)
├── 💡 Decisiones Log (Registro decisiones: "Mover $X de Ocio a Comida", "Aumentar DCA IBKR")
├── 📚 Knowledge Base (Artículos, videos, cursos presupuesto)
└── 👥 Shared (Acceso pareja/familia: vista comentario)
```

---

*Última actualización: 2026-08-28 | La clave no es la herramienta, es el **hábito semanal**. 30 min/semana > 4 hrs/mes.*