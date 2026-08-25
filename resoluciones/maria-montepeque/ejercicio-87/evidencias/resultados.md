# Evidencias - Ejercicio 87

## Tema

ORDER BY

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-87.db < ddl/schema.sql
sqlite3 ejercicio-87.db < dml/inserts.sql
sqlite3 ejercicio-87.db < dql/consultas.sql
```

## Resultados

**Caso comentado verificado:**

- `SELECT estado, COUNT(*) FROM citas GROUP BY estado ORDER BY horacita;` → `no such column: horacita` (falta el guion bajo de `hora_cita`).

Nota: se probo primero un caso ordenando por una columna que no
aparece en el `SELECT` ni en el `GROUP BY` (`ORDER BY hora_cita` sobre
una consulta agrupada por `estado`), pero en SQLite eso **si es
valido** (a diferencia de otros motores mas estrictos): SQLite toma un
valor arbitrario de esa columna por cada grupo. Por eso se reemplazo
por el error de escritura real.

**5. Proximas 3 citas mas urgentes (orden por prioridad de negocio con
`CASE WHEN`, no alfabetico, y `LIMIT`):**

```text
id_cita | nombre_paciente   | fecha_cita     | hora_cita | estado
3         | Byron Xicay         | 2026-08-20        | 11:00        | programada
4         | Cristina Barrios    | 2026-08-20        | 14:00        | programada
6         | Manuel Estrada      | 2026-08-21        | 09:00        | programada
```

Las citas `'programada'` aparecen primero (prioridad 1 en el `CASE
WHEN`), aunque alfabeticamente "atendida" y "cancelada" vendrian antes
que "programada". Dentro de las programadas, se ordenan por fecha y
hora, y `LIMIT 3` deja solo las 3 mas cercanas.

## Aprendizaje

`ORDER BY` no esta limitado a ordenar por el valor literal de una
columna: un `CASE WHEN` dentro del `ORDER BY` permite definir un orden
de prioridad de negocio (programada antes que atendida antes que
cancelada) que no coincide con el orden alfabetico natural del texto.
Combinado con `LIMIT`, se puede quedar solo con los primeros
resultados de ese orden personalizado (las citas mas urgentes), sin
tener que traer toda la tabla y filtrar despues en el codigo de la
aplicacion. El caso comentado confirma que SQLite es mas permisivo que
otros motores al ordenar resultados agrupados por columnas fuera del
`GROUP BY`, pero sigue exigiendo que el nombre de la columna exista de
verdad.
