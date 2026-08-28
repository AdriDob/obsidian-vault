---
title: "Plantillas Estrategia Inversión: Perfiles, Rebalanceo, DCA, Lump Sum, Horizonte, Riesgo"
tags: ["finanzas", "inversion", "estrategia", "perfiles", "rebalanceo", "dca", "lump-sum", "asset-allocation", "risk-management"]
created: "2026-08-28"
updated: "2026-08-28"
status: "active"
priority: "high"
related: ["Portfolio Tracker Setup", "CEDEARs Guía Completa", "Brokers Internacionales para Argentinos", "Guía Fiscal Inversiones Argentina 2026"]
---

# 📈 Plantillas Estrategia Inversión (2026)

> **Estrategia = Reglas escritas ANTES de emociones**. Plantillas listas para copiar, personalizar y ejecutar sin dudar.

---

## 🎯 Paso 0: Definir Tu Perfil (Obligatorio Antes de Invertir)

### **Cuestionario Perfil de Riesgo (Versión Corta)**
```
Responde HONESTAMENTE (1-5): 1=Nunca / 5=Siempre

1. ¿Cuánto caerí­a tu portfolio antes de vender en pánico? (1=5% / 5=50%+)
2. ¿Cuántos años podés dejar el dinero SIN tocarlo? (1=<1 / 5=10+)
3. ¿Qué % de tu patrimonio neto es este dinero? (1=>50% / 5=<5%)
4. ¿Tenés fondo emergencia 6+ meses separado? (1=No / 5=Sí, 12+ meses)
5. ¿Dormirí­as tranquilo viendo -30% en pantalla? (1=No / 5=Sí, compraría más)
6. ¿Entendés la diferencia entre volatilidad y pérdida permanente? (1=No / 5=Sí, explico)
7. ¿Tu ingreso cubre gastos + 30% ahorro sin tocar inversiones? (1=No / 5=Sí, holgado)

TOTAL: ___ / 35
```

### **Mapeo Score → Perfil**
| Score | Perfil | Asignación Base (Acciones / Bonos / Efectivo) | Volatilidad Esperada Anual | Drawdown Máx Histórico |
|-------|--------|-----------------------------------------------|---------------------------|------------------------|
| **7-12** | **Conservador** | 20 / 60 / 20 | ±5-8% | -10% |
| **13-18** | **Moderado Conservador** | 40 / 50 / 10 | ±8-12% | -15% |
| **19-24** | **Moderado (Balanced)** | **60 / 35 / 5** | **±12-18%** | **-25%** |
| **25-29** | **Moderado Agresivo** | 75 / 20 / 5 | ±18-25% | -35% |
| **30-35** | **Agresivo / Crecimiento** | 90 / 5 / 5 | ±25-35% | -50% |

> 📌 **Mi recomendación default para argentino con ingresos USD variables**: **Moderado (60/35/5)** con **tilt AR (CEDEARs/Bonos) 30% / Global 70%**.

---

## 📋 Plantilla 1: IPS (Investment Policy Statement) Personal

> **Copialo a Notion/Google Docs, completalo, firmalo (vos mismo), revisalo cada 6 meses**.

```markdown
# 📜 INVESTMENT POLICY STATEMENT - [TU NOMBRE] - 2026

## 1. OBJETIVOS
- **Primario**: Independencia financiera (FIRE) para [AÑO OBJETIVO] / Edad [EDAD]
- **Secundario**: Preservar poder adquisitivo vs inflación ARS + USD
- **Terciario**: Generar ingresos pasivos crecientes (dividendos + yield)

## 2. HORIZONTE TEMPORAL
- **Corto plazo (<3 años)**: $________ → Efectivo / FCI Money Market / Stablecoins
- **Mediano plazo (3-10 años)**: $________ → Bonos AR + Global + CEDEARs value
- **Largo plazo (>10 años)**: $________ → Acciones Global (ETFs) + CEDEARs growth + BTC/ETH

## 3. TOLERANCIA AL RIESGO (Auto-evaluación)
- Perfil: [Conservador / Moderado / Agresivo] - Score: ___/35
- Drawdown máximo tolerable SIN vender: ____%
- Volatilidad anual aceptable: ____%

## 4. ASIGNACIÓN ESTRATÉGICA (Strategic Asset Allocation - SAA)

| Clase Activo | Target % | Rango Permitido | Vehículo Principal | Benchmark |
|--------------|----------|-----------------|-------------------|-----------|
| **Acciones Global (ETFs)** | ____% | ____% - ____% | IBKR: VT / SPY / QQQ / VWO | MSCI ACWI |
| **Acciones Argentina (CEDEARs)** | ____% | ____% - ____% | IOL/Cocos: SPY, QQQ, VT, AAPL, MSFT | MERVAL USD |
| **Bonos Soberanos AR (Dólar linked)** | ____% | ____% - ____% | IOL: AL30, GD30, AE38 | EMBI Argentina |
| **Bonos Corporativos / FCI Renta Fija** | ____% | ____% - ____% | IOL/Cocos: FCI Renta Fija USD | Bloomberg Agg |
| **Criptomonedas (BTC/ETH)** | ____% | ____% - ____% | Binance → Cold Storage | BTC/ETH |
| **Stablecoins / Efectivo USD** | ____% | ____% - ____% | Wise / Takenos / IBKR Cash / Belo | USD Cash |
| **Efectivo ARS (Gastos + Buffer)** | ____% | ____% - ____% | MP / Ualá / Banco | ARS Cash |
| **Alternativos (REITs, Commodities, Private)** | ____% | ____% - ____% | Opcional | N/A |
| **TOTAL** | **100%** | | | |

## 5. REGLAS DE REBALANCEO
- **Frecuencia**: Trimestral (Mar/Jun/Sep/Dic) + Bandas de tolerancia
- **Bandas**: ±5% absoluto por clase / ±10% relativo (ej: 60% → banda 55-65%)
- **Método**: Vender sobreponderado → Comprar subponderado (tax-aware)
- **Mínimo trade**: $500 USD equivalente (evitar over-trading)
- **Nunca rebalancear**: En días de pánico extremo (VIX > 40) / noticias macro mayores

## 6. APORTES NUEVOS (New Money)
- **Regla**: Dirigir 100% nuevo capital a clase MÁS SUBPONDERADA
- **DCA**: Semanal (ETFs IBKR) / Quincenal (CEDEARs IOL) / Mensual (Cripto)
- **Lump Sum**: Si >$5k USD → 50% inmediato + 50% en 4 semanas (DCA)

## 7. RESTRICCIONES (Negative Screening)
- ❌ No opciones/futuros/apalancamiento (salvo hedging explícito aprobado)
- ❌ No acciones individuales < $10B market cap (salvo CEDEARs top 20)
- ❌ No cripto altcoins top 50 (solo BTC/ETH + stablecoins)
- ❌ No productos estructurados / notas / certificados complejos
- ❌ No leverage / margin trading

## 8. CONSIDERACIONES FISCALES (Argentina)
- Priorizar CEDEARs vs Acciones directas (Exención BP $100M)
- Harvesting pérdidas fiscales Diciembre (vender perdedores, recomprar 30 días después)
- Mantener W-8BEN vigente (IBKR) → Dividendos US 15% vs 30%
- Stablecoins en Belo/DolarApp para gasto (0% fee conversión) vs vender ETFs

## 9. PLAN DE CONTINGENCIA (Crisis)
- **Escenario -30% portfolio**: NO VENDER. Rebalancear comprando. Revisar IPS.
- **Escenario -50% portfolio**: Activar "Modo Supervivencia": Solo aportes a subponderados, sin rebalancear ventas.
- **Pérdida empleo/ingresos**: 6 meses gastos en efectivo/FCI → No tocar portfolio largo plazo.
- **Emergencia médica/ familiar**: Fondo emergencia + Seguros → Portfolio intocable.

## 10. REVISIÓN Y GOBERNANZA
- **Revisión IPS**: Cada 6 meses (Junio/Diciembre) + Eventos vida mayores
- **Revisión SAA**: Anual (Diciembre) o si desviación >10% persistente 2 trimestres
- **Registro decisiones**: Todas las compras/ventas/rebalanceos en Portfolio Tracker + Notion
- **Contador**: Compartir resumen fiscal trimestral

---
**FIRMA**: _________________________  **FECHA**: _______________
**PRÓXIMA REVISIÓN**: _______________
```

---

## 📋 Plantilla 2: Asset Allocation por Perfil (Modelos Listos)

### **Modelo A: Conservador (Preservación + Inflación)**
| Activo | % | Vehículo | Ticker/Ejemplo |
|--------|---|----------|----------------|
| FCI Money Market ARS | 20% | IOL/Cocos/MP | FCI MM ARS |
| Bonos Dollar-Linked AR | 30% | IOL/Cocos | AL30, GD30, TV26 |
| Bonos Hard Dollar AR | 20% | IOL/Cocos | AE38, USDE |
| ETFs Bonos Globales | 15% | IBKR | BND, AGG, VGIT |
| Acciones Global (VT) | 10% | IBKR | VT |
| Stablecoins (USDC) | 5% | Binance/Belo | USDC |
| **Total** | **100%** | | |

### **Modelo B: Moderado - CORE ARGENTINA (Mi Default)**
| Activo | % | Vehículo | Ticker/Ejemplo |
|--------|---|----------|----------------|
| **ETFs Globales (VT/SPY/QQQ)** | **40%** | **IBKR** | VT 20%, SPY 15%, QQQ 5% |
| **CEDEARs Broad (SPY/QQQ/VT)** | **20%** | **IOL/Cocos** | SPY 10%, QQQ 5%, VT 5% |
| **Bonos Dollar-Linked AR** | **15%** | **IOL/Cocos** | AL30 8%, GD30 7% |
| **Bonos Hard Dollar / FCI RF** | **10%** | **IOL/Cocos** | AE38 5%, FCI RF USD 5% |
| **BTC/ETH (Cold Storage)** | **10%** | **Binance → Ledger** | BTC 7%, ETH 3% |
| **Stablecoins / Cash USD** | **5%** | **Wise/Takenos/Belo** | USDC/USDT |
| **Total** | **100%** | | |

### **Modelo C: Agresivo / Crecimiento (Largo Plazo >15 años)**
| Activo | % | Vehículo | Ticker/Ejemplo |
|--------|---|----------|----------------|
| ETFs Globales (VT/SPY/QQQ/VWO) | 55% | IBKR | VT 25%, SPY 15%, QQQ 10%, VWO 5% |
| CEDEARs Growth (NVDA, TSLA, ARKK) | 15% | IOL/Cocos | NVDA, TSLA, ARKK |
| BTC/ETH + DeFi Blue Chips | 15% | Cold Storage | BTC 10%, ETH 5% |
| Bonos Dollar-Linked (solo hedge) | 10% | IOL/Cocos | AL30, GD30 |
| Stablecoins / Oportunidad | 5% | Binance/Belo | USDC |
| **Total** | **100%** | | |

---

## 📋 Plantilla 3: Plan DCA (Dollar Cost Averaging) Automatizado

```markdown
# 🤖 PLAN DCA AUTOMATIZADO - [AÑO]

## APORTES MENSUALES PROGRAMADOS
| Fuente | Moneda | Monto | Frecuencia | Destino | % Asignación |
|--------|--------|-------|------------|---------|--------------|
| Sueldo ARS | ARS | $______ | Mensual (5to) | IOL → FCI MM → DCA CEDEARs | 100% |
| Bug Bounty USD | USD | $______ | Variable (Takenos) | Wise → IBKR DCA | 70% Inversión / 30% Gasto |
| Freelance USD | USD | $______ | Variable | Takenos → IBKR DCA | 70% / 30% |
| Staking/Yield | USDC | $______ | Mensual | Binance → DCA BTC/ETH | 100% Reinvertir |

## EJECUCIÓN SEMANAL (IBKR - GlobalTrader / API)
| Día | Acción | Ticker | Monto USD | Condición |
|-----|--------|--------|-----------|-----------|
| Lunes | Buy | VT | $______ | Siempre |
| Miércoles | Buy | SPY | $______ | Si VT > target |
| Viernes | Buy | QQQ | $______ | Si QQQ < target |
| Sábado | Revisar | - | - | Alertas rebalanceo |

## EJECUCIÓN QUINCENAL (IOL - CEDEARs)
| Quincena | Acción | Ticker | Monto ARS | Condición |
|----------|--------|--------|-----------|-----------|
| 1ra | Buy | SPY / QQQ / VT | $______ | Rotar según banda |
| 2da | Buy | AL30 / GD30 / FCI | $______ | Según banda bonos |

## EJECUCIÓN MENSUAL (CRIPTO)
| Día | Acción | Activo | Monto USDC | Condición |
|-----|--------|--------|------------|-----------|
| 1ro | Buy | BTC | $______ | Siempre (DCA) |
| 15 | Buy | ETH | $______ | Siempre (DCA) |
| 28 | Rebalance | BTC/ETH | - | Si banda >10% |

## REGLAS DCA
- ✅ Ejecutar SIN mirar precio (automatizado)
- ✅ Si mercado -20% desde máx: Duplicar aporte ese mes (opcional)
- ✅ Si mercado +20% desde máx: Mantener aporte normal (NO reducir)
- ❌ NO pausar DCA por "mercado caro" o "miedo"
- ❌ NO timing del mercado
```

---

## 📋 Plantilla 4: Rebalanceo Trimestral (Checklist Ejecutable)

```markdown
# ⚖️ REBALANCEO TRIMESTRAL - [MES/AÑO]

## 1. DATOS ACTUALES (Extraer de Portfolio Tracker)
| Clase Activo | Target % | Actual % | Desviación | Valor Actual | Valor Target | Acción Requerida |
|--------------|----------|----------|------------|--------------|--------------|------------------|
| ETFs Global  | 40%      | ___%     | ___%       | $______      | $______      | COMPRAR / VENDER / HOLD |
| CEDEARs AR   | 20%      | ___%     | ___%       | $______      | $______      | COMPRAR / VENDER / HOLD |
| Bonos AR     | 25%      | ___%     | ___%       | $______      | $______      | COMPRAR / VENDER / HOLD |
| Cripto       | 10%      | ___%     | ___%       | $______      | $______      | COMPRAR / VENDER / HOLD |
| Cash USD     | 5%       | ___%     | ___%       | $______      | $______      | COMPRAR / VENDER / HOLD |
| **TOTAL**    | **100%** | **100%** |            | **$______**  | **$______**  |                  |

## 2. DECISIONES (Solo si |Desviación| > 5% absoluto)
| Acción | Activo | Monto | Precio Límite | Cuenta | Prioridad Fiscal |
|--------|--------|-------|---------------|--------|------------------|
| VENDER | ______ | $_____ | $_____ | ______ | Harvest loss? SÍ/NO |
| COMPRAR | ______ | $_____ | $_____ | ______ | - |
| VENDER | ______ | $_____ | $_____ | ______ | Harvest loss? SÍ/NO |
| COMPRAR | ______ | $_____ | $_____ | ______ | - |

## 3. EJECUCIÓN
- [ ] Órdenes colocadas (Límite, Día/30 días)
- [ ] Confirmadas fills
- [ ] Registradas en Portfolio Tracker + Fiscal_Events
- [ ] Actualizado IPS si cambio estructural

## 4. NOTAS
- Contexto mercado: ___________________________________
- Decisiones discrecionales: ___________________________
- Próximo rebalanceo: _________________________________
```

---

## 📋 Plantilla 5: Lump Sum vs DCA (Decisión Marco)

```markdown
# 💰 DECISIÓN LUMP SUM vs DCA - $[MONTO] - [FECHA]

## CONTEXTO
- Origen fondos: [Herencia / Venta propiedad / Bonus / Acumulación cash]
- Monto: $______ USD / ARS
- % Patrimonio actual: ____%
- Horizonte: ____ años

## ANÁLISIS HISTÓRICO (Vanguard / PWL Capital)
- Lump Sum gana ~68% veces vs DCA 12m (mercados suben 70% tiempo)
- DCA reduce arrepentimiento (regret minimization) si mercado cae post-inversión
- Diferencia rendimientos largo plazo: <0.5% anualizado

## MI DECISIÓN
☐ **LUMP SUM** (Invertir 100% hoy según SAA)
   - Razones: Horizonte >10 años, convicción valuaciones, disciplina probada
   - Ejecución: Órdenes límite escalonadas 2-3 días (evitar micro-timing)

☐ **DCA 3 MESES** (33% / mes)
   - Razones: Volatilidad alta actual (VIX > 25), primera vez gran monto, ansiedad
   - Calendario: Mes 1: 33%, Mes 2: 33%, Mes 3: 34%

☐ **DCA 6 MESES** (16.7% / mes)
   - Razones: Monto >20% patrimonio, mercado en máximos históricos, perfil conservador

☐ **HÍBRIDO** (50% Lump Sum hoy + 50% DCA 3 meses)
   - Razones: Balance matemático + psicológico

## COMPROMISO
- **NO cambiar plan** una vez iniciado (salvo emergencia vital)
- **Registrar decisión** en Notion + Portfolio Tracker
- **Revisar resultado** a 12 meses (learning, no arrepentimiento)

**FIRMA**: _______________  **FECHA**: _______________
```

---

## 📋 Plantilla 6: Stress Test Portfolio (Escenarios)

```markdown
# 🧪 STRESS TEST PORTFOLIO - [FECHA]

## PORTFOLIO ACTUAL: $______ USD

## ESCENARIOS HISTÓRICOS
| Escenario | Año | Caída S&P 500 | Caída Bonos EM | Caída BTC | Mi Portfolio Estimado | Mi Acción |
|-----------|-----|---------------|----------------|-----------|----------------------|-----------|
| COVID Crash | 2020 | -34% | -20% | -50% | -___% | [Hold / Buy / Rebalance] |
| Crisis 2008 | 2008 | -51% | -30% | N/A | -___% | [Hold / Buy / Rebalance] |
| Dot-com | 2000-02 | -49% | -15% | N/A | -___% | [Hold / Buy / Rebalance] |
| 2022 Bear | 2022 | -25% | -18% | -65% | -___% | [Hold / Buy / Rebalance] |
| Argentina 2018 | 2018 | -10% | -45% (ARS) | N/A | -___% | [Hold / Buy / Rebalance] |

## ESCENARIOS HIPOTÉTICOS (Argentina)
| Escenario | Probabilidad | Impacto Portfolio | Mi Plan |
|-----------|--------------|-------------------|---------|
| Devaluación 50% + Cepo total | 15% | -___% | [Plan: USD cash + Crypto + Bonos DL] |
| Default soberano + Reperfilamiento | 10% | -___% | [Plan: Hard dollar bonds + Global ETFs] |
| Hiperinflación (>100% mensual) | 5% | -___% | [Plan: USD/USDC + Hard assets + Crypto] |
| Cambio regulatorio CEDEARs/BP | 20% | -___% | [Plan: Diversificar a IBKR directo] |

## MÉTRICAS RIESGO ACTUALES
- **VaR 95% (1 día)**: $______ (___%)
- **VaR 99% (1 mes)**: $______ (___%)
- **Max Drawdown 12m**: ___%
- **Correlación Promedio Activos**: ___
- **Concentración Top 5**: ___%

## CONCLUSIONES
- Portfolio resiste escenario base: SÍ / NO
- Ajustes necesarios: _________________________________
- Próximo stress test: _______________________________
```
---

## 📋 Plantilla 7: Registro Decisiones (Decision Journal)

```markdown
# 📝 DECISION JOURNAL - INVERSIONES

| Fecha | Decisión | Contexto/Razonamiento | Expectativa | Resultado Real (a 3/6/12m) | Lección |
|-------|----------|----------------------|-------------|----------------------------|---------|
| 2026-03-15 | Aumentar VT 5% | Valuaciones atractivas P/E 18x | +10% 12m | | |
| 2026-06-20 | Vender AL30 50% | Acercamiento vencimiento, swap a GD30 | Reducir duration risk | | |
| 2026-09-10 | No vender BTC -30% | Convicción long term, plan DCA | Recuperar +50% 24m | | |

Regla: **Escribir ANTES de ejecutar**. Revisar trimestralmente.
```

---

## 🔗 Checklist Implementación Inicial

```
[ ] Completar Cuestionario Perfil Riesgo (Score ___/35)
[ ] Redactar IPS Personal (Plantilla 1) → Guardar en Notion + PDF firmado
[ ] Elegir Modelo Asset Allocation (A/B/C o Híbrido) → Plantilla 2
[ ] Configurar DCA Automatizado (IBKR AutoInvest / IOL Programadas / Binance Recurring) → Plantilla 3
[ ] Programar Rebalanceo Trimestral en Calendario (Mar/Jun/Sep/Dic) → Plantilla 4
[ ] Definir regla Lump Sum vs DCA para próximos ingresos grandes → Plantilla 5
[ ] Ejecutar Stress Test Inicial → Plantilla 6
[ ] Crear Decision Journal en Notion → Plantilla 7
[ ] Compartir IPS con contador / pareja / accountability partner
[ ] Automatizar tracking: Portfolio Tracker → Alertas rebalanceo → Notion/Telegram
```

---

*Última actualización: 2026-08-28 | La mejor estrategia es la que **podés seguir cuando el mercado te da miedo**. Escribila, automatizala, respetala.*