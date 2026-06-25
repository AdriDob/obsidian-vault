**IDOR** son las siglas de **Insecure Direct Object Reference** (Referencia Directa a Objetos Insegura).  Es una vulnerabilidad de seguridad que ocurre cuando una aplicación web permite a un usuario acceder directamente a recursos internos, como archivos, bases de datos o registros, utilizando identificadores que el usuario puede manipular. 

Esta falla se clasifica como un tipo de **control de acceso defectuoso** y está presente en el listado **OWASP Top 10** de riesgos de seguridad críticos.  Ocurre cuando el servidor no verifica adecuadamente si el usuario tiene permiso para acceder al objeto solicitado, permitiendo a un atacante alterar parámetros en la URL o en las solicitudes de API para ver, modificar o eliminar datos de otros usuarios.

### 1. IDOR (Referencia Directa de Objeto Insegura)

Es considerada una de las mejores vulnerabilidades para empezar porque no requiere conocimientos avanzados de explotación técnica, sino **lectura atenta de las peticiones HTTP**. 

- **Por qué es fácil:** Solo implica cambiar un identificador numérico o de texto en la URL o en el cuerpo de una petición (JSON) para acceder a datos de otro usuario (ej. cambiar `user_id=100` por `user_id=101`).
    
- **Por qué es cara:** Al comprometer la privacidad de los datos de los usuarios, se clasifica como una vulnerabilidad de **criticidad alta o media-alta**, ofreciendo recompensas significativas. 
    
- **Cómo encontrarla:** Usando **Burp Suite** o las **DevTools** del navegador, intercepta peticiones y observa parámetros de identificación.  Prueba modificarlos y observa si el servidor devuelve datos de otra cuenta.

### 1. Burp Suite Professional o Community

La herramienta principal. Funciona como un proxy entre tu navegador y el sitio web.

- **Professional:** Es de pago, pero tiene funciones avanzadas como **Autorize** y **AutoRepeater** que automatizan la comparación de permisos entre usuarios, ideal para IDOR.
    
- **Community:** Es gratuita. Puedes usarla con extensiones como **Paramalyzer** o **Param Miner** para encontrar parámetros sospechosos y modificarlos manualmente.

-

- **RCE (Remote Code Execution) a través de SSTI o Inyección**: Aunque su explotación puede ser compleja, encontrar vulnerabilidades como **SSTI (Server-Side Template Injection)** o fallos de validación en parámetros que llevan a ejecución de comandos puede ofrecer recompensas altas.  Requieren entender cómo se procesan las entradas en el backend.

-

