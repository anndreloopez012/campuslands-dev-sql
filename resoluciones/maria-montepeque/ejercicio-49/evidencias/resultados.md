# Evidencias - Ejercicio 49

## Tema

FOREIGN KEY

## Comandos ejecutados

```bash
sqlite3 ejercicio-49.db < ddl/schema.sql
sqlite3 ejercicio-49.db < dml/inserts.sql
sqlite3 ejercicio-49.db < dql/consultas.sql
```

## Resultados

**4. Resumen general (tras el SET NULL ya ejecutado en el DML):**

```text
total_citas | citas_sin_medico_asignado
10          | 3
```

**5.a Citas por paciente (RESTRICT protege el historial completo):**

```text
paciente          | cantidad_citas
Tomas Blanco       | 2
Rosa Mendez        | 2
Julio Perez        | 2
Jorge Alvarado     | 2
Ivonne Castro      | 2
```

**5.b Citas que quedaron sin medico asignado tras el SET NULL:**

```text
id_cita | id_paciente | fecha_cita  | estado
4       | 4           | 2026-08-05  | programada
7       | 2           | 2026-08-06  | atendida
8       | 3           | 2026-08-06  | programada
```

**Reporte final: citas por medico (con COALESCE para las citas sin medico):**

```text
medico                  | cantidad_citas
Medico no disponible     | 3
Dra. Marta Solis         | 2
Dra. Carla Nunez         | 2
Dr. Ernesto Diaz         | 2
Dra. Silvia Ortiz        | 1
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `DELETE FROM pacientes WHERE id_paciente = 1;` (Jorge Alvarado, con citas registradas) → `FOREIGN KEY constraint failed`.
- `INSERT INTO citas (id_paciente, ...) VALUES (999, ...);` (paciente inexistente) → `FOREIGN KEY constraint failed`.

## Aprendizaje

Este ejercicio cierra la serie de FOREIGN KEY mostrando las tres formas en que SQLite puede resolver el borrado de una fila referenciada: impedirlo (`RESTRICT`), propagarlo (`CASCADE`) o desvincularlo sin perder la fila dependiente (`SET NULL`). Ninguna es "la correcta" de forma general — la eleccion depende de si el dato dependiente sigue teniendo valor de negocio cuando su referencia desaparece. En este caso, el historial clinico de un paciente es demasiado importante para perderlo o desvincularlo (`RESTRICT`), pero la cita en si sigue siendo valida como registro aunque el medico especifico ya no este disponible (`SET NULL`).
