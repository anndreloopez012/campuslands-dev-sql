# Evidencias - Solicitudes SQL - Ejercicio 057 (Academia Kickboxing)

## Comandos ejecutados

```bash
sqlite3 ejercicio-057.db < ddl/schema.sql
sqlite3 ejercicio-057.db < dml/inserts.sql
sqlite3 ejercicio-057.db < dml/operaciones.sql
sqlite3 ejercicio-057.db < dql/consultas.sql
```

## Resultados

**1. Todas las asistencias, con JOIN doble a alumnos y entrenadores (ya sin la duplicada, sin la inasistencia de Bryan Ical, y con la falta de Kevin justificada):**

```text
id_asistencia | nombre_alumno    | nombre_entrenador  | fecha_clase | estado
1               | Kevin Aju         | Coach Manuel Xoc    | 2026-08-01    | presente
2               | Paola Ramos       | Coach Deisy Pu      | 2026-08-01    | presente
3               | Fernanda Us       | Coach Fernando Ac   | 2026-08-02    | presente
4               | Kevin Aju         | Coach Manuel Xoc    | 2026-08-03    | justificada
5               | Ninoska Cux       | Coach Lorena Say    | 2026-08-03    | presente
6               | Paola Ramos       | Coach Deisy Pu      | 2026-08-04    | justificada
7               | Fernanda Us       | Coach Fernando Ac   | 2026-08-05    | presente
8               | Diego Chavajay    | Coach Manuel Xoc    | 2026-08-05    | ausente
10              | Kevin Aju         | Coach Manuel Xoc    | 2026-08-07    | presente
```

Quedan 9 asistencias (empezaron 11: se elimino la duplicada `id_asistencia = 11` y la inasistencia del alumno inactivo `id_asistencia = 9`).

**2. Asistencias que no estan marcadas como presente todavia:**

```text
id_asistencia | id_alumno | fecha_clase | estado
4               | 1          | 2026-08-03    | justificada
6               | 2          | 2026-08-04    | justificada
8               | 3          | 2026-08-05    | ausente
```

**3. Alumno con mas asistencias registradas:**

```text
nombre_alumno    | total_asistencias
Kevin Aju         | 3
Fernanda Us       | 2
Paola Ramos       | 2
Diego Chavajay    | 1
Ninoska Cux       | 1
```

**4. Asistencias ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-07.

**5. Porcentaje de asistencia por alumno, para decidir a quien contactar por riesgo de desercion:**

```text
nombre_alumno    | total_clases | ausencias | porcentaje_asistencia
Diego Chavajay    | 1             | 1          | 0.0
Kevin Aju         | 3             | 0          | 100.0
Paola Ramos       | 2             | 0          | 100.0
Fernanda Us       | 2             | 0          | 100.0
Ninoska Cux       | 1             | 0          | 100.0
```

Diego Chavajay es el candidato claro para contactar: su unica clase registrada quedo como ausencia, justo despues de reactivar su membresia.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO alumnos (nombre_alumno, ...) VALUES ('Kevin Aju', ...);` → `UNIQUE constraint failed: alumnos.nombre_alumno`.
- Valor fuera de rango: `INSERT INTO planes (..., precio_mensual, ...) VALUES (..., 0, ...);` → `CHECK constraint failed: precio_mensual > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE asistencias SET estado = 'justificada' WHERE id_asistencia = 4 AND estado = 'ausente';` → la falta de Kevin Aju se justifico, sin borrar el registro.
- `UPDATE alumnos SET estado = 'activo' WHERE id_alumno = 3 AND estado = 'suspendido';` → Diego Chavajay reactivo su membresia.
- `DELETE FROM asistencias WHERE id_asistencia = 9 AND estado = 'ausente' AND EXISTS (...);` → **DELETE controlado**: elimino unicamente la inasistencia de Bryan Ical, ya `inactivo`. La inasistencia de Diego Chavajay (id_asistencia = 8), alumno `activo`, no se toco.
- `DELETE FROM asistencias WHERE id_asistencia = 11;` → la asistencia duplicada desaparecio. Conteo final verificado: 9 asistencias (empezaron 11).

## Aprendizaje

La justificacion de Kevin Aju demuestra exactamente lo que pidio el cliente: se corrigio el estado (`ausente` -> `justificada`) sin crear una fila nueva ni borrar la original, asi que el historial completo de esa clase queda intacto. El `DELETE` controlado, en cambio, solo se activa cuando el alumno ya no es parte activa de la academia (`inactivo`): una inasistencia de un alumno `activo` o `suspendido` -como la de Diego- jamas se borra, porque todavia es informacion relevante para decisiones como el reporte de riesgo de desercion.
