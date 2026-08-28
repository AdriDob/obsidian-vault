---
title: "Portfolio Tracker Setup: Hojas/Notion/Excel + APIs + Automatización"
tags: ["finanzas", "portfolio", "tracker", "notion", "excel", "google-sheets", "apis", "automatizacion", "google-finance"]
created: "2026-08-28"
updated: "2026-08-28"
status: "active"
priority: "high"
related: ["Matriz Comparativa Apps Finanzas Completas", "Guía Fiscal Inversiones Argentina 2026", "CEDEARs Guía Completa", "Automatizaciones Financieras"]
---

# 📊 Portfolio Tracker Setup: Sistema Unificado de Seguimiento

> **Un solo dashboard que vea TODO**: Acciones/CEDEARs (AR + Global) + Cripto + Efectivo + Inmuebles + Alternativos. Actualizable, auditable, listo para contador.

---

## 🎯 Arquitectura Recomendada (3 Capas)

```
┌─────────────────────────────────────────────────────────────┐
│  CAPA 1: DATOS (Fuentes Primarias)                          │
│  ├── Brokers AR (IOL, Cocos, Balanz) → CSV/PDF mensual      │
│  ├── Broker Global (IBKR) → Activity Statement + Flex Queries│
│  ├── Exchanges Cripto (Binance, Bybit, Kraken) → API/CSV    │
│  ├── Wallets (MetaMask, Ledger) → Addresses públicos        │
│  ├── Bancos/Fintech (MP, Ualá, Wise, Takenos) → CSV/PDF    │
│  └── Precios Referencia → Yahoo Finance, CoinGecko, BYMA    │
└─────────────────────────────────────────────────────────────┘
                              ↓ ETL (Mensual / Semanal / Diario)
┌─────────────────────────────────────────────────────────────┐
│  CAPA 2: PROCESAMIENTO (Motor Cálculo)                      │
│  ├── Google Sheets (Motor principal: fórmulas + Apps Script)│
│  ├── Notion (Dashboard visual + Base conocimiento)          │
│  ├── Python/n8n (Automatizaciones avanzadas)                │
│  └── Portfolio Performance (Validación local / FOSS)        │
└─────────────────────────────────────────────────────────────┘
                              ↓ Output
┌─────────────────────────────────────────────────────────────┐
│  CAPA 3: CONSUMO (Vistas)                                   │
│  ├── 📱 Móvil: Notion App / Sheets App                      │
│  ├── 💻 Desktop: Notion Web / Sheets / PP Desktop           │
│  ├── 📋 Contador: Excel export limpio + Koinly report       │
│  └── 🤖 Alertas: Telegram/Email (rebalanceo, stops, fiscal) │
└─────────────────────────────────────────────────────────────┘
```

---

## 🛠️ Opción A: Google Sheets (Motor Gratuito + Potente)

### **Estructura de Pestañas (Sheets)**

| Pestaña | Propósito | Fuente | Frecuencia |
|---------|-----------|--------|------------|
| `Config` | Parámetros: TC BCRA, tickers, API keys, umbrales | Manual | Inicial |
| `Holdings_Raw` | Datos brutos importados (broker, symbol, qty, avg_cost, currency) | CSV Upload / API | Mensual |
| `Prices_Live` | Precios tiempo real (GOOGLEFINANCE + custom functions) | Yahoo/CoinGecko/BYMA | Diario (auto) |
| `Holdings_Calc` | Cálculos: MV, P&L, %, asignación, FX, valuación 31/12 | Fórmulas | Auto |
| `Allocation` | Vista por asset class, geografía, sector, moneda | Pivot/Query | Auto |
| `Transactions` | Log completo: fecha, tipo, symbol, qty, price, fees, broker | Manual + Import | Cada op |
| `Fiscal_Arg` | Cálculos Ganancias/BP: ganancias capital, dividendos, valuación BP | Fórmulas | Mensual/Anual |
| `Rebalance` | Target % vs Actual % → Órdenes sugeridas | Fórmulas | Semanal |
| `Dashboard` | Resumen visual: KPIs, gráficos, alertas | Charts + Conditional Format | Auto |
| `Archive_YYYY` | Snapshots mensuales para auditoría | Script | Mensual (auto) |

### **Fórmulas Clave (Sheets)**

```excel
-- Valuación en ARS (Celda ejemplo: Holdings_Calc!E2)
=SI(C2="ARS"; D2; SI(C2="USD"; D2*Config!$B$1; D2*GOOGLEFINANCE("CURRENCY:"&C2&"ARS")))

-- Precio CEDEAR (BYMA no está en GOOGLEFINANCE nativo)
=IMPORTXML("https://www.balamy.com.ar/cedears/"&B2; "//span[@class='price']")
-- O usar API BYMA: https://api.bymadata.com.ar/v1/instruments/{symbol}/price

-- Precio Cripto (CoinGecko gratis)
=IMPORTJSON("https://api.coingecko.com/api/v3/simple/price?ids="&MINUSC(B2)&"&vs_currencies=usd"; "/usd")

-- Ganancia Capital (FIFO simplificado para Sheets)
=SI(F2="VENTA"; (G2-H2)*I2; 0)  -- (Precio venta - Precio promedio) * Cantidad

-- Bienes Personales Valuación 31/12
=SI(Y(MES(HOY())=12; DIA(HOY())=31); Valuación_ARS; "")
```

### **Apps Script: Automatizaciones (Extensions → Apps Script)**

```javascript
// 1. Snapshot mensual automático (Trigger: 1ro de cada mes 00:05)
function monthlySnapshot() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const source = ss.getSheetByName('Holdings_Calc');
  const targetName = 'Archive_' + Utilities.formatDate(new Date(), 'GMT-3', 'yyyy_MM');
  const target = ss.insertSheet(targetName);
  source.copyTo(target);
  target.getRange('A1').setValue('SNAPSHOT ' + Utilities.formatDate(new Date(), 'GMT-3', 'yyyy-MM-dd'));
}

// 2. Alerta rebalanceo (Trigger: Diario 9:00)
function checkRebalance() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const dash = ss.getSheetByName('Rebalance');
  const alerts = dash.getRange('A2:Z100').getValues()
    .filter(r => r[3] > 0.05) // Desviación > 5%
    .map(r => `${r[0]}: ${(r[3]*100).toFixed(1)}% desviación → Target ${(r[2]*100).toFixed(1)}%`);
  
  if (alerts.length > 0) {
    sendTelegram('🔄 REBALANCEO NECESARIO\n' + alerts.join('\n'));
  }
}

// 3. Fetch precios crypto (Trigger: Cada 30 min)
function fetchCryptoPrices() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const config = ss.getSheetByName('Config');
  const symbols = config.getRange('B2:B50').getValues().flat().filter(Boolean);
  const prices = {};
  
  // Batch request CoinGecko
  const url = 'https://api.coingecko.com/api/v3/simple/price?ids=' + 
    symbols.map(mapToCoingeckoId).join(',') + '&vs_currencies=usd,ars';
  const response = UrlFetchApp.fetch(url);
  const data = JSON.parse(response.getContentText());
  
  // Escribir en Prices_Live
  const priceSheet = ss.getSheetByName('Prices_Live');
  symbols.forEach((sym, i) => {
    const id = mapToCoingeckoId(sym);
    if (data[id]) {
      priceSheet.getRange(i+2, 3).setValue(data[id].usd);    // USD
      priceSheet.getRange(i+2, 4).setValue(data[id].ars);    // ARS
    }
  });
}

function mapToCoingeckoId(symbol) {
  const map = {'BTC':'bitcoin','ETH':'ethereum','USDC':'usd-coin','USDT':'tether','SOL':'solana','ADA':'cardano'};
  return map[symbol] || symbol.toLowerCase();
}

function sendTelegram(message) {
  const botToken = PropertiesService.getScriptProperties().getProperty('TELEGRAM_BOT_TOKEN');
  const chatId = PropertiesService.getScriptProperties().getProperty('TELEGRAM_CHAT_ID');
  UrlFetchApp.fetch(`https://api.telegram.org/bot${botToken}/sendMessage`, {
    method: 'post',
    payload: {chat_id: chatId, text: message, parse_mode: 'HTML'}
  });
}
```

---

## 🛠️ Opción B: Notion (Dashboard Visual + Knowledge Base)

### **Bases de Datos Notion (Relacionadas)**

| Database | Propiedades Clave | Relaciones |
|----------|-------------------|------------|
| `Assets` | Symbol, Name, Type (Stock/ETF/Crypto/Cash/Real Estate), Currency, Broker, Wallet Address, ISIN | → `Transactions`, → `Prices` |
| `Transactions` | Date, Asset (relation), Type (Buy/Sell/Dividend/Staking/Transfer), Qty, Price, Fees, Total, Broker, Notes | → `Assets` |
| `Prices_History` | Asset (relation), Date, Price_USD, Price_ARS, Source | → `Assets` |
| `Targets` | Asset (relation), Target_%, Min_%, Max_%, Last_Rebalance | → `Assets` |
| `Fiscal_Events` | Date, Asset, Type (Capital_Gain/Dividend/Staking/Income), Amount_ARS, Tax_Year, Status | → `Assets` |
| `Brokers_Accounts` | Name, Type, Currency, API_Connected, Last_Sync, Credentials_Ref | → `Assets` |

### **Vistas Útiles (Linked Databases)**

| Vista | Filtro/Orden | Uso |
|-------|--------------|-----|
| `Portfolio Overview` | Group by Type → Sum MV_ARS | Dashboard principal |
| `By Geography` | Group by Country (AR/US/Global) | Diversificación |
| `By Sector` | Group by Sector (Tech/Finance/Energy/Crypto) | Concentración |
| `Rebalance Needed` | Formula: `abs(prop("Current_%") - prop("Target_%")) > 0.05` | Alertas |
| `Fiscal Year 2026` | Filter: `Year(prop("Date")) == 2026` | Preparación DDJJ |
| `Crypto Staking/Yield` | Filter: Type = Staking | Rendimiento pasivo |

### **Fórmulas Notion (Property: Formula)**

```javascript
// MV_ARS (Market Value en ARS)
if (prop("Currency") == "ARS") prop("Qty") * prop("Price_ARS")
else if (prop("Currency") == "USD") prop("Qty") * prop("Price_USD") * prop("USD_ARS_Rate")
else prop("Qty") * prop("Price_USD") * prop("FX_Rate")

// Current_% (Asignación actual %)
prop("MV_ARS") / prop("Total_Portfolio_MV_ARS")

// Deviation_% (Desviación vs Target)
prop("Current_%") - prop("Target_%")

// Unrealized_PnL_ARS
(prop("Price_Current") - prop("Avg_Cost")) * prop("Qty") * prop("FX_Rate")

// Fiscal_Gain_Capital (Simplificado)
if (prop("Transaction_Type") == "Sell") 
  (prop("Price") - prop("Avg_Cost_At_Sale")) * prop("Qty") * prop("FX_Rate")
else 0
```

### **Notion API + Python Sync (Para datos reales)**

```python
# sync_notion.py - Ejecutar via cron/n8n
import requests
import pandas as pd
from notion_client import Client

notion = Client(auth=os.getenv("NOTION_TOKEN"))

def sync_broker_csv(broker, csv_path):
    df = pd.read_csv(csv_path)
    for _, row in df.iterrows():
        # Upsert Asset
        asset = notion.databases.query(
            database_id=ASSETS_DB,
            filter={"property": "Symbol", "rich_text": {"equals": row['symbol']}}
        )
        if asset['results']:
            asset_id = asset['results'][0]['id']
            notion.pages.update(asset_id, properties={"Qty": {"number": row['qty']}})
        else:
            notion.pages.create(parent={"database_id": ASSETS_DB}, properties={
                "Symbol": {"title": [{"text": {"content": row['symbol']}}]},
                "Qty": {"number": row['qty']},
                "Avg_Cost": {"number": row['avg_cost']},
                "Currency": {"select": {"name": row['currency']}},
                "Broker": {"select": {"name": broker}}
            })

# Ejecutar: python sync_notion.py --broker IOL --file holdings_iol.csv
```

---

## 🛠️ Opción C: Portfolio Performance (Validación Local FOSS)

- **Descarga**: https://portfolio-performance.info/
- **Import**: CSV genérico + PDF brokers (parser incluido)
- **Features**: IRR/TWR, rebalanceo, impuestos (alemán/US), gráficos, reportes PDF
- **Uso**: Validación offline de Sheets/Notion. **No sustituye** dashboard diario.

---

## 🔌 APIs de Precios Gratuitas (2026)

| Activo | API | Límite | Key |
|--------|-----|--------|-----|
| **Acciones/ETFs US** | Yahoo Finance (yfinance) | 2000 req/h | No |
| **Acciones/ETFs US** | Alpha Vantage | 25 req/día | Free tier |
| **Acciones/ETFs US** | Twelve Data | 800 req/día | Free tier |
| **CEDEARs BYMA** | BYMA Data API | Consultar | Registro |
| **CEDEARs** | Balanz/InvertirOnline (scraping) | - | No oficial |
| **Cripto** | CoinGecko | 50-100 req/min | No (Demo) |
| **Cripto** | CoinMarketCap | 333 req/día | Free tier |
| **Cripto** | Binance Public API | 1200 req/min | No |
| **Forex** | exchangerate.host | Ilimitado | No |
| **Forex BCRA** | https://api.bcra.gob.ar/estadisticas/v1.0/cotizaciones | Oficial | No |

---

## 📱 Dashboard Móvil: Notion Widgets + Shortcuts

### **iOS Shortcuts (Acceso Rápido)**
```text
# Ver Portfolio Total
Abrir Notion → Database "Assets" → Vista "Portfolio Overview"

# Añadir Transacción
Notion → Create Page → Database "Transactions" → Preguntar campos

# Ver Alertas Rebalanceo
Notion → Database "Assets" → Vista "Rebalance Needed"
```

### **Android: Notion Widget + Tasker**
- Widget: Database "Assets" vista "Portfolio Overview" (se actualiza auto)
- Tasker: Trigger webhook n8n → sync brokers → update Notion

---

## 🤖 Automatización Completa con n8n (Self-hosted / Cloud)

### **Workflows n8n Esenciales**

| Workflow | Trigger | Acciones |
|----------|---------|----------|
| `Daily Price Sync` | Cron 06:00 | Fetch prices → Update Sheets/Notion → Check alerts |
| `Monthly Broker Import` | Cron 01 00:10 | Download CSV (email/portal) → Parse → Upsert Holdings |
| `Crypto Wallet Scan` | Cron 00:00 | Etherscan/BSCScan/TronScan → Balance → Update |
| `Rebalance Check` | Cron Mon 09:00 | Calc deviation → If >5% → Telegram/Email |
| `Fiscal Snapshot` | Cron 31 Dec 23:59 | Valuation 31/12 → Archive → Generate fiscal report |
| `Tax Report Generator` | Manual (Ene) | Aggregate Transactions → FIFO calc → Koinly/Excel export |

---

## 📋 Checklist Implementación

```
[ ] Crear Google Sheets maestro con 10 pestañas
[ ] Configurar GOOGLEFINANCE para tickers US + custom functions CEDEARs/Cripto
[ ] Crear Apps Script: snapshot mensual + alertas rebalanceo + fetch precios
[ ] Configurar Telegram Bot + Chat ID en Script Properties
[ ] Crear Notion workspace + 6 databases relacionadas
[ ] Configurar vistas linked databases en Notion
[ ] Crear n8n workflows (o GitHub Actions/cron) para sync automático
[ ] Importar histórico: CSV brokers 2024-2025 → Sheets + Notion
[ ] Validar contra Portfolio Performance (importar mismo CSV)
[ ] Generar reporte fiscal 2025 de prueba → revisar con contador
[ ] Documentar proceso en Notion: "Cómo actualizar portfolio"
[ ] Compartir acceso Sheets/Notion con contador (solo lectura)
```

---

## 📁 Estructura Archivos Recomendada (Google Drive / Local)

```
/Finanzas_Portfolio/
├── 📊 Portfolio_Master.xlsx (Backup offline mensual)
├── 📊 Portfolio_Master_GSheets (Link)
├── 📁 Raw_Data/
│   ├── 2026-01/ (CSVs brokers enero)
│   ├── 2026-02/
│   └── ...
├── 📁 Fiscal/
│   ├── 2025_DDJJ_Workpapers/
│   ├── 2026_Koinly_Export/
│   └── Contador_Compartido/ (Solo lectura)
├── 📁 Automation/
│   ├── n8n_workflows.json
│   ├── apps_script_code.gs
│   └── python_sync_scripts/
└── 📁 Docs/
    ├── Metodologia_Valuacion.md
    ├── Changelog.md
    └── Contactos_Contador.md
```

---

*Última actualización: 2026-08-28 | Próximo: Integrar n8n workflows + validar con contador*