# Evidencias - Solicitudes SQL - Ejercicio 018 (Escuela de Dibujo)

## Comandos ejecutados

```bash
sqlite3 ejercicio-018.db < ddl/schema.sql
sqlite3 ejercicio-018.db < dml/inserts.sql
sqlite3 ejercicio-018.db < dml/operaciones.sql
sqlite3 ejercicio-018.db < dql/consultas.sql
```

## Resultados

**1. Todas las entregas (ya con la de prueba eliminada y la de Karen Solis evaluada):**

```text
id_entrega | id_curso | nombre_alumno   | fecha_entrega | calificacion | estado
1          | 1        | Ana Gomez         | 2026-07-01     | 85            | evaluada
2          | 2        | Luis Marroquin    | 2026-07-03     | 90            | evaluada
3          | 3        | Karen Solis       | 2026-07-05     | 82            | evaluada
4          | 1        | Diego Paz         | 2026-07-08     | 78            | evaluada
5          | 4        | Rosa Chavez       | 2026-07-10     | None          | rechazada
6          | 5        | Julio Perez       | 2026-07-12     | 95            | evaluada
7          | 1        | Ana Gomez         | 2026-07-15     | None          | pendiente
8          | 2        | Luis Marroquin    | 2026-07-18     | 88            | evaluada
```

Quedan 8 entregas (empezaron 9, se elimino la entrada de prueba del `id_entrega = 9`).

**2. Casos pendientes (tal como pidio el cliente):**

```text
id_entrega | id_curso | nombre_alumno | fecha_entrega
7          | 1        | Ana Gomez      | 2026-07-15
```

**3. Alumno con mas entregas:**

```text
nombre_alumno    | total_entregas
Luis Marroquin      | 2
Ana Gomez            | 2
Rosa Chavez          | 1
Karen Solis          | 1
Julio Perez          | 1
Diego Paz            | 1
```

**4. Entregas ordenadas por fecha:** ver tabla completa arriba, de 2026-07-01 a 2026-07-18.

**5. Totales: promedio de calificacion por curso (ranking, solo evaluadas):**

```text
nombre_curso            | nivel        | promedio_calificacion
Comic y Storyboard        | avanzado      | 95.0
Ilustracion Digital        | intermedio    | 89.0
Anime y Manga               | intermedio    | 82.0
Dibujo Basico                | principiante  | 81.5
```

`Retrato Realista` no aparece en el ranking porque su unica entrega esta `rechazada` (nunca se evaluo); el `WHERE e.estado = 'evaluada'` la excluye correctamente.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO entregas (id_curso, nombre_alumno, calificacion, estado) VALUES (2, 'Tomas Blanco', 150, 'evaluada');` → `CHECK constraint failed: calificacion BETWEEN 0 AND 100`.

## Operaciones de mantenimiento verificadas

- `UPDATE entregas SET estado = 'evaluada', calificacion = 82 WHERE id_entrega = 3 AND estado = 'pendiente';` → la entrega de Karen Solis paso de `pendiente` a `evaluada`, con su calificacion registrada.
- `UPDATE cursos SET precio = 270.00 WHERE id_curso = 3;` → el precio de Anime y Manga subio de 220.00 a 270.00.
- `DELETE FROM entregas WHERE id_entrega = 9;` → la entrada de prueba desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Las tres cosas que pidio el cliente ("rankings, totales y casos pendientes") salen de la misma tabla `entregas` con enfoques distintos: los casos pendientes son un simple `WHERE estado = 'pendiente'`, el ranking de cursos agrupa por curso y calcula el promedio (`AVG`) solo de las entregas `evaluada`, y ese mismo promedio ES el total que responde la pregunta de negocio. Dejar `calificacion` sin `NOT NULL` fue clave: una entrega `pendiente` o `rechazada` no tiene una nota real, y forzar un valor ahi habria contaminado el promedio del curso con datos falsos.
