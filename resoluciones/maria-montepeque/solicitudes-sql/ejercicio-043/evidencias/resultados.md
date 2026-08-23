# Evidencias - Solicitudes SQL - Ejercicio 043 (Escuela de Dibujo)

## Comandos ejecutados

```bash
sqlite3 ejercicio-043.db < ddl/schema.sql
sqlite3 ejercicio-043.db < dml/inserts.sql
sqlite3 ejercicio-043.db < dml/operaciones.sql
sqlite3 ejercicio-043.db < dql/consultas.sql
```

## Resultados

**1. Todas las entregas, con JOIN triple a alumnos, cursos y profesores (ya sin la duplicada, sin la inscripcion equivocada de Wendy, y con las entregas 3 y 6 evaluadas):**

```text
id_entrega | nombre_alumno    | nombre_curso                | nombre_profesor  | fecha_entrega | calificacion | estado
1          | Fernanda Ixcoy   | Retrato a Lapiz              | Andrea Solval     | 2026-08-01     | 85.0          | evaluada
2          | Brandon Us       | Manga Basico                 | Kevin Morataya    | 2026-08-02     | 92.0          | evaluada
3          | Wendy Choc       | Pintura Digital Avanzada     | Lucia Barrera     | 2026-08-03     | 90.0          | evaluada
4          | Fernanda Ixcoy   | Manga Basico                 | Kevin Morataya    | 2026-08-04     | 78.0          | evaluada
5          | Alan Ramirez     | Ilustracion para Ninos       | Oscar Xoc         | 2026-08-05     | 88.0          | evaluada
6          | Brandon Us       | Manga Intermedio             | Kevin Morataya    | 2026-08-06     | 91.0          | evaluada
7          | Michelle Poou    | Retrato a Lapiz              | Andrea Solval     | 2026-08-07     | 95.0          | evaluada
8          | Fernanda Ixcoy   | Ilustracion para Ninos       | Oscar Xoc         | 2026-08-08     | (vacio)       | rechazada
9          | Diego Sacbaja    | Pintura Digital Avanzada     | Lucia Barrera     | 2026-08-09     | (vacio)       | pendiente
```

Quedan 9 entregas (empezaron 11: se elimino la duplicada `id_entrega = 11` y la inscripcion equivocada `id_entrega = 10`).

**2. Entregas que no estan evaluadas todavia:**

```text
id_entrega | id_alumno | id_curso | fecha_entrega | estado
8          | 1         | 4        | 2026-08-08     | rechazada
9          | 6         | 3        | 2026-08-09     | pendiente
```

La entrega pendiente de Diego Sacbaja (id_entrega = 9) sigue intacta: el `DELETE` controlado nunca la toco porque no cumplia las tres condiciones a la vez.

**3. Alumno con mas entregas registradas:**

```text
nombre_alumno    | total_entregas
Fernanda Ixcoy   | 3
Brandon Us       | 2
Alan Ramirez     | 1
Diego Sacbaja    | 1
Michelle Poou    | 1
Wendy Choc       | 1
```

**4. Entregas ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-09.

**5. Curso con el promedio de calificacion mas bajo (solo entregas evaluadas), para decidir cual necesita refuerzo pedagogico primero:**

```text
nombre_curso               | promedio_calificacion
Manga Basico                | 85.0
Ilustracion para Ninos      | 88.0
Retrato a Lapiz              | 90.0
Pintura Digital Avanzada     | 90.0
Manga Intermedio             | 91.0
```

Manga Basico es el candidato claro para revisar contenido o metodologia: tiene el promedio mas bajo de todos los cursos evaluados.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO cursos (nombre_curso, ...) VALUES ('Manga Basico', ...);` → `UNIQUE constraint failed: cursos.nombre_curso`.
- Valor fuera de rango: `INSERT INTO entregas (..., calificacion, ...) VALUES (..., 150, ...);` → `CHECK constraint failed: calificacion IS NULL OR (calificacion BETWEEN 0 AND 100)`.

## Operaciones de mantenimiento verificadas

- `UPDATE entregas SET calificacion = 90.0, estado = 'evaluada' WHERE id_entrega = 3 AND estado = 'entregada';` → la entrega de Wendy Choc en Pintura Digital Avanzada quedo evaluada.
- `UPDATE entregas SET calificacion = 91.0, estado = 'evaluada' WHERE id_entrega = 6 AND estado = 'entregada';` → la entrega de Brandon Us en Manga Intermedio quedo evaluada.
- `DELETE FROM entregas WHERE id_alumno = 3 AND id_curso = 1 AND estado = 'pendiente';` → **DELETE controlado**: elimino unicamente la inscripcion equivocada de Wendy Choc en Retrato a Lapiz. Verificado que la entrega pendiente de Diego Sacbaja (otro alumno, tambien `pendiente`) no se toco, porque no cumplia las tres condiciones (alumno y curso distintos).
- `DELETE FROM entregas WHERE id_entrega = 11;` → la entrega duplicada desaparecio. Conteo final verificado: 9 entregas (empezaron 11).

## Aprendizaje

Hacer `fecha_entrega` `NOT NULL` resuelve directamente la queja del cliente sobre registros incompletos: ninguna entrega puede existir sin una fecha, asi que ningun reporte por fecha (consulta 4 y 5) puede quedar con huecos. El `DELETE` controlado con tres condiciones (`id_alumno`, `id_curso`, `estado`) demuestra que un borrado seguro no es "borrar por PK": es asegurarse de que la fila que se borra es exactamente el caso de error que se queria corregir, sin arriesgar ningun otro registro parecido.
