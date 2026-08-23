# Evidencias - Ejercicio 51

## Tema

UNIQUE

## Comandos ejecutados

```bash
sqlite3 ejercicio-51.db < ddl/schema.sql
sqlite3 ejercicio-51.db < dml/inserts.sql
sqlite3 ejercicio-51.db < dql/consultas.sql
```

## Resultados

**5.a Citas por medico** (`id_medico` se repite sin problema; lo unico que no puede repetirse es la combinacion con `fecha_hora`):

```text
id_medico | cantidad_citas
1         | 3
2         | 2
3         | 2
4         | 2
5         | 1
```

**5.b Combinaciones (id_medico, fecha_hora) repetidas — 0 filas, confirmando que el UNIQUE compuesto se cumple en todos los datos cargados:**

```text
id_medico | fecha_hora | veces
(sin resultados)
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO citas (...) VALUES (3, 1, '2026-08-05 08:00', ...);` (la Dra. Marta Solis ya tenia una cita a esa hora) → `UNIQUE constraint failed: citas.id_medico, citas.fecha_hora`.
- `INSERT INTO medicos (nombre, correo) VALUES (..., 'marta.solis@clinica.com');` (correo ya usado) → `UNIQUE constraint failed: medicos.correo`.

## Aprendizaje

Un `UNIQUE` compuesto resuelve un tipo de duplicado que un `UNIQUE` de una sola columna no puede: la doble reserva de un recurso (el medico) en un momento especifico (la hora), donde ni el recurso ni el momento son unicos por separado. Es el mismo principio que ya se vio con `PRIMARY KEY` compuesta en el ejercicio 44, aplicado ahora a `UNIQUE`: la unicidad puede exigirse sobre la combinacion de columnas, no solo sobre una columna aislada.
