CE (SIEMPRE ACLARAR QUE CUIDE LA BASE EXISTENTE DE CÓDIGO SI LE PIDO ALGO QUE YA TIENE. SI YA ESTÁ QUE LO PULA)

Debe leer de pies a cabeza los mejores bountys públicos que sea capaz de encontrar. Y hacer en segundo plano el ciclo de trabajo que haría el bug hounter senior, hasta tener un reporte listo para subir. Que tenga grandes chances de aprobación. Si el sistema no es capaz de hacer eso, no es lo que buscamos, porque el usuario no sabe hacer bug bounty manual. Se trata de un ciclo programado y asistido por ia para bug bounty, de élite. Simplificado. Para que lo pueda usar y monitorear cualquier persona interesada en ciberseguridad. Pero debe garantizar las recompensas máximas posibles. Reportes de calidad, flujo de trabajo impecable, para eso le pusimos un exceso de módulos y herramientas open source. Consideramos conectarlo a OWASP ZAP en lugar de Burp Suite, ya que también está enfocado en la accesibilidad para personas de escasos recursos que eligen estudiar.

Descubre bountys de todo tipo de toda la web > Ejecuta pruebas > Prepara el mejor reporte posible listo para subir con enlaces directos

---

PLAN DEL SISTEMA:
Analizá el estado completo del proyecto y elegí automáticamente el siguiente trabajo con mayor impacto para aumentar la tasa de vulnerabilidades encontradas, la calidad de las evidencias, la calidad de los reportes y la probabilidad de obtener recompensas reales. Justificá la decisión, implementá la mejora y verificá que todo siga funcionando correctamente antes de continuar.

---
PROMPT para commits: 

Quiero preparar un commit profesional para GitHub.

Objetivo:
Crear un commit limpio, seguro y bien documentado.

Tareas:

1. Revisar TODOS los cambios del working tree.
2. Agrupar los cambios por categoría:
   - Feature
   - Fix
   - Refactor
   - Performance
   - Security
   - Tests
   - Documentation
   - Build
   - Release

3. Detectar archivos que NO deberían commitearse:
   - .env
   - secrets
   - tokens
   - claves API
   - archivos temporales
   - caches
   - logs
   - __pycache__
   - dist temporales
   - archivos personales
   - backups

4. Verificar que el .gitignore cubra correctamente estos casos.

5. Si encuentra información sensible:
   - NO hacer commit.
   - Mostrar exactamente qué archivo contiene el problema.

6. Mostrar un resumen de:
   - archivos modificados
   - archivos nuevos
   - archivos eliminados
   - cantidad de líneas agregadas
   - cantidad de líneas eliminadas

7. Proponer el mejor mensaje de commit siguiendo Conventional Commits.

Ejemplos:

feat:
fix:
refactor:
perf:
test:
docs:
build:
chore:
release:

8. Escribir además una descripción extensa para el commit explicando:

- Qué se modificó.
- Por qué se modificó.
- Qué impacto tiene.
- Si rompe compatibilidad.
- Riesgos conocidos.
- Próximos pasos.

9. Esperar mi aprobación.

NO ejecutar:

git add
git commit
git push

hasta que yo confirme.

Quiero revisar todo antes de modificar el repositorio.

---

PROMPT PARA ANDROID APK

# ORION / RASTRO — MODO DESARROLLO ANDROID

Objetivo:
Trabajar EXCLUSIVAMENTE sobre la versión Android de Rastro.

Prioridades:

1. Estabilidad
2. UX
3. Rendimiento
4. Integración con el backend existente
5. Compatibilidad futura

REGLAS OBLIGATORIAS

- No modificar backend salvo que sea absolutamente necesario.
- No modificar la versión Desktop.
- No romper compatibilidad con Windows.
- No cambiar APIs existentes sin justificarlo.
- Mantener arquitectura limpia.
- No introducir deuda técnica innecesaria.

Antes de escribir código:

1. Analizar la arquitectura existente.
2. Detectar dependencias.
3. Detectar posibles regresiones.
4. Explicar el plan.
5. Esperar aprobación cuando el cambio sea grande.

Para cada tarea:

- explicar qué hará
- qué archivos modificará
- por qué
- posibles riesgos
- impacto esperado

Prioridades funcionales Android

□ Inicio rápido
□ Login
□ Gestión de licencia
□ Targets
□ Findings
□ Reports
□ Dashboard
□ Notificaciones
□ Sincronización
□ Modo offline
□ Caché local
□ Reintentos automáticos
□ Pull to refresh
□ Dark mode
□ Manejo correcto de errores
□ Loading states
□ Animaciones suaves
□ Navegación fluida

Calidad

Siempre verificar:

- memory leaks
- race conditions
- null safety
- lifecycle
- rendimiento
- consumo de batería
- consumo de red
- consumo de almacenamiento

Networking

- timeouts
- retry
- cancelación de requests
- manejo offline
- sincronización incremental
- manejo de JWT/licencias

UI

Seguir Material Design moderno.

La interfaz debe sentirse:

- rápida
- limpia
- profesional
- consistente
- simple

Evitar:

- pantallas vacías
- loaders infinitos
- errores silenciosos
- botones sin feedback
- bloqueos de UI

Código

Cada cambio debe ser:

- pequeño
- modular
- fácilmente reversible
- documentado

Al finalizar cada tarea mostrar:

- archivos modificados
- líneas agregadas
- líneas eliminadas
- riesgos
- próximos pasos
- nivel de confianza (★★★★★)

Nunca asumir que algo funciona.

Verificar antes de afirmarlo.

Si una tarea requiere cambios grandes, dividirla en pequeñas tareas seguras antes de implementarla.