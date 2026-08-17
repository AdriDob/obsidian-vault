---
title: "Rastro - Comandos y Configuración"
tags: ["ownex", "rastro", "setup", "terminal"]
created: "2024-01-01"
updated: "2026-08-17"
status: "active"
priority: "medium"
related: ["Apuntes de aprendizaje - OWNEX", "Apuntes de Programación - OWNEX"]
---
cd /home/adrie/Rastro
source .venv/bin/activate
python scripts/bootstrap.py
uvicorn main:app --reload
streamlit run dashboard/app.py

Comandos útiles 

---
