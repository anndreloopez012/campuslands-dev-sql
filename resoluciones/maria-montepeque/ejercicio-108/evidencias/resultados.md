# Evidencias - Ejercicio 108

## Tema

Indices

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-108.db < ddl/schema.sql
sqlite3 ejercicio-108.db < dml/inserts.sql
sqlite3 ejercicio-108.db < dql/consultas.sql
```

## Resultados

**4. Total de partidas por equipo:**

```text
id_equipo   total_partidas
1             4
2             3
3             3
```

**5. Plan de ejecucion filtrando por id_equipo Y fecha_partida (EXPLAIN QUERY PLAN):**

```text
id   parent   notused   detail
3      0         61       SEARCH partidas USING INDEX idx_partidas_equipo_fecha (id_equipo=? AND fecha_partida=?)
```

El plan confirma que SQLite uso `idx_partidas_equipo_fecha` para
buscar directamente la partida de `id_equipo = 1` en
`fecha_partida = '2026-08-10'`, en vez de revisar las 10 filas de la
tabla.

**Caso comentado verificado (CHECK):**

- `INSERT INTO partidas (..., puntaje, ...) VALUES (1, -10, '2026-08-18', 'derrota');` → `CHECK constraint failed: puntaje >= 0`.

**Caso comentado verificado (filtrar solo por la columna derecha del indice compuesto):**

```text
EXPLAIN QUERY PLAN
SELECT id_partida, id_equipo, resultado
FROM partidas
WHERE fecha_partida = '2026-08-13';
```

```text
id   parent   notused   detail
2      0         216       SCAN partidas
```

A diferencia de la consulta 5, aqui el plan dice `SCAN partidas`, no
`SEARCH ... USING INDEX idx_partidas_equipo_fecha`, aunque
`fecha_partida` es parte del mismo indice: al no incluir `id_equipo`
(la columna izquierda del indice) en el filtro, SQLite no puede
aprovechar el orden del indice y revisa la tabla completa.

## Aprendizaje

Un indice compuesto (sobre varias columnas) ordena los datos primero
por su primera columna, despues por la segunda, y asi sucesivamente;
por eso solo sirve para acelerar busquedas que filtran por esa primera
columna (sola, o junto con las siguientes en el mismo orden). Filtrar
solo por una columna que NO es la primera del indice (como
`fecha_partida` en `idx_partidas_equipo_fecha (id_equipo,
fecha_partida)`) no aprovecha el indice en absoluto, aunque esa
columna forme parte de el: SQLite vuelve a un `SCAN` completo de la
tabla, exactamente igual que si el indice no existiera. Por eso el
orden de las columnas al crear un indice compuesto debe elegirse
segun cual es el filtro mas frecuente en las consultas reales, no de
forma arbitraria.
