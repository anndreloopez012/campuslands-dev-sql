# Evidencias - Ejercicio 71

## Tema

INSERT

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-71.db < ddl/schema.sql
sqlite3 ejercicio-71.db < dml/inserts.sql
sqlite3 ejercicio-71.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 medicos, 4 pacientes, 4 citas.

**Casos comentados verificados** (descomentados y ejecutados por
separado para confirmar que cada uno falla):

- `INSERT INTO medicos (nombre_medico, ...) VALUES ('Dra. Sofia Ramirez', ...);` → `UNIQUE constraint failed: medicos.nombre_medico`.
- `INSERT INTO citas (id_paciente, id_medico, ...) VALUES (1, 99, ...);` → `FOREIGN KEY constraint failed`.
- `INSERT INTO citas (..., estado) VALUES (..., 'reagendada');` → `CHECK constraint failed: estado IN ('programada', 'atendida', 'cancelada')`.

**1. Todas las citas, con JOIN a pacientes y medicos:**

```text
id_cita | nombre_paciente        | nombre_medico        | fecha_cita         | estado
1        | Manuel Estrada           | Dra. Sofia Ramirez     | 2026-08-01 09:00     | atendida
2        | Alejandra Chinchilla     | Dr. Carlos Perez       | 2026-08-01 10:30     | atendida
3        | Byron Xicay              | Dra. Sofia Ramirez     | 2026-08-02 08:00     | programada
4        | Cristina Barrios         | Dra. Marta Lopez       | 2026-08-03 11:00     | programada
```

**2. Citas ya atendidas:**

```text
id_cita | fecha_cita
1        | 2026-08-01 09:00
2        | 2026-08-01 10:30
```

**3. Citas ordenadas por fecha:** ver tabla completa arriba, de
2026-08-01 a 2026-08-03.

**4. Resumen: citas por estado:**

```text
estado         total
atendida        2
programada      2
```

**5. Validacion especifica de INSERT: citas 3 y 4, insertadas SIN
indicar estado:**

```text
id_cita | fecha_cita         | estado
3        | 2026-08-02 08:00     | programada
4        | 2026-08-03 11:00     | programada
```

Ambas quedaron completas con `estado = 'programada'` gracias al
`DEFAULT`, sin que el `INSERT` tuviera que escribir esa columna.

## Aprendizaje

`INSERT` no siempre necesita escribir todas las columnas de la tabla:
alcanza con las que no tienen `DEFAULT` ni permiten `NULL` (aqui,
`id_paciente`, `id_medico` y `fecha_cita`). Ademas, una sola sentencia
`INSERT ... VALUES` puede cargar varias filas a la vez (como los 3
medicos o los 4 pacientes de este ejercicio), lo que evita repetir la
sentencia completa fila por fila. Las restricciones de la tabla
(`UNIQUE`, `FOREIGN KEY`, `CHECK`) actuan justo en el momento del
`INSERT`: si el dato no cumple la regla, la fila nunca llega a
guardarse, como se confirmo con los tres casos comentados.
