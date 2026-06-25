[[Apuntes]]
[[Comparación.png]]
[[U - ADRIE (USER)]]
[[IDOR - XSS - RCE]]
[[RASTRO apuntes]]
[[MISC]]
[[+]]

![[fsociety_premium_v5(1).pdf]]

### ✅ Las ÚNICAS Herramientas Que Necesitas (Legales y Efectivas)

#### **Tier 1: ESENCIALES (Instala SOLO Estas)**

##### **1. Burp Suite Community Edition**

bash

```bash
# NO necesitas instalación de terminal
# Descarga directa: https://portswigger.net/burp/communitydownload

Por qué SÍ:
✅ Manual, tú controlas todo
✅ Aceptado en TODOS los programas
✅ Aprende mientras usas
✅ No genera tráfico sospechoso

Por qué NO automatizarlo:
❌ Burp Scanner (versión Pro) está PROHIBIDO en mayoría de programas
```

**Setup correcto:**

bash

```bash
# Después de instalar:
1. Proxy → Listeners → 127.0.0.1:8080
2. Browser → Config proxy a localhost:8080
3. Intercept ON
4. MANUAL testing only
```

---

##### **2. Navegador con DevTools**

bash

```bash
# Ya lo tienes instalado (Chrome/Firefox)

Herramientas integradas:
- Network tab (ver requests)
- Console (probar JavaScript)
- Application (ver cookies/storage)
- Sources (leer código frontend)

Esto encuentra el 50% de bugs de alto pago
```

---

#### **Tier 2: RECONOCIMIENTO PASIVO (Seguras)**

Estas herramientas SOLO buscan información pública, NO atacan:

##### **1. Subfinder - Descubrir subdominios**

bash

```bash
# Instalación
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Uso correcto (pasivo, no ataca)
subfinder -d target.com -o subdomains.txt

# Esto NO es atacar, solo busca en fuentes públicas:
- DNS records
- Certificados SSL públicos  
- Motores de búsqueda
```

**Por qué SÍ usar:**

- ✅ Encuentra assets olvidados (dev.target.com, staging.target.com)
- ✅ Completamente pasivo
- ✅ Aceptado en bug bounty

---

##### **2. httpx - Verificar qué subdominios están vivos**

bash

```bash
# Instalación
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Uso
cat subdomains.txt | httpx -status-code -title

# Solo hace peticiones HTTP simples, como abrir el navegador
```

---

##### **3. waybackurls - Ver URLs históricas**

bash

```bash
# Instalación
go install github.com/tomnomnom/waybackurls@latest

# Uso
echo "target.com" | waybackurls > urls.txt

# Busca en Internet Archive (público)
# Encuentra endpoints viejos/olvidados
```

---

#### **Tier 3: ANÁLISIS MANUAL (Para expertos, NO automatices)**

##### **4. nuclei - Templates de vulnerabilidades**

bash

```bash
# Instalación
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# ⚠️ PELIGRO: Puede ser muy agresivo
```

**IMPORTANTE:**

```
❌ NO correr nuclei completo sin permiso
❌ NO usar templates de CVE scanning
❌ NO automatizar en múltiples targets

✅ SÍ usar templates específicos después de análisis manual
✅ SÍ configurar rate-limiting
✅ SÍ solo en scope definido
```

**Uso CORRECTO (ejemplo):**

bash

```bash
# Solo buscar exposición de archivos sensibles (pasivo)
nuclei -u https://target.com -t exposures/ -rl 10

# -rl 10 = máximo 10 requests por segundo (respetuoso)
```

---

### 🎯 El Setup REAL de Un Hunter de $100K/año

bash

```bash
# Terminal tools (solo reconocimiento)
~/tools/
├── subfinder        # Subdomain discovery
├── httpx            # HTTP probing
├── waybackurls      # Historical URLs
└── gf               # Grep patterns (buscar en outputs)

# GUI tools
- Burp Suite Community (manual proxy)
- Browser DevTools
- Notion/Obsidian (notas)

# That's it. Nada más.
```

**Su workflow:**

```
1. subfinder → encuentra subdominios
2. httpx → verifica cuáles están vivos
3. Browser → explora manualmente cada uno
4. Burp → intercepta requests interesantes
5. Cerebro → modifica parámetros, busca lógica rota
6. Reporte → documentar finding
```

**NO hay "exploit mágico".**

---

### 💡 La Metodología CORRECTA (Sin Exploits)

#### **Ejemplo: Buscando Broken Access Control en GitLab**

**Paso 1: Recon pasivo (5 min)**

bash

```bash
# Encuentra subdominios
subfinder -d gitlab.com -o gitlab_subs.txt

# Verifica cuáles responden
cat gitlab_subs.txt | httpx -title -status-code

# Output ejemplo:
# https://staging.gitlab.com [200] [GitLab Staging]
# https://dev.gitlab.com [403] [Forbidden]
```

**Paso 2: Exploración manual (30 min)**

```
1. Abre staging.gitlab.com en navegador
2. Crea cuenta de prueba GRATIS
3. Explora funcionalidades
4. Identifica roles: Guest, Developer, Maintainer, Owner
```

**Paso 3: Burp analysis (1 hora)**

```
1. Activa Burp Intercept
2. Realiza acciones como Guest
3. Intercepta requests
4. Busca parámetros: access_level, role, permissions
5. Modifica valores manualmente
6. Observa respuestas
```

**Paso 4: Testing (30 min)**

```
1. Guest intenta acción de Owner
2. Cambias access_level en request
3. ¿Funciona? → Bug encontrado
4. Documenta
```

**TOTAL: 2 horas, 0 exploits, potencial $5K-$12K**

---

### 🛠️ Setup Minimalista (Lo Que Realmente Instalo)

bash

```bash
# 1. Instalar Go (necesario para herramientas)
# macOS/Linux:
wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export PATH=$PATH:~/go/bin' >> ~/.bashrc
source ~/.bashrc

# 2. Herramientas de recon PASIVO
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/tomnomnom/waybackurls@latest

# 3. Utility tools
go install github.com/tomnomnom/gf@latest
go install github.com/tomnomnom/qsreplace@latest

# 4. Verificar instalación
subfinder -version
httpx -version
```

**Eso es TODO lo que necesitas en terminal.**

---

### 📋 Workflow Diario de Un Pro

bash

```bash
# Morning routine (30 min)
# 1. Elegir target del día
TARGET="example.com"

# 2. Recon básico
subfinder -d $TARGET -o subs.txt
cat subs.txt | httpx -silent -status-code -title | tee live.txt

# 3. Buscar URLs interesantes
cat subs.txt | waybackurls | grep -E "api|admin|config|backup" > interesting.txt

# 4. Review manual
cat interesting.txt  # Leer con tus ojos

# AHORA EMPIEZA EL TRABAJO REAL:
# 5. Abrir navegador + Burp
# 6. Explorar manualmente cada URL interesante
# 7. Buscar lógica rota (NO correr exploits)
```

---

### 🎓 Por Qué Esto Funciona Mejor

#### **Comparación Real:**

**Script Kiddie con exploits:**

```
Día 1: Corre sqlmap en 100 targets
Resultado: 50 duplicates, 2 bans, $0

Día 30: Frustrado, sin entender nada
Total ganado: $0
```

**Hunter inteligente (tú):**

```
Día 1: Explora 1 target manualmente, entiende su lógica
Resultado: 1 bug único de Broken Access Control

Día 30: Reporta 5 bugs bien documentados
Total ganado: $2,500 (promedio $500/bug)
```

---

### ✅ Tu Checklist de Herramientas

```
INSTALAR:
□ Burp Suite Community
□ subfinder
□ httpx  
□ waybackurls

NO INSTALAR:
□ sqlmap
□ nmap
□ metasploit
□ nuclei (hasta que entiendas bien)
□ Cualquier cosa con "exploit" en el nombre

APRENDER A USAR:
□ Burp Proxy manual
□ Burp Repeater
□ Browser DevTools
□ Grep/filtros básicos de terminal
```

---

### 🚨 Advertencia Final

**La regla de oro:**

> **"Si la herramienta hace 1000+ requests automáticamente, NO la uses en bug bounty sin permiso explícito"**

**Ejemplos de permiso explícito:**

- Programa dice: "Rate limiting is in scope, test it"
- Programa dice: "Automated scanning allowed"
- Programa es tuyo (tu propia app)

**99% de programas NO dan este permiso.**

---

### 🎯 La Respuesta Directa

**Preguntaste:** "¿Cuál es el mejor sploit open source?"

**Respuesta:** **NINGUNO.** No necesitas exploits.

**Lo que SÍ necesitas:**

1. Burp Suite (manual)
2. Subfinder + httpx (recon pasivo)
3. Tu cerebro (análisis de lógica)
4. Paciencia (2-3 horas por target)

**Esto es lo que separa a los hunters de $50K/año de los baneados.**

---
terminaciones:
### Conceptos Clave del Bug Bounty

**Bug Bounty** (Recompensa por Errores) es un programa en el que organizaciones ofrecen recompensas a **hackers éticos** o investigadores por encontrar y reportar vulnerabilidades de seguridad en sus sistemas.  A continuación, se detallan los conceptos más relevantes:

1. **Scope (Alcance)**: Define los activos digitales (como sitios web, aplicaciones o APIs) que están incluidos (`In Scope`) y excluidos (`Out of Scope`) del programa. Solo las vulnerabilidades encontradas dentro del alcance son elegibles para recompensa. 
    

[

](https://www.bugcrowd.com/blog/the-importance-of-scope-bug-bounty-hunter-methodology/)

[

](https://www.threatngsecurity.com/glossary/in-scope-bug-bounty)

[

](https://www.forbesargentina.com/innovacion/no-hay-mejor-defensa-buen-ataque-como-funciona-bug-bounty-sistema-les-paga-hackers-encontrar-errores-n90001)

[

](https://www.bugcrowd.com/wp-content/uploads/2023/11/Understanding-Bug-Bounty-Scope-Datasheet.pdf)

[

](https://docs.hackerone.com/en/articles/8494552-defining-scope)

[concepto de scope en bug bounty](https://search.brave.com/search?q=concepto%20de%20scope%20en%20bug%20bounty)

Mostrar todo

2. **Vulnerabilidad**: Un error, fallo o "bug" en el software o hardware que puede ser explotado para comprometer la seguridad. La gravedad de la vulnerabilidad (crítica, alta, media, baja) determina el monto de la recompensa. 
    

[

](https://smowl.net/es/blog/vulnerabilidad-en-la-seguridad-informatica/)

[

](https://www.proofpoint.com/es/threat-reference/vulnerability)

[

](https://www.campusciberseguridad.com/blog/tipos-de-vulnerabilidades-en-ciberseguridad/)

[

](https://www.incibe.es/aprendeciberseguridad/vulnerabilidad)

[

](https://www.sentinelone.com/es/cybersecurity-101/cybersecurity/cyber-security-vulnerabilities/)

[Vulnerabilidad, seguridad informática](https://search.brave.com/search?q=Vulnerabilidad%2C%20seguridad%20inform%C3%A1tica)

Mostrar todo

3. **Recompensa**: La compensación económica (o a veces en forma de puntos, reconocimiento o _swag_) que recibe el investigador por un reporte válido. El pago está directamente relacionado con el impacto de la vulnerabilidad encontrada. 
    

[

](https://www.reddit.com/r/bugbounty/comments/109na0u/what_is_your_average_yearly_earnings_from_bug/?tl=pt-br)

[recompensas bug bounty](https://search.brave.com/search?q=recompensas%20bug%20bounty)

Mostrar todo

4. **Plataforma**: Servicios intermedios como HackerOne, Bugcrowd o Intigriti que gestionan los programas, los reportes y las recompensas entre la organización y los investigadores. 
    

[

](https://www.cloudsek.com/pt-br/knowledge-base/best-bug-bounty-platforms)

[

](https://geekflare.com/es/bug-bounty-platforms/)

[

](https://osint.com.ar/top-25-plataformas-de-bug-bounty/)

[

](https://www.reddit.com/r/bugbounty/comments/1k3tj2d/nonwell_known_bug_bounty_platforms/?tl=pt-br)

[

](https://www.reddit.com/r/bugbounty/comments/1pjdbze/new_to_web_pentesting_best_beginnerfriendly_bug/?tl=pt-br)

[plataformas bug bounty comparativa](https://search.brave.com/search?q=plataformas%20bug%20bounty%20comparativa)

Mostrar todo

5. **Programa Público vs. Privado**:
    
    - **Público**: Cualquier investigador puede participar.
        
    - **Privado**: Se requiere una invitación, generalmente basada en reputación o desempeño previo. 
        

[como entrar a un programa bug bounty privado](https://search.brave.com/videos?q=como%20entrar%20a%20un%20programa%20bug%20bounty%20privado)

Mostrar todo

6. **Vulnerability Disclosure Program (VDP)**: Un programa que establece las pautas para que los investigadores reporten vulnerabilidades, pero **sin ofrecer recompensas monetarias**.  A menudo es un paso previo a un Bug Bounty completo.
    

[

](https://docs.hackerone.com/en/articles/8368965-vdp-vs-bbp)

[

](https://www.halborn.com/blog/post/vdp-vs-bug-bounty-which-should-you-choose)

[

](https://snyk.io/es/articles/ethical-hacking/vulnerability-disclosure-program-vdp-vs-bug-bounty-bb/)

[

](https://www.hackerone.com/blog/bug-bounty-vs-vdp-which-program-right-you)

[

](https://medium.com/@dzianisskliar29/bug-bounty-vs-vdp-building-effective-security-programs-with-hacker-collaboration-0a7db1b3f2df)

[VDP vs Bug Bounty](https://search.brave.com/search?q=VDP%20vs%20Bug%20Bounty)

Mostrar todo

7. **Reporte**: El documento que el investigador envía detallando la vulnerabilidad, con pasos para reproducirla, evidencia (capturas de pantalla, código) y su impacto potencial. La claridad del reporte es crucial para su validación. 
    

[

](https://www.reddit.com/r/ciberseguridad/comments/1lmzood/empezar_en_el_mundo_del_bug_bounty_consejos_y_tips/)

[

](https://www.reddit.com/r/bugbounty/comments/1ivu1zv/reality_about_bug_bounty_my_view/?tl=es-419)

[

](https://www.reddit.com/r/bugbounty/comments/1i6kqeo/why_so_failure_in_bug_hunting/?tl=es-419)

[

](https://www.reddit.com/r/bugbounty/comments/1h08dz4/new_to_bug_bounty_need_advice_on_where_to_start/?tl=es-es)

[

](https://www.reddit.com/r/bugbounty/comments/17f82g9/how_to_start_bug_bounty_with_zero_money/)

[como escribir un buen reporte en bug bounty](https://search.brave.com/search?q=como%20escribir%20un%20buen%20reporte%20en%20bug%20bounty)

Mostrar todo
---
![[{4DEC383B-A086-4345-8569-AC47594BF62F}.png]]

```markdown
<%*
const vault = app.vault;

// === Crear carpetas principales (sin Personas y Redes) ===
await vault.createFolder("00 - Misión y Sistema").catch(() => {});
await vault.createFolder("01 - Proyectos").catch(() => {});
await vault.createFolder("02 - Áreas").catch(() => {});
await vault.createFolder("03 - Recursos").catch(() => {});
await vault.createFolder("04 - Ideas y Backlog").catch(() => {});
await vault.createFolder("05 - Daily Notes").catch(() => {});
await vault.createFolder("Inbox").catch(() => {});

// Subcarpetas útiles
await vault.createFolder("01 - Proyectos/Rastro (Bug Bounty Dashboard)").catch(() => {});
await vault.createFolder("03 - Recursos/Herramientas").catch(() => {});
await vault.createFolder("03 - Recursos/Prompts Maestros").catch(() => {});
await vault.createFolder("02 - Áreas/Bug Bounty").catch(() => {});
await vault.createFolder("02 - Áreas/Cripto y DeFi").catch(() => {});
await vault.createFolder("02 - Áreas/IA y Automatización").catch(() => {});

// === Crear archivos base ===
const files = [
    {
        path: "00 - Misión y Sistema/Misión Principal.md",
        content: `# Misión Principal

Construir independencia financiera mediante software, automatización, bug bounty, IA y activos digitales escalables con mínima intervención manual.

**Estado:** En ejecución`
    },
    {
        path: "00 - Misión y Sistema/Reglas de Priorización.md",
        content: `# Reglas de Priorización

- Terminar antes de empezar nuevos proyectos.
- Priorizar proyectos con mayor potencial de ingresos, automatización y escalabilidad.
- Favorecer software y sistemas que generen ventajas acumulativas.
- Evitar dispersión excesiva.
- Revisar y reordenar cada 15-30 días.`
    },
    {
        path: "00 - Misión y Sistema/Regla Especial.md",
        content: `# Regla Especial

Antes de iniciar cualquier proyecto nuevo evaluar:

- ¿Puede integrarse con **Rastro**?
- ¿Puede aprovechar IA?
- ¿Puede automatizarse?
- ¿Puede generar ingresos recurrentes?
- ¿Tiene barreras de entrada favorables?`
    },
    {
        path: "00 - Misión y Sistema/Revisión Periódica.md",
        content: `# Revisión Periódica

**Fecha:** {{date:YYYY-MM-DD}}
**Proyectos activos:**
**Ingresos generados este mes:**
**Qué se completó:**
**Próximas prioridades:**`
    }
];

for (let file of files) {
    await vault.create(file.path, file.content).catch(() => {});
}

tR += "**¡Listo!** Estructura completa creada sin la carpeta de Personas.\n\nRevisa las carpetas en el panel izquierdo.";
%>
```

````markdown
<%*
const titulo = await tp.user.prompt("Nombre del Proyecto");
tR += `---\n`;
%>

# <%* tR += titulo %>

**Estado**: En Progreso
**Prioridad**: Alta
**Fecha de creación**: <% tp.date.now("YYYY-MM-DD") %>
**Última revisión**: <% tp.date.now("YYYY-MM-DD") %>

**Objetivo principal**:
> 

**Potencial de ingresos estimado**:
**Nivel de automatización**: 

## KPIs del Proyecto
- Ingresos objetivo:
- Tiempo de ejecución manual actual:
- Tiempo objetivo automatizado:

## Próximos pasos (Tasks)
- [ ] 
- [ ] 
- [ ] 

## Integración con Rastro
- 

## Uso de IA
- 

## Notas relacionadas
- [[ ]]

**Tags**: #proyecto #activo 

---

**Notas diarias relacionadas**:
```dataview
TASK
WHERE contains(text, "[[<% titulo %>]]")
GROUP BY file.link
````