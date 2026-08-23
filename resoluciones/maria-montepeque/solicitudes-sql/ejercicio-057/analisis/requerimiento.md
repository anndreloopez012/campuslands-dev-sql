# Analisis del requerimiento - Ejercicio 057

## Solicitud entendida

Una academia gestiona alumnos, planes, entrenadores y asistencias. El cliente pide que el sistema permita corregir estados sin borrar informacion importante: si un alumno justifica una falta, o reactiva su membresia, eso se hace con `UPDATE`, no borrando el historial. Es nivel 3: se pide `DELETE` controlado.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| planes | Es el catalogo de planes de membresia. | nombre_plan (unico), precio_mensual, clases_por_semana |
| entrenadores | Es el catalogo de entrenadores de la academia. | nombre_entrenador (unico), especialidad |
| alumnos | Es el catalogo de alumnos, cada uno con su plan. | nombre_alumno (unico), id_plan (FK), fecha_inscripcion, estado |
| asistencias | Es el registro transaccional de cada clase: que alumno, con que entrenador, cuando y si asistio. Aqui es donde la academia corrige informacion sin borrarla. | id_alumno (FK), id_entrenador (FK), fecha_clase, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| planes -> alumnos | 1:N | Un plan puede tener muchos alumnos inscritos. |
| alumnos -> asistencias | 1:N | Un alumno tiene muchos registros de asistencia. |
| entrenadores -> asistencias | 1:N | Un entrenador da clase a muchos alumnos. |

## Reglas de negocio

- Regla 1: Todo alumno debe apuntar a un plan real; toda asistencia debe apuntar a un alumno real y a un entrenador real (`FOREIGN KEY` en cadena).
- Regla 2: `precio_mensual`, `clases_por_semana`, `especialidad` y `fecha_inscripcion` son `NOT NULL`.
- Regla 3: `precio_mensual` y `clases_por_semana` siempre deben ser mayores a cero (`CHECK`).
- Regla 4: `nombre_plan`, `nombre_entrenador` y `nombre_alumno` no se repiten (`UNIQUE`).
- Regla 5: Un alumno puede estar `activo`, `suspendido` o `inactivo`, y una asistencia puede estar `presente`, `ausente` o `justificada` (`CHECK`); ambos se corrigen con `UPDATE`, nunca borrando el historial.
- Regla 6: Solo se permite `DELETE` de una asistencia cuando esta `ausente` **y** el alumno correspondiente ya esta `inactivo` (dado de baja). Una inasistencia de un ex-alumno ya no aporta al reporte de asistencia activo; una asistencia de un alumno `activo` o `suspendido` nunca se borra.

## Supuestos

- Justificar una falta se resuelve cambiando el `estado` de la asistencia de `ausente` a `justificada` (`UPDATE`), no creando una fila nueva ni borrando la original: asi el historial completo de esa clase queda intacto.

## Preguntas que responde la base de datos

1. Que asistencias existen, con que alumno y que entrenador.
2. Que asistencias no estan marcadas como presente todavia.
3. Que alumno tiene mas asistencias registradas.
4. Como se ordenan las asistencias por fecha.
5. Que porcentaje de asistencia tiene cada alumno, para decidir a quien contactar por riesgo de desercion.
