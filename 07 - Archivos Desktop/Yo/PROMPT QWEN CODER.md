# Prompt para Qwen Coder 2.5 14B - COMPLETAR RASTRO HOY

**COPIAR Y PEGAR ESTO COMPLETO EN TU TERMINAL CON QWEN:**

\---

```
Eres un expert senior Python developer. Tu tarea: terminar el proyecto Rastro 
(bug bounty automation tool) HOY. El proyecto está al 80% del código pero 3 
bloqueadores críticos impiden que funcione.

PROYECTO: Rastro (https://github.com/AdriDob/Rastro)
- FastAPI backend + Streamlit dashboard
- Bug bounty vulnerability discovery
- Propósito: Encontrar vulnerabilidades de autorización, IDOR, etc.

ESTADO ACTUAL:
- ✓ FastAPI configurado
- ✓ SQLAlchemy models (Target, Endpoint, Finding)
- ✓ Recon pipeline (subfinder, katana, httpx, wayback)
- ✓ Scoring engine
- ✓ Dashboard UI (Streamlit, 9 tabs)
- ✗ 3 BLOQUEADORES CRÍTICOS impiden MVP

OBJETIVO FINAL (Dashboard que ves en imagen adjunta):
- Dashboard profesional con KPIs en tiempo real
- Tabla de endpoints con risk scores
- Top opportunities por ROI
- Activity feed
- Attack surface heatmap
- Bounty programs integrados

---

BLOQUEADOR 1: PERSISTENCIA ENDPOINTS EN BD (CRÍTICO - 2-3h)

Problema exacto:
ReconRunner.run\\\_pipeline() genera JSON normalizado en:
  targets/{name}/endpoints/normalized\\\_endpoints.json
Pero NUNCA guarda en tabla `endpoints` de SQLite.
Resultado: BD vacía, /digest retorna \\\[], dashboard muestra nothing.

Archivos clave:
- database/models.py (modelo Endpoint)
- core/recon/parser.py (EndpointParser.normalize\\\_endpoints)
- core/recon/runner.py (ReconRunner.run\\\_pipeline)
- main.py (POST /scans endpoint)

QUÉ NECESITO:
1. Revisar modelo Endpoint en database/models.py:
   - Debe tener: id, target\\\_id (FK), path, method, params, labels, 
     risk\\\_score, auth\\\_smell, discovered\\\_at, updated\\\_at
   - Si falta algo, añádelo

2. En core/recon/parser.py, AÑADIR método nuevo:
   ```python
   def persist\\\_endpoints\\\_to\\\_db(self, endpoints: list\\\[dict], 
                               target\\\_id: int, session: Session) -> int:
       """
       Persistir endpoints normalizados en BD.
       - Evita duplicados por path+method+target\\\_id
       - Si existe, actualiza risk\\\_score y labels
       - Retorna cantidad de nuevos endpoints
       """
   ```

3. En core/recon/runner.py, integrar en run\_pipeline():

   * Después de normalizar endpoints
   * Llamar a persist\_endpoints\_to\_db()
   * Pasar target\_id, session
   * Manejar errores
4. Test MÍNIMO:

   * Crear target vía API
   * Ejecutar scan FAST
   * Verificar: SELECT COUNT(\*) FROM endpoints WHERE target\_id=1
   * Debe retornar > 0

\---

BLOQUEADOR 2: ERROR HANDLING ROBUSTO (CRÍTICO - 3-4h)

Problema exacto:
POST /scans endpoint en main.py:

* Si subfinder no existe: crash sin logs
* Si katana falla: error 500 genérico
* Si timeout: crash silencioso
* Sin estado de ejecución
* Sin mensajes de error útiles

QUÉ NECESITO:

1. Crear ARCHIVO NUEVO: core/recon/dependency\_checker.py

```python
   class DependencyChecker:
       REQUIRED\\\_TOOLS = \\\["subfinder", "katana", "httpx"]
       
       @classmethod
       def check\\\_installed(cls, tool: str) -> bool:
           # Usa shutil.which()
       
       @classmethod
       def validate\\\_required(cls) -> tuple\\\[bool, list\\\[str]]:
           # Retorna (todo\\\_ok: bool, missing: list\\\[str])
   ```

2. En main.py, refactorizar POST /scans:

```python
   class ScanStatus(str, Enum):
       PENDING = "pending"
       RUNNING = "running"
       COMPLETED = "completed"
       FAILED = "failed"
   
   class ScanResponse(BaseModel):
       scan\\\_id: str
       target\\\_id: int
       status: ScanStatus
       started\\\_at: str
       completed\\\_at: str | None = None
       error: str | None = None
       summary: dict | None = None
   
   @app.post("/scans", response\\\_model=ScanResponse)
   async def start\\\_scan(req: ScanRequest, session: Session = Depends(get\\\_db)):
       """Escanear target con error handling robusto."""
       
       scan\\\_id = f"scan\\\_{req.target\\\_id}\\\_{int(time.time())}"
       
       try:
           # Step 1: Validar que target existe
           target = session.query(models.Target).filter(
               models.Target.id == req.target\\\_id
           ).first()
           if not target:
               raise HTTPException(status\\\_code=404)
           
           # Step 2: Validar dependencias
           all\\\_present, missing = DependencyChecker.validate\\\_required()
           if not all\\\_present:
               return ScanResponse(
                   scan\\\_id=scan\\\_id,
                   target\\\_id=req.target\\\_id,
                   status=ScanStatus.FAILED,
                   started\\\_at=datetime.now().isoformat(),
                   completed\\\_at=datetime.now().isoformat(),
                   error=f"Missing tools: {', '.join(missing)}"
               )
           
           # Step 3: Ejecutar scan con timeout
           runner = ReconRunner(target\\\_dir=f"targets/{target.name}")
           results = await asyncio.wait\\\_for(
               runner.run\\\_pipeline(target.domain, mode=req.mode),
               timeout=600  # 10 min max
           )
           
           # Step 4: Return success
           endpoints = session.query(models.Endpoint).filter(
               models.Endpoint.target\\\_id == target.id
           ).count()
           
           return ScanResponse(
               scan\\\_id=scan\\\_id,
               target\\\_id=req.target\\\_id,
               status=ScanStatus.COMPLETED,
               started\\\_at=datetime.now().isoformat(),
               completed\\\_at=datetime.now().isoformat(),
               summary={"endpoints\\\_found": endpoints}
           )
       
       except asyncio.TimeoutError:
           return ScanResponse(..., status=ScanStatus.FAILED, 
                             error="Scan timeout (10 min)")
       except subprocess.CalledProcessError as e:
           return ScanResponse(..., status=ScanStatus.FAILED,
                             error=f"Tool failed: {e.stderr}")
       except Exception as e:
           logger.error(f"\\\[{scan\\\_id}] Error: {e}", exc\\\_info=True)
           return ScanResponse(..., status=ScanStatus.FAILED,
                             error=str(e))
   ```

3. Logging:

   * Guardar logs en targets/{name}/logs/scan\_{timestamp}.log
   * Cada paso del pipeline loguea con timestamp
4. Test MÍNIMO:

   * curl -X POST /scans con herramientas faltantes
   * Debe retornar status="failed" con error message
   * curl -X POST /scans con timeout
   * Debe retornar error apropiado

\---

BLOQUEADOR 3: VALIDACIÓN DE INPUTS (CRÍTICO - 1-2h)

Problema exacto:
POST /targets, POST /endpoints sin validación.

* target\_id="../../../etc/passwd" → aceptado
* domain="not\_a\_domain!!!" → aceptado sin check
* Path traversal vulnerability

QUÉ NECESITO:

1. Crear ARCHIVO NUEVO: core/security/input\_validator.py

```python
   class InputValidator:
       @classmethod
       def validate\\\_target\\\_name(cls, name: str) -> bool:
           # Sin .., sin /, 3-255 chars
           # Solo alphanuméricas, ., -, \\\_
           if not name or len(name) < 3 or len(name) > 255:
               return False
           if ".." in name or name.startswith("/"):
               return False
           return bool(re.match(r'^\\\[a-zA-Z0-9.\\\_-]+$', name))
       
       @classmethod
       def validate\\\_domain(cls, domain: str) -> bool:
           # RFC 1123 simplificado
           if not domain or len(domain) > 255:
               return False
           pattern = r'^(?:\\\[a-z0-9](?:\\\[a-z0-9-]\\\*\\\[a-z0-9])?\\\\.)\\\*\\\[a-z0-9](?:\\\[a-z0-9-]\\\*\\\[a-z0-9])?$'
           return bool(re.match(pattern, domain.lower()))
   ```

2. En main.py, integrar en POST /targets:

```python
   @app.post("/targets")
   async def create\\\_target(target: TargetCreate, session: Session = Depends(get\\\_db)):
       if not InputValidator.validate\\\_target\\\_name(target.name):
           raise HTTPException(status\\\_code=400, detail="Invalid target name")
       if target.domain and not InputValidator.validate\\\_domain(target.domain):
           raise HTTPException(status\\\_code=400, detail="Invalid domain")
       
       db\\\_target = models.Target(name=target.name, domain=target.domain)
       session.add(db\\\_target)
       session.commit()
       return {"id": db\\\_target.id}
   ```

3. Test MÍNIMO:

   * curl POST /targets con target.name="../../../etc" → 400
   * curl POST /targets con domain="!!!" → 400
   * curl POST /targets con nombre válido → 200

\---

IMPLEMENTACIÓN EXACTA (SIGUE ESTOS PASOS):

PASO 1 (15 min): Bloqueador 1 - Persistencia
□ 1.1 Edita database/models.py - añade campos faltantes a Endpoint
□ 1.2 Crea persist\_endpoints\_to\_db() en core/recon/parser.py
□ 1.3 Integra en core/recon/runner.py (llamar persist en run\_pipeline)
□ 1.4 Test: python -c "from database import db; db.init\_db()"

PASO 2 (20 min): Bloqueador 2 - Error Handling
□ 2.1 Crea core/recon/dependency\_checker.py (DependencyChecker class)
□ 2.2 Refactoriza main.py POST /scans con try-catch
□ 2.3 Añade ScanStatus enum y ScanResponse model
□ 2.4 Test: curl -X POST /scans (sin herramientas) → error message

PASO 3 (15 min): Bloqueador 3 - Validación
□ 3.1 Crea core/security/input\_validator.py
□ 3.2 Integra InputValidator en main.py POST /targets
□ 3.3 Test: curl POST /targets con "../../../etc" → 400

PASO 4 (30 min): E2E Workflow
□ 4.1 python scripts/bootstrap.py (inicializar BD)
□ 4.2 uvicorn main:app --reload (iniciar backend)
□ 4.3 Crear target vía API: curl -X POST /targets
□ 4.4 Ejecutar scan: curl -X POST /scans (espera 30-60 seg)
□ 4.5 Verificar persistencia: sqlite3 rastro.db "SELECT COUNT(\*) FROM endpoints"
□ 4.6 Ver digest: curl /digest

PASO 5 (10 min): Dashboard
□ 5.1 streamlit run dashboard/app.py (otra terminal)
□ 5.2 Verificar que carga sin errores
□ 5.3 Ir a cada tab y probar navegación

PASO 6 (5 min): Git
□ 6.1 git add -A
□ 6.2 git commit -m "feat: complete rastro mvp (3 blockers fixed)"
□ 6.3 git push

\---

INSTRUCCIONES CRÍTICAS:

1. NO uses pseudocódigo. CÓDIGO COMPLETO Y LISTO PARA COPIAR-PEGAR.
2. INCLUYE TODOS LOS IMPORTS (from X import Y).
3. RESPETA ESTRUCTURA EXISTENTE (no rompas nada que funciona).
4. INCLUYE COMENTARIOS explicando cada sección.
5. SIGUE ESTILO PEP8 (4 espacios indent, names\_like\_this para functions).
6. DESPUÉS DE CADA BLOQUEADOR, propón command para testear.
7. SI HAY ERRORES, explica cómo debuggear.

\---

CONTEXTO TÉCNICO (para que entiendas qué haces):

Arquitectura actual:

* main.py: FastAPI app con rutas POST /targets, POST /scans
* database/models.py: SQLAlchemy models (Target, Endpoint, Finding, etc)
* core/recon/runner.py: Orquestador de herramientas (subfinder, katana, httpx, wayback)
* core/recon/parser.py: Normaliza endpoints en JSON
* dashboard/app.py: Streamlit UI con 9 tabs
* database/rastro.db: SQLite (se crea automáticamente)

Lo que falta:

* Endpoints generados en JSON NUNCA se guardan en BD (bloqueador 1)
* Si algo falla en recon, no hay error handling (bloqueador 2)
* Sin validación de inputs (bloqueador 3)

Tu tarea: Conectar esos puntos y hacer que funcione end-to-end.

\---

EMPEZAR:

Responde con PASO 1 COMPLETO:

1. Código para editar database/models.py (qué campos añadir)
2. Código para core/recon/parser.py (persist\_endpoints\_to\_db method)
3. Código para core/recon/runner.py (integración)
4. Command para testear

Luego continuamos con PASO 2, PASO 3, etc.

TIEMPO TOTAL ESTIMADO: 3-4 horas
RESULTADO: MVP 100% funcional listo para producción

¿ENTENDIDO? Vamos. 🚀

```

---

## CÓMO USAR ESTE PROMPT

### Opción A: Desde Terminal (Recomendado)

```bash
# 1. Copia el texto del prompt arriba
# 2. En terminal con Qwen Coder:

cat > prompt\\\_rastro.txt << 'EOF'
\\\[PEGA TODO EL TEXTO DEL PROMPT ARRIBA]
EOF

# 3. Envía a Qwen
ollama run qwen:14b < prompt\\\_rastro.txt

# O interactivo:
ollama run qwen:14b
# \\\[Pega el prompt]
```

### Opción B: Interactivo en Terminal

```bash
ollama run qwen:14b

# Luego pega el prompt arriba completo en la terminal
# Qwen responderá con PASO 1
```

\---

## DESPUÉS DE CADA RESPUESTA DE QWEN

**Cuando Qwen responda con PASO 1:**

```bash
# 1. Guarda el código en los archivos correspondientes
# 2. Test
python -m pytest tests/ -v

# 3. Si funciona, pide PASO 2
# Escribe en terminal:
"OK, PASO 1 implementado y funcionando. Adelante con PASO 2: Error Handling"

# 4. Repite para PASO 3, 4, 5, 6
```

\---

**Este prompt está diseñado para que Qwen Coder 2.5 14B termine TODO hoy sin interrupciones.** 🎯

¿Necesitas ayuda pegándolo o tienes dudas?

