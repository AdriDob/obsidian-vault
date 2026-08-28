---
title: "Rastro - Comandos Rápidos y Entorno"
tags: ["ownex", "rastro", "comandos", "entorno", "desarrollo", "python", "venv"]
created: "2026-08-20"
updated: "2026-08-28"
status: "active"
priority: "high"
related: ["Especificaciones y Prompts Principales", "Guía Instalación Windows", "Rastro - Comandos"]
---

# ⚡ Rastro - Comandos Rápidos y Entorno

> Migrado desde `07 - Archivos Desktop/Yo/cd Rastro.md` + consolidado

---

## 🚀 Activación Rápida (Linux/macOS/WSL)

```bash
cd ~/Rastro
source .venv/bin/activate
```

## 🚀 Activación Rápida (Windows PowerShell)

```powershell
cd C:\Users\ADRI\Rastro
.\.venv\Scripts\Activate.ps1
```

## 🐳 Docker (si aplica)

```bash
# Build
docker build -t rastro .

# Run
docker run -p 8000:8000 -p 8501:8501 rastro
```

---

## 🔧 Comandos de Desarrollo

### Backend (FastAPI)
```bash
# Iniciar backend
uvicorn main:app --reload --host 127.0.0.1 --port 8000

# Con workers (producción)
uvicorn main:app --host 0.0.0.0 --port 8000 --workers 4
```

### Dashboard (Streamlit)
```bash
streamlit run dashboard/app.py
```

### Ollama (Qwen 14B)
```bash
# Servidor
ollama serve

# Cliente interactivo
ollama run qwen:14b-instruct
```

### Base de Datos
```bash
# Inicializar
python scripts/bootstrap.py

# Verificar endpoints
sqlite3 database/rastro.db "SELECT COUNT(*) FROM endpoints;"

# Ver targets
sqlite3 database/rastro.db "SELECT * FROM targets;"
```

---

## 🧪 Testing

```bash
# Tests unitarios
python -m pytest tests/ -v

# Test scan rápido
curl -X POST http://127.0.0.1:8000/scans \
  -H "Content-Type: application/json" \
  -d '{"target_id": 1, "mode": "fast"}'

# Ver digest
curl http://127.0.0.1:8000/digest
```

---

## 📁 Estructura Clave

```
Rastro/
├── main.py                 # FastAPI app
├── database/
│   ├── models.py           # SQLAlchemy models
│   └── rastro.db           # SQLite DB
├── core/
│   ├── recon/
│   │   ├── runner.py       # ReconRunner (pipeline)
│   │   ├── parser.py       # EndpointParser
│   │   └── dependency_checker.py
│   └── security/
│       └── input_validator.py
├── dashboard/
│   └── app.py              # Streamlit dashboard
└── targets/
    └── {name}/             # Por target
        ├── endpoints/
        ├── logs/
        └── findings/
```

---

## 🎯 4 Terminales Mínimas para Desarrollo

| Terminal | Comando | Propósito |
|----------|---------|-----------|
| 1 | `ollama serve` | GPU inference server |
| 2 | `uvicorn main:app --reload` | Backend API |
| 3 | `streamlit run dashboard/app.py` | Dashboard UI |
| 4 | `ollama run qwen:14b-instruct` | IA Helper interactivo |
| 5 | VS Code | Edición código |

---

## 🔑 Variables de Entorno (.env)

```env
# API Keys (opcional)
SHODAN_API_KEY=
CENSYS_API_ID=
CENSYS_API_SECRET=
GITHUB_TOKEN=

# Database
DATABASE_URL=sqlite:///database/rastro.db

# Ollama
OLLAMA_HOST=http://127.0.0.1:11434
OLLAMA_MODEL=qwen:14b-instruct
```

---

*Última actualización: 2026-08-28 | Consolidado desde `07 - Archivos Desktop/Yo/cd Rastro.md`*