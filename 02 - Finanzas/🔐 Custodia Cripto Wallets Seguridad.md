---
title: "Custodia Cripto: Wallets + Seguridad - Hot vs Cold, Seed Phrase, Multisig, Herencia, Ledger/Trezor Setup"
tags: ["finanzas", "cripto", "custodia", "wallets", "seguridad", "ledger", "trezor", "seed-phrase", "multisig", "herencia"]
created: "2026-08-28"
updated: "2026-08-28"
status: "active"
priority: "high"
related: ["Matriz Comparativa Apps Finanzas Completas", "Guía Fiscal Inversiones Argentina 2026", "Portfolio Tracker Setup", "Automatizaciones Financieras"]
---

# 🔐 Custodia Cripto: Guía Completa de Seguridad (2026)

> **Not your keys, not your coins**. De exchange a autocustodia real. Setup profesional, herencia, recuperación.

---

## 🏗️ Arquitectura de Custodia: 3 Niveles

```
┌─────────────────────────────────────────────────────────────────┐
│  NIVEL 1: EXCHANGE (Custodia Completa)                          │
│  Binance, Bybit, Kraken, Coinbase, Bitso, Lemon, Buenbit       │
│  ✅ Fácil, trading instant, P2P, earn, tarjeta                 │
│  ❌ Riesgo contraparte, hack, freeze, regulatorio              │
│  💰 Uso: Trading activo, P2P ARS, on/off ramp, <5% portfolio   │
└─────────────────────────────────────────────────────────────────┘
                              ↓ Retiro (Withdraw)
┌─────────────────────────────────────────────────────────────────┐
│  NIVEL 2: HOT WALLET (Autocustodia Conectada)                  │
│  MetaMask, Trust Wallet, Exodus, Phantom, Rabby, Rainbow       │
│  ✅ Vos tenés keys, DeFi, NFTs, DApps, gratis                  │
│  ❌ Online = superficie ataque (malware, phishing, supply chain)│
│  💰 Uso: DeFi diario, NFTs, montos medios (5-30% portfolio)    │
└─────────────────────────────────────────────────────────────────┘
                              ↓ Transferencia
┌─────────────────────────────────────────────────────────────────┐
│  NIVEL 3: COLD STORAGE (Autocustodia Aislada)                  │
│  Ledger, Trezor, Coldcard, Keystone, BitBox, SeedSigner        │
│  ✅ Keys nunca tocan internet, máximo seguridad                │
│  ❌ Costo hardware, UX más lenta, responsabilidad total        │
│  💰 Uso: **HODL largo plazo, >70% portfolio, savings**         │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🥶 Cold Wallets: Comparativa Hardware (2026)

| Wallet | Precio | Chip Secure Element | Pantalla | Bluetooth | USB-C | Open Source | Multisig Nativo | Shamir Backup | Ideal Para |
|--------|--------|---------------------|----------|-----------|-------|-------------|-----------------|---------------|------------|
| **Ledger Nano S Plus** | $79 | ST33J2M0 (CC EAL5+) | 128x64px | ❌ | ✅ | ❌ (BOLOS) | ❌ (via Ledger Live) | ❌ | Entrada, multi-coin |
| **Ledger Nano X** | $149 | ST33J2M0 + Bluetooth | 128x64px | ✅ | ❌ (MicroUSB) | ❌ | ❌ | ❌ | Móvil + Bluetooth |
| **Ledger Stax** | $279 | ST33K2M0 + E Ink | 3.7" E Ink | ✅ | ✅ | ❌ | ❌ | ❌ | Premium, UX touch |
| **Trezor Safe 3** | $59 | ST33 (CC EAL6+) | 128x64px | ❌ | ✅ | ✅ (Core) | ✅ (via Trezor Suite) | ✅ **SLIP-39** | **Mejor valor, open source** |
| **Trezor Safe 5** | $169 | ST33 + Touch | 2.8" Color Touch | ❌ | ✅ | ✅ | ✅ | ✅ SLIP-39 | Premium open source |
| **Trezor Model One** | $49 | STM32 (no SE) | 128x64px | ❌ | ❌ (MicroUSB) | ✅ | ❌ | ❌ | Legacy, presupuesto |
| **Coldcard Mk4** | $157 | ATECC608B (EAL5+) | 128x64px | ❌ | ✅ | ✅ | ✅ **Native PSBT** | ✅ SLIP-39 | **Bitcoin only, max security** |
| **Keystone 3 Pro** | $189 | Dual SE (EAL6+) | 4" Touch | ❌ | ✅ | ✅ | ✅ | ✅ SLIP-39 | Air-gapped QR, multi-coin |
| **BitBox02** | $149 | ATECC608B (EAL5+) | 128x64px | ❌ | ✅ | ✅ | ✅ | ❌ | Swiss, minimalista |
| **SeedSigner** | ~$50 DIY | RP2040 (no SE) | 2.4" Touch | ❌ | ✅ | ✅ **100%** | ✅ | ✅ SLIP-39 | **DIY, stateless, Bitcoin** |

> 🏆 **Mi recomendación 2026**: **Trezor Safe 3 ($59)** para 90% usuarios. Open source, SLIP-39 (Shamir backup), Secure Element, USB-C, precio imbatible. Si solo Bitcoin → **Coldcard Mk4**. Si premium UX → **Ledger Stax** o **Trezor Safe 5**.

---

## 🔥 Hot Wallets: Comparativa (2026)

| Wallet | Plataformas | Chains Soportadas | Hardware Wallet | Open Source | Seguridad Extra | Ideal Para |
|--------|-------------|-------------------|-----------------|-------------|-----------------|------------|
| **MetaMask** | Browser Ext, iOS, Android | EVM (Eth, Arbitrum, Optimism, Base, Polygon, BSC, etc.) | ✅ Ledger/Trezor/Keystone | ❌ (core cerrado) | Snaps, phishing detection | **DeFi Ethereum/EVM #1** |
| **Rabby** | Browser Ext | EVM (50+ chains) | ✅ Ledger/Trezor | ✅ | Simulation tx, better UX | **Power user DeFi** |
| **Trust Wallet** | iOS, Android, Browser | 100+ chains (BTC, ETH, SOL, Cosmos, etc.) | ✅ Ledger | ❌ | Binance DEX, staking nativo | **Multi-chain móvil** |
| **Exodus** | Desktop, iOS, Android | 100+ assets | ✅ Trezor | ❌ | Swap integrado, portfolio UI | **Principiante multi-asset** |
| **Phantom** | Browser Ext, iOS, Android | Solana, Ethereum, Polygon, Bitcoin | ✅ Ledger | ❌ | Solana UX #1, NFTs, burning | **Solana ecosystem** |
| **Rainbow** | iOS, Android, Browser | Ethereum, L2s (Arbitrum, Optimism, Base) | ✅ Ledger | ❌ | Social features, beautiful UI | **Eth L2 móvil pretty** |
| **BlueWallet** | iOS, Android | **Bitcoin + Lightning** | ❌ | ✅ | Lightning nativo, watch-only | **Bitcoin/Lightning móvil** |
| **Electrum** | Desktop, Android | **Bitcoin only** | ✅ Ledger/Trezor/Coldcard | ✅ | Lightning, multisig, HWI | **Bitcoin power user** |
| **Sparrow** | Desktop | **Bitcoin only** | ✅ Todos (HWI) | ✅ | Coin control, PayJoin, Tor | **Bitcoin desktop pro** |

---

## 🌱 Seed Phrase: El Santo Grial

### **Estándares**
| Estándar | Palabras | Entropía | Uso |
|----------|----------|----------|-----|
| **BIP-39** | 12 / 18 / 24 | 128 / 192 / 256 bits | **Estándar universal** (Ledger, Trezor, MetaMask, etc.) |
| **SLIP-39 (Shamir)** | 20-33 palabras por share | 128-256 bits | **Backup dividido** (Trezor Safe 3/5, Coldcard, Keystone) |
| **Electrum** | 12 palabras | 128 bits | Solo Electrum (no compatible BIP-39) |

### **Generación Segura (Orden de Seguridad)**
```
MÁXIMO SEGURIDAD
│
├── 1. Hardware Wallet (Trezor/Ledger/Coldcard) → Genera offline, muestra en pantalla dispositivo
│
├── 2. SeedSigner (DIY, stateless, QR only) → Genera offline, nunca en PC/teléfono
│
├── 3. Diceware (dados físicos + lista BIP-39) → 100% analógico, verificable
│
├── 4. Live USB (Tails OS / Ubuntu Live) + Ian Coleman BIP-39 tool (offline)
│
└── 5. MetaMask/Trust Wallet (genera en app) → SOLO para montos PEQUEÑOS (<$1k)
    │
    └── ⚠️ NUNCA: Generar en web, screenshot, notas nube, email, password manager
```

### **Backup Físico: Jerarquía de Durabilidad**
| Método | Costo | Durabilidad | Riesgo | Veredicto |
|--------|-------|-------------|--------|-----------|
| **Papel (escrito a mano)** | $0 | Baja (fuego, agua, tinta) | Alto | ❌ Solo temporal |
| **Metal (stamped/etched): Billfodl, Cryptosteel, Cobo, Keystone Tablet** | $50-150 | **Alta (fuego 1200°C+, agua, corrosión)** | Bajo | ✅ **Estándar** |
| **Metal DIY (plaqueta acero + punzón letras)** | $20 | Alta | Medio (error humano) | ✅ Si sabés |
| **Shamir (SLIP-39) 2-of-3 en 3 ubicaciones** | 3× metal | **Máxima** | **Mínimo** | ✅ **Ideal patrimonios >$50k** |

### **Distribución Geográfica (Shamir 2-of-3)**
```
Share 1 (20 palabras) → 🏠 Casa principal (caja fuerte oculta)
Share 2 (20 palabras) → 🏦 Caja seguridad banco / Casa familiar confianza
Share 3 (20 palabras) → 🏠 Segunda residencia / Abogado / Notario (sellado)

→ Cualquier 2 recuperan seed completo
→ 1 solo share = INÚTIL (info-teórica seguro)
→ Testear recuperación ANTES de mover fondos grandes
```

---

## 🔐 Multisig: Cuando Una Llave No Alcanza

### **Esquemas Comunes**
| Esquema | Firmas Requeridas | Uso Típico | Complejidad |
|---------|-------------------|------------|-------------|
| **2-of-2** | 2 de 2 | Pareja / Socio negocio | Media |
| **2-of-3** | 2 de 3 | **Estándar personal** (Vos + HW1 + HW2 / Abogado) | Media |
| **3-of-5** | 3 de 5 | Organizaciones / DAOs / Familia extensa | Alta |
| **1-of-1 + Timelock** | 1 + tiempo | Herencia / Dead man's switch | Media |

### **Implementación Práctica (2-of-3 Personal)**
```
Clave 1: Trezor Safe 3 (en tu poder, uso diario)
Clave 2: Ledger Nano S Plus (en caja fuerte, backup)
Clave 3: Clave "social" → Abogado / Familiar confianza / Caja seguridad banco
           (Solo firman en emergencia: muerte/incapacidad)

Wallets Multisig Recomendados:
├── Bitcoin: Specter Desktop + HWI (Coldcard/Trezor/Ledger) → Native PSBT
├── Ethereum/EVM: Safe (gnosis-safe.io) + MetaMask/Rabby + HW
├── Multi-chain: Electrum (BTC) + Safe (EVM) + Sparrow (BTC advanced)
```

### **Flujo Transacción Multisig (2-of-3)**
```
1. Iniciás tx en wallet (Specter/Safe) → Propuesta PSBT/JSON
2. Firmás con Clave 1 (Trezor) → Parcialmente firmada
3. Envías archivo/QR a Clave 2 (Ledger en caja) → Firmás → Completada
4. Broadcast → Red
5. Si Clave 1 perdida/robo → Clave 2 + Clave 3 recuperan fondos
```

---

## 👨‍👩‍👧‍👦 Herencia Cripto: Plan de Sucesión

### **Problema**: Seed phrase en testamento = **pública** (juzgado, notario, herederos la ven).

### **Solución: Dead Man's Switch + Instrucciones Selladas**

#### **Opción A: Carta de Instrucciones (Low Tech, Legal)**
```
1. Escribí carta física: "Instrucciones Acceso Activos Digitales"
2. Incluí: 
   - Lista wallets/exchanges (NO keys/seeds)
   - Contacto abogado/fiduciario técnico
   - Ubicación backups físicos (metal plates)
   - "Contactar a [Persona Técnica Confianza] para recuperación"
3. Sellá en sobre antifalsificación → Notario / Caja seguridad
4. Testamento refiere: "Ver sobre sellado en Caja Seguridad N° X"
```

#### **Opción B: Shamir + Fiduciario Técnico (Recomendado)**
```
Setup 2-of-3 Shamir:
├── Share 1: Vos (metal plate en casa)
├── Share 2: Fiduciario Técnico (abogado especialista / empresa custody) 
└── Share 3: Caja seguridad banco / Notario (sellado)

Instrucciones al fiduciario:
"Si no respondés a challenge mensual (email/telegram) por 90 días:
1. Contactar familia (lista contactos en archivo)
2. Usar Share 2 + Share 3 para recuperar seed
3. Mover fondos a wallet heredero (dirección pre-registrada)
4. Entregar acceso a herederos con instrucciones paso a paso"
```

#### **Opción C: Servicios Especializados (2026)**
| Servicio | Modelo | Costo | Jurisdicción |
|----------|--------|-------|--------------|
| **Casa Custody** | Multisig 2-of-3 + herencia | $250-500/año | US |
| **Unchained Capital** | Multisig + concierge | $250-1000/año | US |
| **BitGo** | Institutional custody + herencia | Custom | US/Global |
| **Fiduciario Local (AR)** | Abogado especialista + notario | Honorarios | Argentina |

---

## 🛠️ Setup Completo: De Cero a Cold Storage Profesional

### **Fase 1: Compra y Verificación (Día 1)**
```
[ ] Comprar DIRECTO del fabricante (ledger.com, trezor.io, coldcard.com, keyst.one)
    → NUNCA Amazon, MercadoLibre, revendedores (supply chain attack)
[ ] Verificar integridad paquete: sellos intactos, hologramas, numbering
[ ] Inicializar dispositivo: 
    → Generar seed NUEVA (no restaurar)
    → Anotar en papel temporal (verificar 2x)
    → Verificar address receive en dispositivo vs app
[ ] Testear recuperación: Reset device → Restore from seed → Verificar address match
```

### **Fase 2: Backup Metálico (Día 1-2)**
```
[ ] Comprar kit metal (Billfodl, Cryptosteel, Cobo Tablet, Keystone Tablet)
[ ] Grabar seed BIP-39 (12/24 palabras) O shares SLIP-39 (20-33 c/u)
[ ] Verificar legibilidad: leer en voz alta, foto macro, testeo familia
[ ] Distribuir geográficamente (ver esquema Shamir arriba)
```

### **Fase 3: Migración Fondos (Día 2-7)**
```
[ ] Crear wallet receive en cold (address native: bc1q... / 0x... / SOL...)
[ ] Test deposit: $10-50 USD desde exchange → cold address
[ ] Verificar en block explorer + wallet app (Ledger Live / Trezor Suite / Sparrow)
[ ] Transfer principal: Lotes de $5k-10k c/u (evitar single tx grande)
[ ] Verificar cada lote en block explorer
[ ] Borrar wallets hot / exchange de montos grandes
```

### **Fase 4: Operativa Diaria (Continuo)**
```
[ ] Hot wallet (MetaMask/Rabby/Trust) → Solo montos operativos (DeFi, trading, gastos)
[ ] Cold wallet → Recibe ahorros, staking rewards (via watch-only), HODL
[ ] Rebalance mensual: Exceso hot → Cold / Déficit hot ← Cold (planificado)
[ ] Firmware updates: Solo desde web oficial, verificar hash, nunca Bluetooth si evitable
```

---

## 📋 Checklist Auditoría Seguridad (Trimestral)

```
[ ] Verificar firmware latest en todos HW wallets
[ ] Testear recuperación seed en dispositivo NUEVO/RESET (sin fondos)
[ ] Verificar backups metálicos: legibilidad, ubicación, sellos
[ ] Revisar approved contracts/spend allowances en hot wallets (revoke.cash)
[ ] Rotar passphrases BIP-39 (25th word) si las usás
[ ] Verificar contactos herencia: fiduciario vivo, datos actualizados
[ ] Auditar exchange balances: retirar exceso a cold
[ ] Revisar 2FA en exchanges: YubiKey > TOTP > SMS
[ ] Verificar email recovery: único, 2FA, sin forwarding
[ ] Simular escenario: "Pierdo todo acceso hoy" → ¿Recupero en <24h?
```

---

## 🚨 Errores Fatales (Evitar a Toda Costa)

| Error | Consecuencia | Prevención |
|-------|--------------|------------|
| **Seed en captura de pantalla / notas / nube / email** | Robo remoto 100% | Solo metal + papel temporal (luego destruir) |
| **Comprar Ledger/Trezor en ML/Amazon/usado** | Seed pre-generada = robo | Solo web oficial, sellos intactos |
| **Usar seed generada en MetaMask para cold wallet** | Seed ya expuesta online | Cold wallet genera SU PROPIA seed offline |
| **No testear recuperación ANTES de mover fondos** | Seed mal escrita = pérdida total | Reset + restore obligatorio antes de depósito |
| **Single point of failure (una sola copia seed)** | Incendio/robo/perdida = todo perdido | Shamir 2-of-3 mínimo |
| **Compartir seed con "asesor" / familiar / novio/a** | Traición / error / hack = pérdida | Nadie ve seed completa. Multisig para compartido |
| **No tener plan herencia** → Fondos perdidos para siempre | Familia no accede | Dead man's switch + instrucciones selladas |
| **Firmar tx ciega (blind signing) en Ledger** | Drenar wallet completa | Solo clear signing / simular en Rabby/Tenderly |
| **Guardar seed + passphrase (25th word) juntos** | Anula seguridad passphrase | Separar físicamente: seed en metal, passphrase en papel/mente |

---

## 💰 Costos Totales Setup Profesional (2026)

| Componente | Opción Budget | Opción Pro | Opción Max Security |
|------------|---------------|------------|---------------------|
| **Hardware Wallet 1** | Trezor Safe 3 ($59) | Ledger Nano X ($149) | Coldcard Mk4 ($157) |
| **Hardware Wallet 2 (Backup)** | Trezor Safe 3 ($59) | Ledger Nano S Plus ($79) | Keystone 3 Pro ($189) |
| **Metal Backup (2-3 placas)** | DIY acero + punzón ($20) | Billfodl 2-pack ($120) | Cryptosteel Capsule 3-pack ($300) |
| **Metal Shamir (3 shares)** | 3x DIY ($60) | 3x Billfodl ($180) | 3x Keystone Tablet ($300) |
| **Caja fuerte domicilio** | $50-100 | $200-500 | $1000+ (certificada) |
| **Caja seguridad banco** | $500-1500/año | $500-1500/año | $500-1500/año |
| **Abogado/Notario (herencia)** | $200-500 once | $500-1500 once | $2000+ once |
| **TOTAL INICIAL** | **~$300-500** | **~$1,000-1,500** | **~$3,000-5,000** |
| **TOTAL ANUAL** | **~$500-1,500** | **~$500-1,500** | **~$500-1,500** |

> 💡 **Regla**: Gastá **1-2% del portfolio en seguridad**. Si tenés $50k crypto → $500-1,000 en setup. Si $500k → $5k-10k.

---

## 🔗 Recursos y Verificación

| Recurso | URL | Qué Verificar |
|---------|-----|---------------|
| **Ledger Verify** | https://verify.ledger.com/ | Autenticidad dispositivo |
| **Trezor Authenticity** | https://trezor.io/verify/ | Autenticidad + firmware hash |
| **Coldcard Verify** | https://coldcard.com/verify/ | PGP signature firmware |
| **Ian Coleman BIP-39** | https://iancoleman.io/bip39/ (OFFLINE ONLY) | Verificar derivación addresses |
| **SLIP-39 Demo** | https://iancoleman.io/slip39/ (OFFLINE) | Verificar shares Shamir |
| **Revoke.cash** | https://revoke.cash/ | Revocar allowances DeFi |
| **Bitcoin Core Verify** | https://bitcoincore.org/en/download/ | Verificar binarios PGP |
| **GL.iNet Travel Router** | https://www.glint.com/ | Aislamiento red para HW wallet |

---

*Última actualización: 2026-08-28 | **La seguridad es un proceso, no un producto**. Revisá trimestralmente. Testear recuperación = obligatorio antes de mover fondos reales.*