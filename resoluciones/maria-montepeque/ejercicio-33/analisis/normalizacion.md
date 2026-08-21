# Analisis de Normalizacion - Ejercicio 33

## Tabla original

Archivo `datos/datos-sin-normalizar.csv`:

```text
id_matricula,estudiante,documento,ruta,trainer,modulos,horarios,notas
1,Laura Cano,DPI-100,Node JS,Mario Paz,SQL|Express|JWT,08:00|10:00|12:00,88|91|85
2,Kevin Rios,DPI-101,Python,Ana Solis,SQL|FastAPI,14:00|16:00,90|87
3,Laura Cano,DPI-100,Node JS,Mario Paz,Docker|Deploy,15:00|17:00,92|89
```

Es una tabla plana donde cada fila mezcla el encabezado de una matricula (estudiante, documento, ruta, trainer) con el detalle de los modulos cursados, y `modulos`, `horarios` y `notas` guardan varios valores separados por `|` dentro de una sola celda (un grupo repetido por cada modulo).

## Problemas detectados

- **Grupos repetidos**: `modulos`, `horarios` y `notas` contienen listas de valores (uno por modulo) dentro de una misma celda en lugar de una fila por modulo.
- **Datos duplicados**: `estudiante`, `documento`, `ruta` y `trainer` de "Laura Cano" se repiten completos en las filas 1 y 3.
- **Fila de matricula duplicada como si fuera otra matricula**: las filas 1 y 3 no son dos matriculas distintas de Laura Cano; son la **misma** matricula (misma estudiante, misma ruta, mismo trainer) partida en dos filas porque el archivo plano no tiene forma de listar mas de un grupo de modulos por fila. Esto es en si mismo un problema de diseno: el archivo original sobre-representa la cantidad de matriculas.
- **Dependencias parciales**: si se usara como clave compuesta `(id_matricula, modulo)` para representar cada linea de modulo, datos como `estudiante`, `documento`, `ruta` y `trainer` dependerian solo de `id_matricula` (parte de la clave), no de la clave completa.
- **Dependencias transitivas**: `documento` depende de `estudiante` (cada estudiante tiene siempre el mismo documento), y `estudiante` depende de `id_matricula`; por lo tanto `documento` depende transitivamente de `id_matricula` a traves de `estudiante`. Lo mismo ocurriria si `ruta` y `trainer` tuvieran atributos propios (por ejemplo, un trainer siempre asociado a la misma sede).
- **Anomalias de insercion**: no se puede registrar un modulo nuevo en el catalogo (uno que todavia no se ha cursado) sin inventar una matricula ficticia, porque el modulo solo existe dentro de la lista `modulos` de alguna fila. Tampoco se puede registrar un estudiante que aun no se matricula en ninguna ruta.
- **Anomalias de actualizacion**: si el documento de "Laura Cano" cambia, hay que actualizarlo en las filas 1 y 3; si se olvida una, quedan datos inconsistentes para la misma estudiante.
- **Anomalias de eliminacion**: si se elimina la fila 2 (la unica matricula de Kevin Rios), se pierde tambien la referencia a la ruta "Python" y al trainer "Ana Solis", aunque en realidad ambos siguen existiendo como catalogo.

## Dependencias funcionales

```text
id_matricula -> estudiante, documento, ruta, trainer
estudiante -> documento
modulo -> (catalogo, sin atributos adicionales en este ejercicio)
(id_matricula, modulo) -> horario, nota
```

## Primera Forma Normal (1FN)

Se elimino el grupo repetido dividiendo cada matricula en una fila por cada modulo cursado (usando el separador `|` como guia). La clave paso a ser compuesta `(id_matricula, modulo)`, y cada celda quedo con un unico valor atomico (un modulo, un horario, una nota por fila). En este paso tambien se detecto que las filas 1 y 3 del CSV comparten la misma estudiante, ruta y trainer, por lo que representan una sola matricula con 5 modulos, no dos matriculas independientes.

## Segunda Forma Normal (2FN)

Con la clave compuesta `(id_matricula, modulo)`, los atributos `estudiante`, `documento`, `ruta` y `trainer` dependian solo de `id_matricula` (dependencia parcial). Se separaron en una tabla de encabezado:

- `matriculas` (estudiante, ruta y trainer de la matricula), con clave `id_matricula`.
- `notas` (modulo cursado, horario y nota dentro de esa matricula), con clave compuesta `(id_matricula, id_modulo)`.

## Tercera Forma Normal (3FN)

Dentro de `matriculas` seguia existiendo una dependencia transitiva: `documento` dependia de `estudiante` (no directamente de `id_matricula`), y `estudiante`, `ruta`, `trainer` y `modulo` eran texto libre repetido en cada fila en vez de referencias a catalogos propios. Se separaron en catalogos independientes:

- `estudiantes` (nombre, documento), referenciado desde `matriculas` por `id_estudiante`.
- `rutas` (nombre), referenciado desde `matriculas` por `id_ruta`.
- `trainers` (nombre), referenciado desde `matriculas` por `id_trainer`.
- `modulos` (nombre), referenciado desde `notas` por `id_modulo`.

Con esto, `matriculas` solo guarda referencias (`id_estudiante`, `id_ruta`, `id_trainer`) y `notas` solo guarda referencias (`id_matricula`, `id_modulo`) mas los datos que dependen unicamente de esa combinacion (`horario`, `nota`).

## Modelo final

| Tabla | Llave primaria | Llaves foraneas | Proposito |
| --- | --- | --- | --- |
| `estudiantes` | `id_estudiante` | - | Catalogo de estudiantes (nombre, documento unico). |
| `rutas` | `id_ruta` | - | Catalogo de rutas de formacion. |
| `trainers` | `id_trainer` | - | Catalogo de trainers. |
| `modulos` | `id_modulo` | - | Catalogo de modulos que se pueden cursar. |
| `matriculas` | `id_matricula` | `id_estudiante` -> `estudiantes`, `id_ruta` -> `rutas`, `id_trainer` -> `trainers` | Encabezado de la matricula: que estudiante cursa que ruta con que trainer. |
| `notas` | `id_nota` | `id_matricula` -> `matriculas`, `id_modulo` -> `modulos` | Detalle de cada modulo cursado dentro de una matricula (horario y nota obtenida). |

## Justificacion

El modelo final elimina los grupos repetidos (1FN) al dar una fila por cada modulo cursado en `notas`. Elimina las dependencias parciales (2FN) al sacar de la matricula todo lo que no depende de la matricula completa: el detalle de cada modulo (horario, nota) queda en `notas`. Elimina las dependencias transitivas (3FN) al separar `estudiantes`, `rutas`, `trainers` y `modulos` de `matriculas`, de modo que el documento del estudiante ya no depende indirectamente de `id_matricula`, sino directamente de `id_estudiante`.

Ademas, al normalizar se corrigio el problema mas visible del archivo original: las filas 1 y 3 (misma estudiante, misma ruta, mismo trainer) dejan de representarse como dos matriculas distintas y pasan a ser una sola matricula (`id_matricula = 1`) con sus 5 modulos como filas independientes en `notas`. Con esto: actualizar el documento de un estudiante requiere un solo `UPDATE`; se puede registrar un modulo o un estudiante nuevo sin necesidad de una matricula; y eliminar una matricula ya no borra la ruta ni el trainer asociados, porque existen de forma independiente en sus propias tablas. La restriccion `UNIQUE (id_estudiante, id_ruta)` en `matriculas` ademas impide que se repita en el futuro el mismo error del archivo original (partir una matricula en varias filas).
