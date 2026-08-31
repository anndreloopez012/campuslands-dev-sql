# Evidencias - Ejercicio 90

## Tema

GROUP BY

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-90.db < ddl/schema.sql
sqlite3 ejercicio-90.db < dml/inserts.sql
sqlite3 ejercicio-90.db < dql/consultas.sql
```

## Resultados

**4. Total de partidas por equipo:**

```text
id_equipo   total_partidas
1             3
2             2
3             2
```

**5. Equipos con promedio de puntaje mayor a 70:**

```text
nombre_equipo         total_partidas   puntaje_total   promedio_puntaje
Dragones Digitales         3                235              78.33
```

Verificacion manual: Halcones Nocturnos (equipo 2) tiene 2 partidas
de 70+55=125 puntos, promedio 62.5; Fenix Cibernetico (equipo 3) tiene
40+65=105 puntos, promedio 52.5. Ambos por debajo del umbral de 70 y
por eso no aparecen en el resultado.

**Caso comentado verificado (CHECK):**

- `INSERT INTO partidas (..., puntaje, ...) VALUES (1, '2026-08-16', -10, 'derrota');` → `CHECK constraint failed: puntaje >= 0`.

**Caso comentado verificado (GROUP BY no recomendable):**

```text
nombre_equipo         nombre_jugador          COUNT(*)
Dragones Digitales     Alejandra Chinchilla       6
Halcones Nocturnos     Byron Xicay                2
Fenix Cibernetico      Cristina Barrios           2
```

Para "Dragones Digitales" el `COUNT(*)` deberia ser 3 (su numero real
de partidas), pero da 6 porque el `JOIN` con `jugadores` duplica cada
partida por cada uno de sus 2 jugadores antes de que `GROUP BY` los
agrupe; y el nombre de jugador mostrado ("Alejandra Chinchilla") es
arbitrario, no representa a todo el equipo.

## Aprendizaje

`GROUP BY` agrupa las filas que comparten el mismo valor en la
columna indicada, y las funciones de agregacion (`COUNT`, `SUM`,
`AVG`) calculan un resultado por cada grupo, no por cada fila
individual. `HAVING` filtra esos grupos ya formados (por ejemplo,
solo los equipos con promedio mayor a 70 puntos). Ademas, cualquier
columna que aparezca en el `SELECT` sin estar dentro de una funcion de
agregacion debe estar tambien en el `GROUP BY`; si no lo esta (como
`j.nombre_jugador` en el caso comentado), SQLite no lanza error pero
el valor mostrado es arbitrario y, si ademas el `JOIN` introduce
filas de mas (un equipo con varios jugadores), tambien distorsiona
los conteos y sumas del grupo.
