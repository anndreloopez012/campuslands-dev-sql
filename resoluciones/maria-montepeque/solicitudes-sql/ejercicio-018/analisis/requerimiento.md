# Analisis del requerimiento - Ejercicio 018

## Solicitud entendida

Una escuela creativa administra cursos, alumnos, entregas y evaluaciones. El cliente pidio explicitamente poder consultar rankings (que curso califica mejor), totales (promedio de calificacion por curso) y casos pendientes (entregas que todavia no se evaluan) directamente desde la base de datos.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| cursos | Es el catalogo de cursos que ofrece la escuela, cada uno con su nivel y precio. | nombre_curso (unico), nivel, precio |
| entregas | Es el registro transaccional de cada trabajo entregado por un alumno: en que curso, cuando, que calificacion obtuvo y en que estado va (pendiente, evaluada, rechazada). Aqui viven directamente los rankings, totales y pendientes que pidio el cliente. | id_curso (FK), nombre_alumno, fecha_entrega, calificacion, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| cursos -> entregas | 1:N | Un curso recibe muchas entregas de distintos alumnos, pero cada entrega pertenece a un unico curso. |

## Reglas de negocio

- Regla 1: Toda entrega debe apuntar a un curso real del catalogo (`FOREIGN KEY`).
- Regla 2: `precio` siempre debe ser mayor a cero (`CHECK`), y `calificacion`, cuando existe, debe estar entre 0 y 100 (`CHECK`).
- Regla 3: Una entrega puede estar `pendiente`, `evaluada` o `rechazada` (`CHECK`); esto es exactamente lo que permite responder "casos pendientes" con una simple consulta filtrada.
- Regla 4: `calificacion` se deja sin `NOT NULL` a proposito: una entrega `pendiente` o `rechazada` todavia no tiene o no necesita una nota.
- Regla 5: El nombre del curso no se repite (`UNIQUE`).

## Supuestos

- No se creo una tabla `alumnos` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del alumno se guarda dentro de `entregas`.
- El "ranking" que pide el cliente se interpreta como el promedio de calificacion por curso (solo entregas `evaluada`), y los "totales" como esa misma agregacion (`AVG`).
- Una entrega `rechazada` (por ejemplo, un trabajo incompleto) no cuenta en el promedio del curso, porque no representa una calificacion real.

## Preguntas que responde la base de datos

1. Que entregas existen y en que estado quedo cada una.
2. Que entregas estan pendientes (casos pendientes, tal como pidio el cliente).
3. Que alumno tiene mas entregas.
4. Como se ordenan las entregas por fecha.
5. Totales: cual es el promedio de calificacion por curso (ranking de cursos), para decidir cuales reforzar.
