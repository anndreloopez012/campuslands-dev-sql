# Analisis del requerimiento - Ejercicio 068

## Solicitud entendida

Una escuela creativa de dibujo administra cursos, alumnos, entregas de
trabajos y sus evaluaciones. El cliente quiere poder consultar rankings,
totales y casos pendientes directamente desde la base de datos: por
ejemplo, que alumno tiene el mejor promedio, o cuantas entregas siguen
sin evaluar. Se necesita una base de datos que permita registrar
entregas, corregir su estado al evaluarlas, y responder esas preguntas
con reportes.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| profesores | Catalogo: imparte uno o mas cursos | nombre, especialidad |
| cursos | Catalogo: curso de dibujo impartido por un profesor | nombre (unico), nivel |
| alumnos | Catalogo: persona inscrita en la escuela | nombre, email (unico) |
| entregas | Tabla transaccional: un alumno entrega una obra para un curso | titulo_obra, fecha_entrega, estado |
| evaluaciones | Resultado de una entrega; se separa porque tiene su propia nota y comentario, y no toda entrega esta evaluada todavia | nota, comentario |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| profesores -> cursos | 1:N | Un profesor puede impartir varios cursos. |
| cursos -> entregas | 1:N | Un curso puede recibir muchas entregas de distintos alumnos. |
| alumnos -> entregas | 1:N | Un alumno puede hacer muchas entregas a lo largo del curso. |
| entregas -> evaluaciones | 1:1 | Cada entrega genera, a lo sumo, una evaluacion (`UNIQUE (id_entrega)`). |

## Reglas de negocio

- Regla 1: una entrega nace `'pendiente'` y solo puede avanzar a
  `'evaluada'` o `'rechazada'` (`CHECK`).
- Regla 2: el nivel de un curso debe ser uno de los reconocidos por la
  escuela (`CHECK (nivel IN ('principiante', 'intermedio', 'avanzado'))`).
- Regla 3: la nota de una evaluacion debe estar entre 0 y 100
  (`CHECK (nota BETWEEN 0 AND 100)`).
- Regla 4: el nombre de un curso y el correo de un alumno no se pueden
  repetir (`UNIQUE`).
- Regla 5: cada entrega tiene como maximo una evaluacion
  (`UNIQUE (id_entrega)` en `evaluaciones`).

## Supuestos

- El cliente no especifico si un alumno debe estar formalmente inscrito
  en un curso antes de entregar; se asume, para mantener el alcance de
  5 tablas, que la relacion `alumnos` - `cursos` se infiere a partir de
  las entregas registradas (no se modela una tabla de inscripciones
  aparte).
- No se detallo el criterio exacto de rechazo de una entrega; se asume
  que `'rechazada'` la decide el profesor al revisar la obra, sin
  generar una evaluacion con nota.
- Se asume que una entrega `'pendiente'` todavia no tiene fila en
  `evaluaciones`.

## Preguntas que responde la base de datos

1. Cuales son todas las entregas con su alumno y curso.
2. Que entregas estan pendientes, evaluadas o rechazadas.
3. Que alumno tiene mas actividad (ranking por numero de entregas).
4. Cuales son las entregas ordenadas por fecha, de la mas reciente a la
   mas antigua.
5. Que alumno tiene el mejor promedio de notas (reporte para decision
   de negocio: a quien destacar o becar).
