# Analisis del requerimiento - Ejercicio 043

## Solicitud entendida

Una escuela creativa administra cursos, alumnos, entregas y evaluaciones. El cliente quiere evitar registros incompletos porque despues no puede hacer reportes confiables. Es un ejercicio de nivel 3: ademas de corregir estados con `UPDATE`, se pide `DELETE` controlado con criterios de negocio reales.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| profesores | Es el catalogo de profesores de la escuela. | nombre_profesor (unico), especialidad |
| cursos | Es el catalogo de cursos, cada uno a cargo de un profesor. | nombre_curso (unico), id_profesor (FK), cupo_maximo |
| alumnos | Es el catalogo de alumnos inscritos. | nombre_alumno (unico), email (unico) |
| entregas | Es el registro transaccional de cada trabajo entregado: que alumno, en que curso, cuando, con que calificacion y en que estado va. Aqui es donde la escuela evalua y corrige estados. | id_alumno (FK), id_curso (FK), fecha_entrega, calificacion, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| profesores -> cursos | 1:N | Un profesor puede impartir varios cursos. |
| alumnos -> entregas | 1:N | Un alumno puede tener muchas entregas. |
| cursos -> entregas | 1:N | Un curso puede tener muchas entregas. |

## Reglas de negocio

- Regla 1: Todo curso debe apuntar a un profesor real; toda entrega debe apuntar a un alumno real y a un curso real (`FOREIGN KEY` en cadena).
- Regla 2: `especialidad`, `email` y `fecha_entrega` son `NOT NULL`: `fecha_entrega` en particular es el dato que, si faltara, dejaria un registro incompleto e inutilizable para un reporte (la queja central del cliente).
- Regla 3: `cupo_maximo` siempre debe ser mayor a cero (`CHECK`).
- Regla 4: `calificacion` solo se llena cuando la entrega ya se evaluo, y solo puede ser un numero entre `0` y `100` o quedar vacia (`CHECK`).
- Regla 5: `nombre_profesor`, `nombre_curso`, `nombre_alumno` y `email` no se repiten (`UNIQUE`).
- Regla 6: Una entrega puede estar `pendiente`, `entregada`, `evaluada` o `rechazada` (`CHECK`); la escuela corrige este estado con `UPDATE` a medida que avanza el curso.
- Regla 7: Solo se permite `DELETE` de una entrega cuando esta `pendiente` **y** corresponde a una inscripcion equivocada confirmada (mismo alumno, mismo curso incorrecto). Nunca se borra una entrega `entregada`, `evaluada` o `rechazada`, porque eso destruiria el historial que la escuela necesita para sus reportes.

## Supuestos

- El contexto menciona "evaluaciones", pero no se modelo como tabla aparte: se resolvio con las columnas `calificacion` y `estado` dentro de `entregas`, porque cada entrega tiene como maximo una evaluacion. El alcance de este nivel es 3 a 4 tablas.
- Una entrega `rechazada` conserva su fila (no se borra) porque tambien es informacion util para el reporte: cuenta como intento del alumno, aunque no tenga calificacion numerica.

## Preguntas que responde la base de datos

1. Que entregas existen, con que alumno, que curso y que profesor.
2. Que entregas no estan evaluadas todavia.
3. Que alumno tiene mas entregas registradas.
4. Como se ordenan las entregas por fecha.
5. Que curso tiene el promedio de calificacion mas bajo, para decidir cual necesita refuerzo pedagogico.
