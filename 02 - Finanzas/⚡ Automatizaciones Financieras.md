---
title: "Automatizaciones Financieras: n8n, Zapier, Make, GitHub Actions - Alertas, Rebalanceo, Reporting, Facturación"
tags: ["finanzas", "automatizacion", "n8n", "zapier", "make", "github-actions", "alertas", "rebalanceo", "reporting", "facturacion"]
created: "2026-08-28"
updated: "2026-08-28"
status: "active"
priority: "high"
related: ["Portfolio Tracker Setup", "Presupuesto y Cashflow System", "Plantillas Estrategia Inversión", "Matriz Comparativa Apps Finanzas Completas"]
---

# ⚡ Automatizaciones Financieras (2026)

> **Automatizá lo aburrido, decidí lo importante**. Stack n8n (self-hosted) + GitHub Actions + Telegram/Email. Cero dependencia SaaS cara.

---

## 🏗️ Arquitectura Automatización

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        ORQUESTADOR CENTRAL: n8n (Self-hosted)               │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │  TRIGGERS   │  │  PROCESS    │  │  ACTIONS    │  │  NOTIFY     │        │
│  │             │  │             │  │             │  │             │        │
│  │ Cron        │→ │ Transform   │→ │ Sheets API  │→ │ Telegram    │        │
│  │ Webhook     │  │ Aggregate   │  │ Notion API  │  │ Email       │        │
│  │ Email IMAP  │  │ Calculate   │  │ IBKR API    │  │ Slack       │        │
│  │ API Poll    │  │ Filter      │  │ Binance API │  │ Webhook     │        │
│  │ GitHub      │  │ Enrich      │  │ Crypto APIs │  │ Pushover    │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                    ┌───────────────┼───────────────┐
                    ▼               ▼               ▼
            ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
            │  DATA LAYER │ │  EXECUTION  │ │  ALERTS     │
            │             │ │             │ │             │
            │ Google      │ │ IBKR        │ │ Telegram    │
            │ Sheets      │ │ Trading 212 │ │ Bot         │
            │ Notion      │ │ Binance     │ │ Email (SMTP)│
            │ PostgreSQL  │ │ Wise/Takenos│ │ Slack       │
            │ (Backups)   │ │ AFIP/ARCA   │ │ Pushover    │
            └─────────────┘ └─────────────┘ └─────────────┘
```

---

## 🤖 n8n: Instalación y Configuración Base

### **Docker Compose (VPS $5-10/mes o Raspberry Pi)**
```yaml
# docker-compose.yml
version: '3.8'
services:
  n8n:
    image: n8nio/n8n:latest
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=n8n.tudominio.com
      - N8N_PORT=5678
      - N8N_PROTOCOL=https
      - NODE_ENV=production
      - GENERIC_TIMEZONE=America/Argentina/Buenos_Aires
      - N8N_ENCRYPTION_KEY=${N8N_ENCRYPTION_KEY}  # Generar: openssl rand -hex 32
      - DB_TYPE=postgresdb
      - DB_POSTGRESDB_HOST=postgres
      - DB_POSTGRESDB_DATABASE=n8n
      - DB_POSTGRESDB_USER=n8n
      - DB_POSTGRESDB_PASSWORD=${POSTGRES_PASSWORD}
    volumes:
      - ./n8n_data:/home/node/.n8n
    depends_on:
      - postgres
    restart: unless-stopped

  postgres:
    image: postgres:15-alpine
    environment:
      - POSTGRES_DB=n8n
      - POSTGRES_USER=n8n
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
    volumes:
      - ./postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

  # Opcional: Redis para cola + cache
  redis:
    image: redis:7-alpine
    volumes:
      - ./redis_data:/data
    restart: unless-stopped

# Nginx reverse proxy + Let's Encrypt SSL
# Acceso: https://n8n.tudominio.com (Basic Auth obligatorio)
```

### **Credenciales n8n a Configurar (Settings → Credentials)**
| Credencial | Tipo | Dónde Obtener |
|------------|------|---------------|
| Google Sheets OAuth2 | Google OAuth2 API | Google Cloud Console |
| Notion API | Notion API | notion.so/my-integrations |
| Telegram Bot | Telegram API | @BotFather → Token |
| SMTP Email | SMTP | Tu proveedor (Gmail, SendGrid, etc.) |
| IBKR API | HTTP Request + Auth | IBKR Client Portal → Settings → API |
| Binance API | HTTP Request + Header | Binance → API Management |
| CoinGecko | HTTP Request (no auth) | Gratis, sin key |
| BCRA API | HTTP Request (no auth) | https://api.bcra.gob.ar |
| AFIP/ARCA | HTTP Request + Cert | Certificado digital AFIP |

---

## 📋 Workflows Esenciales (Importar JSON en n8n)

### **1. DAILY_PRICE_SYNC** (Cron: 0 6 * * * - 6 AM diario)
```
Trigger: Cron (Daily 6:00 AM AR)
    │
    ├─► HTTP Request: CoinGecko /api/v3/simple/price?ids=bitcoin,ethereum,usd-coin,tether,solana,cardano&vs_currencies=usd,ars
    ├─► HTTP Request: Yahoo Finance / Yahoo Finance API (yfinance wrapper)
    ├─► HTTP Request: BYMA API / BCRA Dólar MEP/CCL
    ├─► Function: Normalize → {symbol, price_usd, price_ars, timestamp, source}
    ├─► Google Sheets: Append/Update "Prices_Live" tab
    ├─► Notion: Update "Prices_History" database
    ├─► IF: Price change > 5% vs yesterday → Telegram Alert
    └─► IF: Crypto price change > 10% → Telegram Alert + Log
```

### **2. MONTHLY_BROKER_IMPORT** (Cron: 0 2 1 * * - 1ro cada mes 2 AM)
```
Trigger: Cron (Monthly 1st 2:00 AM)
    │
    ├─► IMAP Email: Search "Subject: Estado de cuenta" FROM brokers@iol/cocos/balanz/ppi
    ├─► For Each Email:
    │     ├─► Download PDF/CSV attachment
    │     ├─► PDF → Text (pdf-parse) OR Parse CSV
    │     ├─► Extract: Holdings, Transactions, Dividends, Fees
    │     ├─► Transform to standard schema
    │     ├─► Google Sheets: Upsert "Holdings_Raw" + "Transactions"
    │     ├─► Notion: Upsert "Assets" + "Transactions" databases
    │     └─► Archive email: Move to "Processed/YYYY-MM"
    │
    ├─► IBKR Flex Query: Download Activity Statement (XML/CSV)
    ├─► Parse IBKR → Standard schema → Sheets + Notion
    │
    ├─► Binance API: /sapi/v1/account/trades + /sapi/v1/asset/assetDividend
    ├─► Parse → Sheets + Notion
    │
    └─► Telegram: "✅ Import mensual completado: X brokers, Y txns, Z dividendos"
```

### **3. REBALANCE_CHECK** (Cron: 0 9 * * 1 - Lunes 9 AM)
```
Trigger: Cron (Weekly Monday 9:00 AM)
    │
    ├─► Google Sheets: Read "Rebalance" tab (Current % vs Target %)
    ├─► Function: Calculate deviation per asset class
    ├─► IF: Any |deviation| > 5% (absolute)
    │     ├─► Build message: "🔄 REBALANCE NEEDED\n• VT: +3.2% (target 40%)\n• AL30: -4.1% (target 15%)\n• BTC: +6.8% (target 10%)"
    │     ├─► Telegram: Send alert + Inline keyboard [Ver Detalle] [Ejecutar Ahora]
    │     └─► Notion: Create "Rebalance Task" in "Tasks" database
    │
    ├─► IF: Any |deviation| > 10% (CRITICAL)
    │     ├─► Telegram: URGENT + Phone call via Twilio (opcional)
    │     └─► Email: Detailed report to contador@
    │
    └─► Always: Log check in "Rebalance_Log" sheet
```

### **4. FISCAL_SNAPSHOT** (Cron: 0 23 31 12 * - 31 Dic 23:00)
```
Trigger: Cron (Yearly Dec 31 23:00)
    │
    ├─► Google Sheets: Snapshot "Holdings_Calc" → "Archive_YYYY"
    ├─► Google Sheets: Calculate valuations 31/12 for BP (ARS + USD × TC BCRA)
    ├─► Function: Generate fiscal report:
    │     ├─► Ganancias Capital: FIFO sales (IBKR, IOL, Binance)
    │     ├─► Dividendos: CEDEARs (7% retención), US stocks (15% W-8BEN)
    │     ├─► Staking/Yield: Crypto income
    │     ├─► Bienes Personales: Valuación 31/12 por activo + TC
    │     └─► Créditos fiscales: Retenciones brokers AR + exterior
    │
    ├─► Google Sheets: Create "Fiscal_YYYY" tab with all calcs
    ├─► Notion: Create "Fiscal Year YYYY" page with linked DBs
    ├─► Export: CSV for Koinly (crypto) + Excel for contador
    ├─► Telegram: "📊 Snapshot Fiscal 31/12/YYYY listo. Revisar en Sheets/Notion"
    └─► Email: Send reports to contador@ + backup@
```

### **5. INVOICE_AUTOMATION** (Webhook: Takenos/Wise/Stripe/PayPal)
```
Trigger: Webhook (POST from Takenos/Wise/Stripe/PayPal)
    │
    ├─► Validate signature (HMAC)
    ├─► Extract: Amount, Currency, Payer, Reference, Date
    ├─► IF: Currency = USD
    │     ├─► Convert to ARS at MEP rate (BCRA API or Cocos)
    │     ├─► Create Factura A (Monotributo/Resp. Inscripto) via AFIP WS
    │     │     ├─► AFIP: FECAESolicitar (Factura Electrónica)
    │     │     └─► Save PDF + CAE + QR
    │     ├─► Record in "Income_Log" (Sheets + Notion)
    │     ├─► Allocate: 70% Investment USD account / 30% ARS spending
    │     └─► Telegram: "💰 Ingreso USD $X.XX → Factura CAE #YYYY. Allocation done."
    │
    └─► IF: Currency = ARS
          ├─► Create Factura B/C via AFIP WS
          ├─► Record in "Income_Log"
          └─► Telegram: "💰 Ingreso ARS $X.XX → Factura generada."
```

### **6. EXPENSE_CAPTURE** (Telegram Bot / Email / Voice)
```
Trigger: Telegram Bot command /gasto OR Email to gastos@ OR Voice note
    │
    ├─► Parse: "5000 ARS supermercado" OR "25 USD suscripcion cursor"
    ├─► Function: Categorize (ML simple rules: keywords → category)
    ├─► Google Sheets: Append "Gastos_Log"
    ├─► Notion: Create "Transaction" in "Transactions" DB
    ├─► Actual Budget API: Create transaction (si configurado)
    ├─► Check: Category budget vs spent → IF >90% → Telegram warning
    └─► Reply: "✅ Registrado: $5.000 ARS → Alimentación. Presupuesto mes: 78%"
```

### **7. CRYPTO_WALLET_SCAN** (Cron: 0 0 * * * - Medianoche)
```
Trigger: Cron (Daily 00:00)
    │
    ├─► For Each Address (BTC, ETH, SOL, etc. en Config):
    │     ├─► HTTP Request: Blockstream/Etherscan/Solscan /address/{addr}
    │     ├─► Extract: Balance, Recent TXs
    │     ├─► Compare vs last scan → New TXs?
    │     ├─► IF New TX: Classify (Deposit/Withdrawal/Internal/Staking)
    │     ├─► Update "Crypto_Holdings" Sheet + Notion
    │     └─► IF Large movement (>$1k): Telegram Alert
    │
    ├─► DeFi Positions: 
    │     ├─► Zapper/Zerion API OR Covalent/Alchemy
    │     ├─► Fetch: LPs, Staking, Lending positions
    │     └─► Update valuations
    │
    └─► Log scan in "Crypto_Scan_Log"
```

### **8. TAX_LOSS_HARVESTING** (Cron: 0 9 15-31 12 * - Dic 15-31)
```
Trigger: Cron (Daily 9 AM Dec 15-31)
    │
    ├─► Google Sheets: Read "Fiscal_Events" YTD
    ├─► Identify: Positions with unrealized loss > $100 USD
    ├─► Filter: Not sold in last 30 days (wash sale rule US/AR)
    ├─► Calculate: Tax benefit = Loss × Marginal Rate
    ├─► IF Benefit > $50 USD:
    │     ├─► Telegram: "🎯 TAX LOSS HARVESTING: VT -$1,200 → Save ~$240 tax. Sell?"
    │     ├─► Inline keyboard: [Ejecutar VT] [Ejecutar SPY] [Ignorar]
    │     └─► Notion: Create "Tax Harvest Task"
    │
    └─► Log opportunities in "Tax_Harvest_Log"
```

---

## 🐙 GitHub Actions: Automatizaciones Gratuitas (Sin VPS)

### **`.github/workflows/finance-daily.yml`**
```yaml
name: Daily Finance Sync
on:
  schedule:
    - cron: '0 10 * * *'  # 10 AM UTC = 7 AM AR
  workflow_dispatch:

jobs:
  sync-prices:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      
      - name: Install deps
        run: pip install yfinance pandas gspread oauth2client requests
      
      - name: Fetch Prices
        env:
          GOOGLE_SHEETS_CREDENTIALS: ${{ secrets.GOOGLE_SHEETS_CREDENTIALS }}
          SHEET_ID: ${{ secrets.FINANCE_SHEET_ID }}
          TELEGRAM_BOT_TOKEN: ${{ secrets.TELEGRAM_BOT_TOKEN }}
          TELEGRAM_CHAT_ID: ${{ secrets.TELEGRAM_CHAT_ID }}
        run: |
          python scripts/fetch_prices.py
      
      - name: Check Rebalance
        env:
          GOOGLE_SHEETS_CREDENTIALS: ${{ secrets.GOOGLE_SHEETS_CREDENTIALS }}
          SHEET_ID: ${{ secrets.FINANCE_SHEET_ID }}
          TELEGRAM_BOT_TOKEN: ${{ secrets.TELEGRAM_BOT_TOKEN }}
          TELEGRAM_CHAT_ID: ${{ secrets.TELEGRAM_CHAT_ID }}
        run: |
          python scripts/check_rebalance.py

  monthly-import:
    if: github.event_name == 'schedule' && github.event.schedule == '0 10 1 * *'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Monthly Broker Import
        env:
          IMAP_USER: ${{ secrets.IMAP_USER }}
          IMAP_PASS: ${{ secrets.IMAP_PASS }}
          GOOGLE_SHEETS_CREDENTIALS: ${{ secrets.GOOGLE_SHEETS_CREDENTIALS }}
          SHEET_ID: ${{ secrets.FINANCE_SHEET_ID }}
        run: |
          python scripts/monthly_import.py
```

### **`scripts/fetch_prices.py`**
```python
#!/usr/bin/env python3
import yfinance as yf
import gspread
from oauth2client.service_account import ServiceAccountCredentials
import json
import os
import requests
from datetime import datetime

# Config
SCOPE = ['https://spreadsheets.google.com/feeds', 'https://www.googleapis.com/auth/drive']
CREDS = json.loads(os.environ['GOOGLE_SHEETS_CREDENTIALS'])
SHEET_ID = os.environ['SHEET_ID']
TG_TOKEN = os.environ['TELEGRAM_BOT_TOKEN']
TG_CHAT = os.environ['TELEGRAM_CHAT_ID']

# Tickers a trackear
TICKERS = {
    'US': ['VT', 'SPY', 'QQQ', 'VWO', 'BND', 'GLD', 'TLT', 'AAPL', 'MSFT', 'NVDA'],
    'CEDEAR': ['SPY', 'QQQ', 'VT', 'AAPL', 'MSFT', 'NVDA', 'TSLA', 'META', 'GOOGL', 'AMZN'],
    'CRYPTO': ['BTC-USD', 'ETH-USD', 'SOL-USD', 'ADA-USD'],
    'ARS': ['AL30.BA', 'GD30.BA', 'AE38.BA']  # yfinance suffix .BA para BYMA
}

def get_google_sheet():
    creds = ServiceAccountCredentials.from_json_keyfile_dict(CREDS, SCOPE)
    client = gspread.authorize(creds)
    return client.open_by_key(SHEET_ID)

def send_telegram(msg):
    requests.post(f'https://api.telegram.org/bot{TG_TOKEN}/sendMessage',
                  json={'chat_id': TG_CHAT, 'text': msg, 'parse_mode': 'HTML'})

def main():
    sheet = get_google_sheet()
    price_tab = sheet.worksheet('Prices_Live')
    
    # Fetch all
    all_tickers = sum(TICKERS.values(), [])
    data = yf.download(all_tickers, period='1d', interval='1m', progress=False)['Close'].iloc[-1]
    
    # BCRA Dollar
    bcra = requests.get('https://api.bcra.gob.ar/estadisticas/v1.0/cotizaciones/USD').json()
    usd_ars = bcra[-1]['v'] if bcra else 1000
    
    # Update sheet
    updates = []
    alerts = []
    for i, row in enumerate(price_tab.get_all_values()[1:], start=2):
        symbol = row[0]
        if symbol in data.index:
            price = float(data[symbol])
            old_price = float(row[2]) if row[2] else 0
            change = ((price - old_price) / old_price * 100) if old_price else 0
            
            updates.append({'range': f'C{i}:F{i}', 'values': [[
                price,  # Price USD
                price * usd_ars if 'ARS' not in symbol else price,  # Price ARS
                datetime.now().isoformat(),  # Timestamp
                f'{change:+.2f}%'  # Change
            ]]})
            
            if abs(change) > 5:
                alerts.append(f"{symbol}: {change:+.2f}% (${price:,.2f})")
    
    if updates:
        price_tab.batch_update(updates)
    
    if alerts:
        send_telegram(f"📈 <b>Price Alerts</b>\n" + "\n".join(alerts))

if __name__ == '__main__':
    main()
```

---

## 📱 Telegram Bot: Comandos Útiles

### **`bot_commands.py` (python-telegram-bot)**
```python
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, CallbackQueryHandler, MessageHandler, filters
import gspread
import os

# Comandos:
# /portfolio → Resumen actual
# /rebalance → Ver desviaciones
# /buy VT 100 → Orden compra (simulada/confirmada)
# /gasto 5000 supermercado → Registrar gasto
# /ingreso 500 usd takenos → Registrar ingreso
# /alerts → Configurar alertas
# /fiscal → Resumen fiscal YTD
# /help → Lista comandos
```

---

## 🔗 Integraciones Clave: APIs y Webhooks

| Servicio | API/Webhook | Uso | Auth |
|----------|-------------|-----|------|
| **IBKR** | Flex Web Service / REST | Positions, Trades, Statements | Token + Consumer Key |
| **Trading 212** | No oficial (scraping) | Positions, Pies, Dividends | Session cookie |
| **Binance** | REST + WebSocket | Trades, Balances, Prices, P2P | API Key + Secret |
| **Bybit** | REST | Derivatives, Spot, Earn | API Key + Secret |
| **Kraken** | REST | Trades, Staking, Balances | API Key + Secret |
| **CoinGecko** | REST (Free) | Prices, Market Data | Demo Key (gratis) |
| **BYMA** | REST (Oficial) | CEDEARs Prices, Volumes | Registro |
| **BCRA** | REST (Free) | USD Official, MEP, CCL, Reservas | Sin auth |
| **AFIP/ARCA** | WS (SOAP) | Facturación, Consultas | Certificado Digital |
| **Takenos** | Webhook + API | Cobros, Facturación, FX | API Key |
| **Wise** | Webhook + API | Transfers, Balances, FX | API Token |
| **Mercado Pago** | Webhook + API | Pagos, QR, Split | Access Token |
| **Google Sheets** | Sheets API v4 | Read/Write/Append | OAuth2 / Service Account |
| **Notion** | REST API | Databases CRUD | Integration Token |

---

## 📁 Estructura Repositorio Automatizaciones

```
/finance-automation/
├── docker-compose.yml          # n8n + Postgres + Redis
├── .env.example                # Variables de entorno template
├── .github/
│   └── workflows/
│       ├── finance-daily.yml
│       ├── finance-monthly.yml
│       └── finance-yearly.yml
├── n8n-workflows/
│   ├── daily_price_sync.json
│   ├── monthly_broker_import.json
│   ├── rebalance_check.json
│   ├── fiscal_snapshot.json
│   ├── invoice_automation.json
│   ├── expense_capture.json
│   ├── crypto_wallet_scan.json
│   └── tax_loss_harvesting.json
├── scripts/
│   ├── fetch_prices.py
│   ├── check_rebalance.py
│   ├── monthly_import.py
│   ├── fiscal_snapshot.py
│   ├── tax_harvest.py
│   └── bot_commands.py
├── config/
│   ├── tickers.yaml
│   ├── categories.yaml
│   ├── targets.yaml
│   └── alerts.yaml
├── tests/
│   └── test_*.py
├── docs/
│   ├── SETUP.md
│   ├── WORKFLOWS.md
│   └── TROUBLESHOOTING.md
└── README.md
```

---

## 🎯 Quick Start: Primeras 3 Automatizaciones (Este Fin de Semana)

### **Opción A: n8n (Recomendado - Visual + Potente)**
```
1. Levantar VPS (DigitalOcean/Hetzner/Contabo $5/mes) + Docker
2. docker-compose up -d
3. Configurar Nginx + SSL + Basic Auth
4. Importar 3 workflows JSON: Daily Price Sync, Rebalance Check, Expense Capture
5. Configurar credenciales: Google Sheets, Telegram, CoinGecko
6. Activar workflows → Test manual → Ver logs
7. ¡Listo! Tienes precios diarios + alertas rebalanceo + captura gastos por Telegram
```

### **Opción B: GitHub Actions (Gratis - Sin VPS)**
```
1. Crear repo privado: finance-automation
2. Add Secrets: GOOGLE_SHEETS_CREDENTIALS, SHEET_ID, TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID
3. Copiar .github/workflows/finance-daily.yml
4. Copiar scripts/fetch_prices.py
5. Push → Actions se ejecuta solo → Ver logs
6. ¡Listo! Precios diarios + alertas gratis para siempre
```

### **Opción C: Google Apps Script (Más Simple - Solo Sheets)**
```
1. Abrir Google Sheets maestro
2. Extensiones → Apps Script
3. Pegar código fetchPrices() + checkRebalance() + monthlySnapshot()
4. Triggers: Reloj → Cada hora / Diario / Mensual
4. ¡Listo! Zero infra, corre en Google
```

---

## 📊 Métricas de Automatización (KPIs)

| Métrica | Target | Alerta |
|---------|--------|--------|
| **Uptime n8n/GHA** | >99.5% | <99% |
| **Price Sync Latency** | <5 min post-market | >15 min |
| **Import Success Rate** | 100% brokers | <100% |
| **Alert False Positive** | <5% | >15% |
| **Manual Interventions/Mes** | 0-1 | >3 |
| **Time to Detect Issue** | <1 hora | >4 horas |
| **Backup Verification** | Semanal | Mensual |

---

## 🔐 Seguridad Automatizaciones

```
[ ] n8n: HTTPS + Basic Auth + VPN/Tailscale acceso (NO expuesto público)
[ ] GitHub Secrets: Todos los tokens (NUNCA en código)
[ ] Google Sheets: Service Account con scopes mínimos (solo spreadsheet)
[ ] Notion: Integration Token con acceso solo DBs finanzas
[ ] Telegram Bot: Solo tu Chat ID (Privacy Mode ON)
[ ] API Keys: Read-only donde posible (Binance: Enable Reading, Disable Trading)
[ ] AFIP Cert: En HSM / archivo encriptado / 1Password
[ ] Backups: n8n DB (Postgres) → Daily dump → S3/Drive encriptado
[ ] Rotación: API Keys cada 90 días / Cert AFIP anual
[ ] Audit Log: n8n execution log + GitHub Actions log → revisar mensual
```

---

## 📝 Checklist Implementación Completa

```
[ ] Decidir: n8n (VPS) vs GitHub Actions (Free) vs Apps Script (Simple)
[ ] Setup infra elegida + credenciales
[ ] Implementar: Daily Price Sync (Prioridad #1)
[ ] Implementar: Rebalance Check (Prioridad #2)
[ ] Implementar: Expense Capture via Telegram (Prioridad #3)
[ ] Implementar: Monthly Broker Import
[ ] Implementar: Fiscal Snapshot (Anual)
[ ] Implementar: Invoice Automation (Takenos/Wise)
[ ] Implementar: Crypto Wallet Scan
[ ] Implementar: Tax Loss Harvesting (Dic)
[ ] Documentar todo en Notion: "Automatizaciones - Runbook"
[ ] Compartir acceso con contador / pareja (solo lectura + alertas)
[ ] Test disaster recovery: "¿Recupero todo en <1h si se muere VPS?"
```

---

*Última actualización: 2026-08-28 | La mejor automatización es la que **no tenés que tocar en 6 meses**. Empezá simple, iterá, medí.*