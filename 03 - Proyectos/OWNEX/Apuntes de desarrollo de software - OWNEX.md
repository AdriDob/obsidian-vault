---
tags:
  - ownex
  - aprendizaje
  - ingenieria
  - lecciones
created: 2026-08-17
related:
  - "Apuntes de aprendizaje - OWNEX"
  - "Apuntes de Programación - OWNEX"
---

# Apuntes de desarrollo de software aprendidos trabajando en OWNEX

## 1. Diagnóstico de bugs

* **No asumir la causa por el síntoma.** Un `exit code 1` no explica nada. Hay que conseguir evidencia.
* Cuando una aplicación se cierra silenciosamente, buscar:

  * `stderr`
  * logs
  * dialogs de error
  * exit code
  * procesos hijos
  * archivos creados/modificados
  * stack traces.
* **Reproducir el problema en el entorno más parecido al usuario real.** Que funcione desde el código fuente no demuestra que funcione empaquetado.
* Un bug que aparece solamente en producción puede estar causado por:

  * rutas relativas
  * working directory
  * permisos
  * archivos que no fueron incluidos en el bundle
  * variables de entorno
  * diferencias entre Python y PyInstaller
  * diferencias entre Windows/Linux/WSL.

---

## 2. La importancia de separar síntoma, causa y causa raíz

Ejemplo OWNEX:

```text
Aplicación se cierra
        ↓
Unhandled exception
        ↓
sqlite3.OperationalError
        ↓
unable to open database file
        ↓
database/ no existe
        ↓
la aplicación intenta abrir SQLite durante import-time
        ↓
el bundle no crea el directorio antes de abrir la DB
```

La lección:

> **No arreglar el primer error visible. Seguir la cadena causal hasta encontrar qué condición lo produjo.**

---

### 3. Las rutas relativas son peligrosas

Una ruta como:

```python
sqlite:///./database/catseye.db
```

depende del **working directory actual**.

Eso significa que:

```text
./database/catseye.db
```

no necesariamente significa:

```text
/directorio/del/programa/database/catseye.db
```

Puede significar:

```text
/directorio/desde-el-que-se-lanzó-el-programa/database/catseye.db
```

Lección:

> **En aplicaciones desktop empaquetadas, siempre hay que pensar explícitamente desde dónde se ejecuta el proceso.**

Especialmente en:

* Windows Explorer
* PowerShell
* CMD
* WSL
* IDE
* servicios
* accesos directos
* PyInstaller.

---

### 4. WSL puede producir bugs que parecen absurdos

OWNEX enseñó algo particularmente desagradable:

```text
Windows
   ↓
WSL interop
   ↓
\\wsl.localhost\Ubuntu\...
   ↓
9P/interop filesystem
   ↓
SQLite
```

Un error:

```text
database is locked
```

no necesariamente significa que exista un problema real de concurrencia.

Puede ser consecuencia del **filesystem sobre el que estás ejecutando SQLite**.

Lección:

> **Cuando una aplicación usa SQLite, el filesystem y el modo de acceso importan muchísimo.**

Y más:

> Un error reproducido desde WSL no necesariamente representa el comportamiento de un usuario que ejecuta el `.exe` desde Windows.

---

### 5. SQLite necesita que exista el directorio padre

SQLite puede crear:

```text
catseye.db
```

pero no necesariamente crea automáticamente:

```text
database/
```

Por eso:

```text
database/catseye.db
```

requiere que exista:

```text
database/
```

antes de abrir la conexión.

La solución correcta fue garantizar:

```python
_ensure_db_dir()
engine = create_engine(...)
```

en lugar de esperar a:

```python
init_db()
```

cuando ya podía haber ocurrido un acceso anterior.

---

### 6. Import-time side effects son peligrosos

Uno de los aprendizajes más importantes.

OWNEX tenía una cadena similar a:

```text
app.py
 ↓
main_window.py
 ↓
views/base.py
 ↓
mission.py
 ↓
SessionLocal()
 ↓
SQLite
```

El problema era que la DB se tocaba **durante un import**.

Eso significa que algo aparentemente inocente:

```python
import desktop.native.services.mission
```

podía terminar abriendo una base de datos.

Lección:

> **Los imports deberían hacer la menor cantidad posible de trabajo real.**

Evitar:

```python
# import-time
db = connect_database()
session = SessionLocal()
network = connect_api()
load_everything()
```

Preferir:

```python
def get_session():
    return SessionLocal()
```

y ejecutar explícitamente la operación cuando corresponde.

---

### 7. "Funciona en desarrollo" no significa "funciona empaquetado"

Este fue probablemente uno de los aprendizajes más importantes de OWNEX.

El código fuente funcionaba:

```text
Python + repo + database/
```

pero el bundle tenía:

```text
.exe
database/   ← faltaba
```

Por eso:

```text
DEV             BUNDLE
────────────────────────────
repo            .exe
database/       ❌ database/
Python          PyInstaller
dependencias    dependencias congeladas
```

Lección:

> **El artefacto final es otro entorno. Hay que probar el artefacto, no solamente el código fuente.**

---

### 8. Un instalador no es solamente "copiar el exe"

Hay que verificar:

* archivos incluidos
* directorios necesarios
* permisos
* working directory
* configuración
* DB
* recursos
* dependencias
* shortcuts
* uninstall
* actualización
* hashes
* comportamiento después de instalar desde cero.

Una aplicación puede:

```text
compilar ✔
empaquetar ✔
instalar ✔
abrir ✔
```

y aun así estar rota.

---

### 9. PyInstaller cambia el contexto de ejecución

Al empaquetar una aplicación Python:

```text
Python source
      ↓
PyInstaller
      ↓
frozen application
      ↓
.exe
```

hay que comprobar específicamente:

* imports dinámicos
* recursos
* rutas
* archivos externos
* working directory
* `sys.executable`
* directorio de instalación
* archivos generados en runtime.

Lección:

> **El filesystem de una aplicación empaquetada debe diseñarse explícitamente.**

---

### 10. Los archivos runtime no son necesariamente archivos del proyecto

OWNEX ayudó a distinguir:

```text
Código fuente
Configuración
Datos de usuario
Artefactos de build
Artefactos de instalación
Logs
Bases de datos
```

No todo debería vivir dentro del repositorio.

Por ejemplo:

```text
repo/
    source code
    tests
    docs
    checksums
```

versus:

```text
AppData/
    database
    logs
    runtime state
```

Lección:

> **Separar código, artefactos y estado mutable evita muchos problemas de deployment.**

---

### 11. Una DB de desarrollo y una DB de producción no son lo mismo

OWNEX tenía datos reales en el entorno de desarrollo:

```text
707 targets
historial
findings
```

pero una instalación nueva tenía:

```text
0 targets
0 findings
0 activity
```

Eso no necesariamente significa que la instalación esté rota.

Puede significar simplemente:

```text
instalación nueva = estado nuevo
```

Lección:

> **"La aplicación está vacía" y "la aplicación está rota" son problemas completamente diferentes.**

---

### 12. Una UI puede abrir correctamente y seguir estando incompleta

El desktop finalmente llegó a:

```text
WINDOWS STARTUP: PASS
```

pero eso solamente demuestra:

```text
proceso inicia
↓
Qt inicia
↓
ventana se crea
```

No demuestra:

```text
datos cargan
botones funcionan
pipeline funciona
DB tiene datos
scheduler funciona
operación completa funciona
```

Lección:

> **Startup health ≠ application health.**

Hay que definir distintos niveles:

```text
BUILD PASS
INSTALL PASS
STARTUP PASS
UI PASS
DATA PASS
PIPELINE PASS
END-TO-END PASS
```

---

### 13. Los botones de UI no sirven porque existan

OWNEX tenía algo parecido a:

```python
refresh_btn = QPushButton("Refresh")
```

pero eso no implica:

```python
refresh_btn.clicked.connect(...)
```

Y tampoco implica que exista:

```python
refresh()
```

ni que:

```python
MainWindow
```

la invoque.

Lección:

> **Una interfaz visualmente completa puede ser funcionalmente un esqueleto.**

Hay que comprobar:

```text
Widget
 ↓
Signal
 ↓
Handler
 ↓
Service
 ↓
Data
 ↓
UI update
```

---

### 14. Arquitectura por capas

OWNEX fue mostrando una cadena útil:

```text
UI
 ↓
View
 ↓
Service
 ↓
Engine / domain
 ↓
Database
```

Por ejemplo:

```text
MissionControlView
        ↓
mission service
        ↓
domain/pipeline
        ↓
SQLite
```

Esto permite diagnosticar mejor:

> "La tabla está vacía"

no es suficiente.

Hay que preguntar:

```text
¿La UI pidió datos?
¿El service devolvió datos?
¿El engine produjo datos?
¿La DB tiene datos?
```

---

### 15. Los tests deben probar comportamiento, no solamente imports

Un test como:

```python
import module
```

prueba muy poco.

Es útil, pero no suficiente.

Hay que probar:

```text
input
 ↓
función
 ↓
resultado esperado
```

Y para UI:

```text
service mock
 ↓
refresh()
 ↓
widgets actualizados
```

---

### 16. Los mocks ayudan a separar problemas

Para una vista:

```python
service.get_dashboard()
```

se puede mockear:

```python
{
    "targets": 707,
    "findings": 12
}
```

y comprobar:

```text
Targets → 707
Findings → 12
```

Así no necesitás una DB real para probar que la UI funciona.

---

### 17. Los repros pequeños son extremadamente valiosos

El script:

```text
/tmp/opencode/repro_desktop_chain.py
```

fue una herramienta excelente.

En lugar de ejecutar toda la aplicación, se reproduce:

```text
import app
import main_window
import views
create window
```

Lección:

> **Cuando existe un bug complejo, construir un repro mínimo reduce muchísimo el espacio de búsqueda.**

---

### 18. Capturar stderr puede salvar horas

En una aplicación GUI:

```text
double click
→ crash
→ nada visible
```

es una pesadilla.

Pero:

```powershell
-RedirectStandardError
```

permitió recuperar:

```text
sqlite3.OperationalError:
unable to open database file
```

Lección:

> **Cuando una GUI muere silenciosamente, hay que recuperar stderr aunque la aplicación no tenga consola visible.**

---

### 19. Los diálogos también son evidencia

El diálogo:

```text
Unhandled exception in script
```

no era solamente "un mensaje molesto".

Permitió confirmar:

```text
el proceso sigue vivo
+
Python lanzó excepción
+
PyInstaller está mostrando el error
```

Y con UI Automation se pudo extraer el texto.

Lección:

> **La interfaz también puede ser una fuente de observabilidad.**

---

### 20. El proceso vivo no significa que la aplicación esté sana

OWNEX tuvo:

```text
PID ALIVE
```

pero con:

```text
MainWindowTitle =
"Unhandled exception in script"
```

Entonces:

```text
Process alive ≠ application healthy
```

Hay que mirar:

* PID
* exit code
* ventana
* título
* stderr
* logs
* estado interno.

---

### 21. Validar más allá de "no crasheó"

Una buena prueba de startup debería ser algo como:

```text
launch
↓
wait
↓
process alive
↓
correct window title
↓
no error dialog
↓
database created
↓
UI responsive
```

No:

```text
start.exe
→ no explotó durante 2 segundos
→ PASS
```

Porque los bugs también tienen paciencia. 🫠

---

### 22. Los hashes son parte del deployment

Aprendizaje importante:

```text
build
 ↓
artifact
 ↓
SHA256
 ↓
deploy
 ↓
verify
```

El hash permite comprobar:

> "El instalador que descargué es exactamente el que construí."

No garantiza que el software sea bueno, pero sí que **no estás verificando un archivo distinto**.

---

### 23. El `.exe` y el checksum tienen responsabilidades diferentes

Como el instalador no estaba trackeado:

```text
installer → artifact
checksum → source controlled
```

Eso es razonable.

El repo conserva:

```text
qué artefacto debería existir
```

sin necesariamente almacenar:

```text
el binario pesado
```

---

### 24. Los cambios de deployment deben ser reproducibles

Idealmente:

```text
commit
 ↓
CI
 ↓
artifact
 ↓
hash
 ↓
installer
 ↓
install
 ↓
verify
```

y no:

```text
"creo que copié el exe correcto"
```

La humanidad inventó hashes específicamente porque aparentemente copiar archivos a mano era demasiado sofisticado.

---

### 25. Git limpio antes de trabajar

Una lección muy importante:

```bash
git status
```

antes de modificar cosas.

Porque si ya existen:

```text
M fileA
M fileB
?? fileC
```

no podés asumir que todos tus cambios son tuyos.

Lección:

> **Antes de hacer commit, distinguir cambios preexistentes de cambios producidos por tu tarea.**

---

### 26. Un commit debe representar una unidad lógica

Idealmente:

```text
fix: ensure sqlite directory exists before engine initialization
```

y no:

```text
fix everything
```

Eso hace que:

* revisar sea más fácil
* revertir sea más fácil
* hacer bisect sea más fácil
* entender el historial sea más fácil.

---

### 27. `--no-verify` no significa "ignorar todo"

Cuando los hooks fallan:

```text
pre-commit failed
```

usar:

```bash
git commit --no-verify
```

puede ser válido **si ya verificaste manualmente lo necesario**.

La lección no es:

> "Los hooks molestan."

Es:

> **Un mecanismo automático de calidad no debe reemplazar el criterio técnico.**

---

### 28. No arreglar diez cosas mientras investigás una

OWNEX tuvo varios posibles problemas:

```text
database path
UNC filesystem
logs
data directory
scheduler
UI refresh
backend
```

La disciplina correcta fue:

```text
reproducir
→ obtener evidencia
→ aislar
→ arreglar causa raíz
→ verificar
```

No:

```text
"ya que estoy, voy a refactorizar todo"
```

Ese camino conduce a un commit de 4.000 líneas y a un futuro muy oscuro.

---

### 29. Cambiar lo mínimo cuando la causa está confirmada

La solución terminó siendo conceptualmente pequeña:

```python
_ensure_db_dir()
engine = create_engine(...)
```

No hubo que:

* cambiar SQLite
* cambiar PyInstaller
* cambiar arquitectura
* migrar de DB
* meter un servidor
* reescribir la aplicación.

Lección:

> **Una causa pequeña merece primero una solución pequeña.**

---

### 30. Pero el fix mínimo no debe confundirse con producto terminado

Esto conecta con el problema actual del desktop.

Se arregló:

```text
CRASH
```

pero después apareció:

```text
EMPTY UI
```

Eso no significa que el primer fix haya sido incorrecto.

Significa:

```text
Bug 1 resuelto
↓
ahora Bug/feature 2 visible
```

En sistemas reales esto es normal.

---

### 31. Debuggear es reducir incertidumbre

Una buena sesión de debugging transforma:

```text
"se cierra"
```

en:

```text
"PyInstaller lanza una excepción"
```

después:

```text
"SQLite no puede abrir la DB"
```

después:

```text
"el directorio padre no existe"
```

y finalmente:

```text
"la inicialización de DB ocurre durante import-time antes de init_db()"
```

Ese proceso de reducción de incertidumbre **es una habilidad de ingeniería**.

---

### 32. El mejor siguiente paso no siempre es programar

Después de cerrar el crash de Windows, apareció la pregunta:

> ¿Qué datos debería mostrar el desktop?

Eso ya no es un bug puramente técnico.

Es una **decisión de producto/arquitectura**:

```text
¿Desktop = visor?
¿Desktop = centro operativo?
¿Desktop = cliente del backend?
¿Desktop = aplicación standalone?
```

Lección:

> **No implementar arquitectura para una necesidad que todavía no está definida.**

---

## Las 10 reglas que más me llevaría de OWNEX

Si tuviera que convertir todo esto en una hoja para estudiar, me quedaría con:

1. **No diagnostiques por intuición, diagnostica con evidencia.**
2. **Reproduce en el entorno real, no solamente en desarrollo.**
3. **Las rutas relativas dependen del working directory.**
4. **Evita side effects importantes durante los imports.**
5. **Un `.exe` empaquetado debe probarse como artefacto independiente.**
6. **Process alive no significa application healthy.**
7. **Una UI bonita no implica que los datos estén conectados.**
8. **Separá código, configuración, datos y estado runtime.**
9. **Los cambios pequeños y verificables son más fáciles de mantener.**
10. **Cuando el problema deja de ser técnico y pasa a ser de producto, frená y definí qué debe hacer realmente el sistema.**

Y quizá la más importante de todas:

> **Un software no está terminado cuando compila. Está terminado cuando el comportamiento que importa está probado en el entorno donde realmente lo va a usar alguien.**
