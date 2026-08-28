---
title: "Next.js Dashboard Template - Referencia (VChart + Next.js)"
tags: ["tech", "nextjs", "vchart", "dashboard", "template", "referencia", "frontend"]
created: "2026-08-20"
updated: "2026-08-28"
status: "reference"
priority: "low"
related: ["Rastro - Comandos Rápidos", "Especificaciones y Prompts Principales"]
---

# 📊 Next.js Dashboard Template - Referencia

> **Fuente**: [visactor-next-template](https://github.com/mengxi-ream/visactor-next-template) | [Live Demo](https://visactor-next-template.vercel.app/)
> Migrado desde `07 - Archivos Desktop/Yo/Next.js Dashboard README.md`

---

## 🎯 Qué Es

Template moderno de dashboard construido con **VChart** y **Next.js 15**, con UI rica y componentes de visualización de datos. Útil como referencia para el dashboard de Rastro/OwnEx.

---

## ✨ Features Principales

- **Rich Visualizations** — VChart: bar charts, gauge charts, circle packing, linear progress
- **Dark Mode** — Switching seamless con system preference
- **Responsive** — Funciona en todos los dispositivos
- **Beautiful UI** — Tailwind CSS + Shadcn components
- **Next.js 15** — App Router, latest features
- **State Management** — Jotai
- **TypeScript** — Type safety completo

---

## 🛠️ Tech Stack

| Tecnología | Uso |
|-----------|-----|
| Next.js 15 | React framework (App Router) |
| VChart | Visualization library |
| Tailwind CSS | CSS framework |
| Shadcn/UI | Component library |
| Jotai | State management |
| TypeScript | Type safety |

---

## 🚀 Quick Start

```bash
# Clone
git clone https://github.com/mengxi-ream/visactor-next-template

# Install (usa pnpm)
pnpm install

# Dev server
pnpm dev
# → http://localhost:3000
```

---

## 📁 Project Structure

```
src/
├── app/                    # App Router pages
├── components/
│   ├── chart-blocks/       # Chart components (VChart wrappers)
│   ├── nav/                # Navigation components
│   └── ui/                 # Shadcn UI components
├── config/                 # Configuration
├── data/                   # Sample data
├── hooks/                  # Custom hooks
├── lib/                    # Utilities
├── style/                  # Global styles
└── types/                  # TypeScript types
```

---

## 📈 Charts Incluidos (Ejemplos)

- Average Tickets Created (Bar Chart)
- Ticket by Channels (Gauge Chart)
- Conversions (Circle Packing Chart)
- Customer Satisfaction (Linear Progress)
- Metrics Overview

---

## 💡 Para Rastro/OwnEx

**Ideas aprovechables**:
- Componentes `chart-blocks/` como base para widgets dashboard
- Integración VChart + Tailwind + Shadcn = stack visual consistente
- Jotai para estado global simple (filtros, time-range, target seleccionado)
- Dark mode nativo con `next-themes`
- Responsive grid para KPIs + charts

---

## 📄 Licencia

MIT License — Libre para uso, modificación, distribución.

---

*Última actualización: 2026-08-28 | Referencia externa migrada desde `07 - Archivos Desktop/Yo/Next.js Dashboard README.md`*