---
tags:
  - ownex
  - aprendizaje
  - ingenieria
created: 2026-08-17
related:
  - "Apuntes de desarrollo de software - OWNEX"
  - "Apuntes de Programación - OWNEX"
  - "Rastro - Comandos"
  - "OWNEX Payment Network"
  - "Vision Board Final"
---

# Apuntes de aprendizaje trabajando en OWNEX

## 1. Qué es OWNEX realmente

OWNEX/Rastro no terminó siendo simplemente una herramienta de scans.

La idea que fui entendiendo mientras trabajábamos es:

> **OWNEX es un sistema personal que observa, comprende, descubre oportunidades, prioriza, ejecuta con límites, mide resultados y aprende.**

La brújula del proyecto es:

* tomar mejores decisiones;
* hacer más trabajo de forma autónoma;
* reducir esfuerzo humano;
* transformar información en acciones;
* aprender de los resultados.

La parte técnica existe para servir a esa misión.

---

# 2. La primera gran lección: no confundir "funciona" con "está terminado"

Una de las cosas más importantes que aprendí con OWNEX fue que hay varios niveles de "funciona".

Por ejemplo:

```text
El código compila
        ↓
Los tests pasan
        ↓
El programa arranca
        ↓
La ventana aparece
        ↓
Los datos cargan
        ↓
Las acciones funcionan
        ↓
El sistema opera realmente
        ↓
El sistema produce resultados útiles
```

Un sistema puede pasar una etapa y fallar en la siguiente.

Esto pasó exactamente con el desktop Windows:

```text
ANTES:
.exe → crash

DESPUÉS:
.exe → ventana

PERO:
ventana → datos vacíos
```

Por eso:

> **Startup PASS no significa Product PASS.**

---

# 3. Debugging: seguir la evidencia y no enamorarse de la hipótesis

Aprendí que cuando algo falla hay que separar:

* síntoma;
* evidencia;
* hipótesis;
* experimento;
* causa raíz;
* solución.

Ejemplo real de OWNEX:

### Síntoma

Windows cerraba el desktop.

Primero parecía un crash silencioso.

### Primera evidencia

UI Automation mostró:

```text
Unhandled exception in script
```

y después:

```text
sqlite3.OperationalError:
database is locked
```

### Hipótesis

Parecía un problema de SQLite/locks.

Pero había que comprobarlo.

### Experimento

Se lanzó el programa desde distintos working directories.

Apareció otro error:

```text
sqlite3.OperationalError:
unable to open database file
```

### Nueva evidencia

El traceback apuntaba a:

```text
app.py
  ↓
main_window.py
  ↓
views/base.py
  ↓
services/mission.py
  ↓
db.SessionLocal()
```

### Causa raíz

El bundle no tenía:

```text
database/
```

y SQLite intentaba abrir:

```text
./database/catseye.db
```

durante import-time.

### Conclusión

El:

```text
database is locked
```

original era un **síntoma contextual**, producido por ejecutar contra la DB del repo mediante un CWD UNC de WSL.

La causa real del bundle era:

```text
unable to open database file
```

Esto enseñó algo fundamental:

> **El primer error que ves no necesariamente es la causa raíz.**

---

# 4. Aprendí a usar experimentos para aislar variables

En lugar de cambiar diez cosas a la vez, fuimos modificando una variable.

Ejemplo:

```text
Bundle
  ↓
WorkingDirectory UNC
  ↓
database is locked
```

Después:

```text
Bundle
  ↓
WorkingDirectory local
  ↓
unable to open database file
```

Después:

```text
Bundle + database/
  ↓
OWNEX Desktop - OWNEX
  ↓
PASS
```

Ese experimento prácticamente convirtió una sospecha en una prueba.

La regla que queda:

> **Si podés diseñar un experimento que diferencie dos hipótesis, hacelo antes de tocar código.**

---

# 5. Windows + WSL: entendí que el filesystem importa

Aprendí que ejecutar un programa Windows desde un contexto WSL puede producir un working directory como:

```text
\\wsl.localhost\Ubuntu\home\adriel\projects\Rastro
```

Eso no es equivalente a ejecutar directamente sobre:

```text
C:\Users\adriel\...
```

Especialmente cuando SQLite entra en escena.

La DB puede terminar accediéndose mediante una capa de filesystem/interop distinta, con problemas de locking.

Por eso aprendí a distinguir:

```text
Linux filesystem
WSL interop
UNC path
Windows filesystem
```

No son intercambiables solo porque "todos son carpetas".

---

# 6. SQLite: aprendí que el directorio padre importa

SQLite puede crear el archivo:

```text
catseye.db
```

pero no puede crear automáticamente todos los directorios padre necesarios.

Esto:

```text
database/catseye.db
```

requiere que exista:

```text
database/
```

Por eso:

```python
create_engine("sqlite:///./database/catseye.db")
```

puede fallar antes de que la aplicación llegue a:

```python
init_db()
```

Si el acceso ocurre durante import-time, esperar que `init_db()` cree el directorio es demasiado tarde.

La solución fue hacer:

```text
_ensure_db_dir()
        ↓
create_engine(...)
```

y no:

```text
create_engine(...)
        ↓
init_db()
        ↓
_ensure_db_dir()
```

La lección general:

> **Los recursos necesarios durante import-time deben existir antes del import-time.**

---

# 7. Import-time side effects son peligrosos

OWNEX me mostró algo importante:

```python
SessionLocal()
```

durante la importación de módulos puede hacer que un problema de infraestructura parezca un problema de UI.

La cadena era:

```text
app.py
 ↓
main_window.py
 ↓
views/base.py
 ↓
services/mission.py
 ↓
SessionLocal()
 ↓
SQLite
 ↓
CRASH
```

Eso significa que la aplicación podía morir antes de que la ventana estuviera realmente funcionando.

Aprendizaje:

> **Evitar trabajo pesado, IO y acceso a infraestructura durante imports cuando sea posible.**

Si no se puede evitar, hay que garantizar que todas las precondiciones existan.

---

# 8. PyInstaller no es simplemente "copiar Python a un exe"

Aprendí que un bundle PyInstaller tiene un entorno distinto al repo.

En desarrollo:

```text
repo/
├── database/
├── desktop/
├── cores/
└── ...
```

En el bundle:

```text
OWNEX-Desktop-Alpha.exe
database/   ← puede no existir
```

Por lo tanto:

> **"Funciona en desarrollo" no prueba que funcione congelado.**

Hay que probar el artefacto final.

---

# 9. El debugging del ejecutable frozen es diferente

Aprendí una técnica especialmente útil:

```powershell
Start-Process
-RedirectStandardError
```

permitió capturar el traceback del ejecutable Windows.

También aprendí que PySide6 puede mostrar:

```text
Unhandled exception in script
```

en una ventana modal.

Con UI Automation pudimos leer el texto del diálogo.

Eso permitió convertir:

```text
.exe desapareció
```

en:

```text
sqlite3.OperationalError:
unable to open database file
```

Una diferencia enorme.

---

# 10. PySide6: una ventana visible no significa UI funcional

OWNEX también mostró otra capa.

El desktop podía mostrar:

```text
OWNEX Desktop - OWNEX
```

y aun así estar prácticamente vacío.

La UI tenía widgets como:

```text
Targets: --
Findings: --
Operations: --
Activity: --
```

y tablas vacías.

Había incluso botones:

```text
Refresh
```

pero no necesariamente:

```python
refresh_btn.clicked.connect(...)
```

ni:

```python
view.refresh()
```

desde navegación.

Aprendí:

> **Un widget dibujado no significa que tenga comportamiento conectado.**

---

# 11. Arquitectura UI: separar View de Service

La UI no debería acceder directamente a SQLite para cada cosa.

El patrón correcto que fui entendiendo es:

```text
View
 ↓
Service
 ↓
Domain / Engine
 ↓
Persistence
```

Por ejemplo:

```text
MissionControlView
        ↓
mission service
        ↓
database / engines
```

Esto permite cambiar la fuente de datos sin reescribir toda la UI.

---

# 12. El botón Refresh no es magia

Aprendí que una UI necesita un flujo explícito:

```text
usuario navega
    ↓
view seleccionada
    ↓
refresh()
    ↓
service
    ↓
datos
    ↓
widgets
```

y para refresh manual:

```text
click
 ↓
refresh()
 ↓
service
 ↓
widgets
```

Si cualquiera de esos enlaces falta, el botón puede existir pero ser decorativo.

---

# 13. La DB de desarrollo NO es automáticamente la DB de producción

Este fue uno de los aprendizajes más importantes recientes.

En WSL había una DB con datos reales de desarrollo:

```text
707 targets
historial
findings
...
```

La instalación Windows creó una DB nueva:

```text
0 targets
0 findings
0 activity
```

La tentación era:

```text
copiar DB dev → Windows
```

Pero eso mezcla:

```text
development state
```

con:

```text
operational state
```

Aprendí que eso no es una solución arquitectónica.

La pregunta correcta es:

> **¿Cuál es la fuente de verdad operativa?**

No:

> "¿Cómo hago para que la pantalla tenga números?"

---

# 14. Las actualizaciones de software y los datos son cosas distintas

Aprendí algo importante con el instalador:

```text
código de aplicación
```

y:

```text
datos operativos
```

deben tener ciclos de vida diferentes.

El instalador puede reemplazar:

```text
.exe
DLLs
Python frozen modules
UI
```

sin destruir:

```text
DB
targets
findings
historial
configuración
```

Por eso una nueva instalación debería comportarse como:

```text
v1
 ↓
v2
 ↓
v3
```

y no como:

```text
v1
 ↓
borrar todo
 ↓
instalar v2
 ↓
perder datos
```

---

# 15. Entendí mejor qué significa un instalador "actualizable"

La instalación actual no es descartable.

Es una base instalada.

Un nuevo build puede:

```text
nuevo installer
       ↓
instalación existente
       ↓
sobrescribir aplicación
       ↓
preservar datos
```

Por eso:

> **No hace falta reinstalar por cada cambio conceptual.**

Solo hace falta generar un nuevo build cuando cambió algo que debe entrar al artefacto.

---

# 16. Git: aprendí a proteger trabajo existente

En OWNEX había archivos modificados y no trackeados previamente.

La regla importante fue:

> **No meter basura preexistente en un commit nuevo.**

Antes de commit:

```bash
git status
git diff
```

y revisar exactamente qué cambió.

También aprendí a distinguir:

```text
mi cambio
```

de:

```text
cambio previo del usuario
```

Eso es fundamental en proyectos reales.

---

# 17. `--no-verify` tiene un uso concreto

El pre-commit podía fallar por cuestiones que no pertenecían al cambio actual.

Aprendí que:

```bash
git commit --no-verify
```

no significa:

> "ignorar la calidad".

Significa:

> "este hook no puede bloquear este commit por razones externas/preexistentes y el cambio fue revisado manualmente".

Pero debe utilizarse conscientemente.

---

# 18. Aprendí a respetar el estado del repo

Una regla que se volvió importante:

> **No tocar Git, DB ni proyecto cuando existe una situación que todavía necesita recuperación o verificación.**

Primero:

```text
preservar
 ↓
inspeccionar
 ↓
confirmar estado
 ↓
recién modificar
```

Esto evita transformar un problema recuperable en uno mucho peor.

---

# 19. CI/CD: el build de CI es parte del producto

Aprendí que no alcanza con:

```text
"mi máquina compila"
```

El ciclo correcto es:

```text
código
 ↓
commit
 ↓
push
 ↓
CI
 ↓
artifact
 ↓
checksum
 ↓
deploy
 ↓
install
 ↓
test real
```

El workflow de Windows usado fue:

```text
ownex-alpha-windows.yml
```

y hubo que verificar el artifact generado.

---

# 20. Hashes: el artefacto tiene identidad verificable

Aprendí a tratar el SHA-256 del instalador como una identidad del artefacto.

Por ejemplo, un build tenía:

```text
3a4775544600093ceef43b7c93badd3107955a53b154e074c59bd38160e3bc4f
```

Los hashes debían mantenerse sincronizados en varios lugares.

Esto permite comprobar:

```text
archivo recibido
=
archivo generado
```

y evita actualizar documentación con un instalador distinto.

---

# 21. No todo archivo del deploy pertenece a Git

El `.exe` del instalador está ignorado:

```text
/ownexinstalador/
```

Por lo tanto:

```text
installer → deploy artifact
checksum → Git
```

Eso evita meter binarios enormes o artefactos generados en el historial.

Aprendí a distinguir:

```text
source of truth del código
```

de:

```text
artifact de distribución
```

---

# 22. No tocar plataformas que no forman parte del cambio

OWNEX tiene Android y Windows, pero eso no significa que cada cambio deba tocar ambos.

Reglas aprendidas:

* no tocar AAB;
* no modificar checksum Android;
* no generar Linux bundle si no corresponde;
* no mover tags existentes.

Esto reduce muchísimo el riesgo.

---

# 23. Tests: pasar tests es evidencia, no garantía absoluta

OWNEX tuvo suites verdes, pero el bundle Windows igualmente falló.

Eso enseñó una distinción:

```text
unit tests
```

validan:

```text
comportamiento del código
```

pero no necesariamente:

```text
entorno de packaging
filesystem real
working directory
installer
Windows
PyInstaller
```

Por eso hacen falta varios niveles:

```text
unit
 ↓
integration
 ↓
application
 ↓
packaging
 ↓
real installation
```

---

# 24. El entorno de ejecución forma parte del software

Aprendí que estas variables pueden cambiar el comportamiento:

```text
OS
filesystem
CWD
environment variables
DATABASE_URL
permissions
packaging
Python frozen/unfrozen
```

Por eso reproducir un bug requiere reproducir el entorno, no solamente ejecutar el mismo código.

---

# 25. Los repros pequeños son extremadamente valiosos

Creamos:

```text
/tmp/opencode/repro_desktop_chain.py
```

para probar la cadena:

```text
desktop.native.app
 ↓
desktop.native.ui.main_window
 ↓
desktop.native.ui.views.base
```

y verificar:

```text
OK
WINDOW CREATED OK
```

Aprendí que un repro pequeño:

* reduce ruido;
* hace visible la causa;
* evita tocar producto innecesariamente;
* sirve para volver a comprobar el fix.

---

# 26. Las herramientas también tienen bugs y quirks

Aprendí a no confiar ciegamente en el mensaje de una herramienta.

Por ejemplo, el edit tool podía:

```text
reportar error
```

aunque el cambio hubiera sido aplicado.

Por eso la comprobación real debía ser:

```bash
grep
git diff
archivo
LSP
tests
```

La regla:

> **El estado del archivo manda; el mensaje de la herramienta no.**

---

# 27. Un LSP error también puede revelar un problema real

El fix de `_ensure_db_dir()` produjo:

```text
Function declaration _ensure_db_dir is obscured
by a declaration of the same name
```

Eso permitió descubrir que había quedado:

```text
def _ensure_db_dir()
```

dos veces.

Aprendí que los diagnósticos del editor no son solo ruido. A veces descubren efectos secundarios de una edición.

---

# 28. Mínimo cambio primero

En varias decisiones apareció el mismo principio:

> **No arreglar cinco cosas porque una está rota.**

Por ejemplo, frente al problema del directorio:

```text
database/
```

la solución mínima era arreglar `db.py`.

No empezar simultáneamente a cambiar:

```text
logs/
data/
cache/
config/
```

sin evidencia de que fueran problemas.

Esto reduce superficie de regresión.

---

# 29. La arquitectura debe responder "quién hace qué"

Una pregunta que OWNEX empezó a obligarme a hacer:

```text
¿Quién crea los datos?
¿Quién los persiste?
¿Quién los consume?
¿Quién los modifica?
¿Quién los sincroniza?
¿Quién ejecuta el pipeline?
¿Quién ejecuta el scheduler?
```

Si no hay una respuesta clara, probablemente hay una deuda arquitectónica.

---

# 30. Desktop ≠ backend ≠ pipeline ≠ DB

Aprendí a no pensar:

```text
OWNEX = una aplicación
```

sino:

```text
OWNEX
├── Desktop
├── UI
├── Services
├── Engines
├── Scheduler
├── Pipeline
├── Persistence
└── Data
```

Cada componente tiene una responsabilidad.

El desktop puede ser una shell y no necesariamente el proceso que hace todo el trabajo.

---

# 31. Producto: "mostrar datos" y "operar" son requisitos diferentes

Una pregunta clave que surgió:

> ¿Queremos que el desktop solamente muestre información o que realmente opere el sistema?

No son el mismo producto.

### Visualización

```text
DB/API
 ↓
Desktop
 ↓
Dashboard
```

### Operación

```text
Desktop
 ↓
acciones
 ↓
pipeline
 ↓
scheduler
 ↓
findings
 ↓
DB
```

El segundo requiere mucha más arquitectura.

---

# 32. Bug bounty: el objetivo final no es construir por construir

Otra lección importante de OWNEX:

El sistema no existe para acumular features.

El objetivo es:

```text
target
 ↓
reconocimiento
 ↓
oportunidad
 ↓
validación
 ↓
finding
 ↓
evidencia
 ↓
reporte
 ↓
recompensa
```

Por eso el criterio de ROI importa.

Una feature que tarda una semana pero no aumenta:

* probabilidad de encontrar vulnerabilidades;
* calidad de evidencia;
* aceptación del reporte;
* automatización;
* reducción de trabajo manual;

puede tener menos valor que simplemente operar el sistema.

---

# 33. Aprendí a distinguir deuda técnica de prioridad

OWNEX tiene deudas conocidas, por ejemplo:

* FeedbackLearner no conectado;
* threshold fijo;
* detalles de logging;
* twin trees;
* otras decisiones pendientes.

Pero que algo sea deuda no significa que haya que arreglarlo inmediatamente.

La pregunta correcta es:

> **¿Esto bloquea el objetivo actual?**

Si no:

```text
deuda conocida
≠
prioridad inmediata
```

---

# 34. Aprendí que la estabilidad precede a la expansión

Antes de agregar funcionalidades:

```text
arranque
 ↓
persistencia
 ↓
UI
 ↓
operación
 ↓
tests
```

debe ser estable.

Porque agregar features sobre una base que todavía no tiene definido dónde viven los datos genera una montaña de trabajo posterior.

---

# 35. La gran lección sobre debugging

El proceso completo que aprendí puede resumirse así:

```text
1. Reproducir
2. Observar
3. Capturar evidencia
4. Formular hipótesis
5. Diseñar experimento
6. Aislar variable
7. Encontrar causa raíz
8. Hacer cambio mínimo
9. Reproducir
10. Verificar regresiones
11. Empaquetar
12. Probar artefacto real
13. Documentar
```

No:

```text
1. Cambiar cosas
2. Esperar
3. Cambiar más cosas
4. Rezarlo
```

Aunque el segundo método tiene una popularidad sorprendentemente alta en la industria. 😌

---

# 36. Mi modelo mental actual de OWNEX

Después de todo el trabajo, el modelo que me queda es:

```text
                    ┌───────────────┐
                    │    TARGETS    │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │   DISCOVERY   │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │ OPPORTUNITIES │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │ VALIDATION    │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │   FINDINGS    │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │   EVIDENCE    │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │    REPORT     │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │   REWARD      │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │    LEARNING   │
                    └───────────────┘
```

Y alrededor de eso:

```text
Desktop
Services
Engines
Scheduler
Persistence
CI/CD
Observability
```

---

# 37. Principios que me llevo de OWNEX

## Principio 1

**Primero evidencia, después hipótesis.**

## Principio 2

**Un programa que abre no necesariamente funciona.**

## Principio 3

**El entorno de ejecución es parte del software.**

## Principio 4

**La DB operativa no debe confundirse con la DB de desarrollo.**

## Principio 5

**Los datos tienen un ciclo de vida distinto al código.**

## Principio 6

**El artefacto final debe probarse, no solo el source.**

## Principio 7

**Un botón sin wiring no es una feature.**

## Principio 8

**Los imports deberían tener la menor cantidad posible de side effects.**

## Principio 9

**Los cambios mínimos son más fáciles de verificar.**

## Principio 10

**No toda deuda técnica merece atención inmediata.**

## Principio 11

**CI y packaging forman parte del producto.**

## Principio 12

**Un sistema operativo real necesita una fuente de verdad clara.**

## Principio 13

**No hay que llenar una UI de datos falsos para esconder una arquitectura incompleta.**

## Principio 14

**El objetivo final es el resultado producido por el sistema, no la cantidad de código construido.**

---

# 38. Lo que OWNEX me enseñó sobre construir software de verdad

La diferencia más grande entre hacer ejercicios de programación y trabajar en OWNEX fue esta:

En un ejercicio:

```text
código → resultado
```

En un sistema real:

```text
código
 ↓
dependencias
 ↓
filesystem
 ↓
database
 ↓
procesos
 ↓
packaging
 ↓
OS
 ↓
installer
 ↓
datos
 ↓
usuario
 ↓
operación
```

Y cualquiera de esas capas puede romper todo.

Por eso ahora entiendo mejor que **ingeniería de software no es solamente escribir código**.

Es controlar un sistema completo y poder explicar, con evidencia:

> qué está pasando, por qué está pasando, qué debería pasar y cómo sé que el cambio realmente lo solucionó.

---

# 39. Estado actual de aprendizaje

Lo que ya aprendí haciendo OWNEX:

* Python aplicado a un sistema grande.
* Arquitectura por capas.
* Services y engines.
* SQLite y SQLAlchemy.
* Persistencia y lifecycle de DB.
* Import-time side effects.
* PySide6.
* Qt y UI wiring.
* Windows + WSL.
* Filesystems y UNC.
* PyInstaller.
* Debugging de ejecutables frozen.
* UI Automation.
* PowerShell.
* CI/CD.
* Git disciplinado.
* SHA-256 y artefactos.
* Instaladores Windows.
* Actualizaciones de software.
* Separación código/datos.
* Debugging basado en evidencia.
* Diseño de repros.
* Testing multinivel.
* Arquitectura operativa.
* Priorización por ROI.
* Bug bounty como sistema de producción.
* Diferencia entre demo, herramienta y sistema operativo real.

Y quizá el aprendizaje más importante:

> **No necesito que OWNEX tenga más código. Necesito que cada parte que ya existe tenga una responsabilidad clara y produzca un resultado verificable.** Sí. Te conviene que esos apuntes no sean un simple historial de "hice X en OWNEX", sino **conocimiento reutilizable de ingeniería de software que descubriste trabajando en OWNEX**. Porque sufrir bugs específicos y convertirlos en principios generales es, lamentablemente, una de las pocas formas en que el sufrimiento técnico produce algo útil. 😌
