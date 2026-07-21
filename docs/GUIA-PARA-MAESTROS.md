# Guia para maestros

Esta guia estandariza la revision de entregas en los repos de Campuslands. El objetivo es que todos los maestros revisen con el mismo criterio, protejan las ramas principales y den feedback claro al estudiante.

## Principios de revision

- La revision debe ayudar al estudiante a mejorar, no solo aprobar o rechazar.
- La estructura del repositorio se respeta siempre.
- `main` representa material estable del curso.
- `dev` recibe entregas aceptadas y trabajo academico revisado.
- Cada estudiante trabaja en su propia rama.
- Cada entrega vive dentro de `resoluciones/nombre-apellido/`.
- No se aceptan entregas que modifiquen archivos base, respuestas de otros estudiantes o configuracion global sin autorizacion.

## Como revisar Pull Requests

1. Verifica la rama base.
   - Correcto: PR hacia `dev`.
   - Incorrecto: PR hacia `main`.

2. Verifica la rama del estudiante.
   - Correcto: rama personal, por ejemplo `alumno/juan-perez/ejercicio-01`.
   - Incorrecto: `main`, `dev`, `respuestas` o ramas genericas sin nombre del estudiante.

3. Revisa la ubicacion de archivos.
   - Correcto: `nivel/ejercicio/resoluciones/nombre-apellido/...`.
   - Incorrecto: archivos en la raiz, fuera del ejercicio, en carpetas de otro estudiante o modificando plantillas.

4. Revisa el contenido.
   - Que el ejercicio responda al enunciado.
   - Que el codigo o respuesta sea entendible.
   - Que no sea una copia sin criterio.
   - Que incluya pruebas o ejemplos cuando el ejercicio lo permita.

5. Revisa Git.
   - Commits con mensajes claros.
   - PR enfocado en un ejercicio o bloque definido.
   - Sin archivos generados innecesarios.

## Cuando rechazar un PR

Rechaza o solicita cambios cuando ocurra cualquiera de estos casos:

- El PR apunta a `main`.
- La entrega esta fuera de `resoluciones/nombre-apellido/`.
- El estudiante modifico archivos base del ejercicio.
- El estudiante modifico respuestas de otro companero.
- Se subieron carpetas generadas como `node_modules/`, `vendor/`, builds, caches o archivos temporales.
- Se subio un `.env` o algun archivo con claves, tokens o datos privados.
- El ejercicio no corresponde al enunciado.
- El codigo no ejecuta por errores basicos y el estudiante no explica el problema.
- El PR mezcla demasiados ejercicios sin orden ni explicacion.

## Como comentar feedback

Un buen comentario debe ser claro, especifico y accionable.

Formato recomendado:

```markdown
## Revision

Estado: aprobado / solicitar cambios / rechazado por estructura

Observaciones:
- Punto concreto 1.
- Punto concreto 2.

Para mejorar:
- Recomendacion accionable.

Siguiente paso:
- Corrige y vuelve a empujar la misma rama, o abre un nuevo PR hacia dev.
```

Ejemplo de feedback aprobado:

```markdown
## Revision aceptada

La entrega cumple la estructura requerida y responde al objetivo del ejercicio.

Buen trabajo separando tu solucion dentro de `resoluciones/maria-lopez/`. La logica principal esta clara y los nombres ayudan a entender el flujo.

Para mejorar en la siguiente entrega, agrega un caso de prueba con datos invalidos.
```

Ejemplo de rechazo por estructura:

```markdown
## PR rechazado por estructura

No se puede aceptar este PR porque la entrega esta fuera de `resoluciones/nombre-apellido/`.

Mueve tus archivos a la carpeta del ejercicio correspondiente, por ejemplo:
`basico/ejercicio-001/resoluciones/juan-perez/`.

Luego abre un nuevo PR hacia `dev`.
```

## Como hacer merge

Solo haz merge cuando se cumpla todo esto:

- El PR apunta a `dev`.
- El bot de estructura esta aprobado o el maestro verifico manualmente la estructura.
- No hay conflictos.
- La entrega no modifica archivos prohibidos.
- El feedback necesario ya fue respondido.

Flujo recomendado:

1. Revisar archivos cambiados.
2. Comentar feedback.
3. Aprobar el PR si corresponde.
4. Hacer merge hacia `dev`.
5. Evitar squash si se quiere conservar historial del estudiante; usar merge normal cuando el flujo del repo lo permita.

## Como manejar conflictos

Si un PR tiene conflictos:

1. No hagas merge forzado.
2. Comenta al estudiante que debe actualizar su rama desde `dev`.
3. Indica el flujo recomendado:

```bash
git checkout dev
git pull origin dev
git checkout alumno/nombre-apellido/ejercicio-XX
git merge dev
# resolver conflictos
git add .
git commit -m "fix: resolve merge conflicts"
git push
```

4. Si el conflicto fue causado por tocar archivos base o archivos de otro estudiante, rechaza el PR y explica el motivo.
5. Si el conflicto es simple y el maestro decide resolverlo, debe dejar comentario explicando que se resolvio y por que.

## Como usar la rama respuestas

La rama `respuestas` contiene soluciones oficiales o material de consulta del profesor.

Reglas:

- Los estudiantes no trabajan en `respuestas`.
- No se abren PRs estudiantiles hacia `respuestas`.
- Las respuestas se publican despues de que el grupo haya intentado resolver los ejercicios.
- Las respuestas deben servir para comparar enfoque, no para reemplazar el aprendizaje.
- Si una respuesta oficial se corrige, el commit debe explicar el cambio.

Flujo recomendado para maestros:

```bash
git fetch origin
git checkout respuestas
git pull origin respuestas
# agregar o corregir respuestas oficiales
git add .
git commit -m "docs: add official solution for exercise XX"
git push origin respuestas
```

## Criterio final

Un PR aceptado debe demostrar tres cosas:

- El estudiante entendio el problema.
- La entrega respeta el orden del repositorio.
- El trabajo puede convivir con las entregas de los demas sin romper el curso.
