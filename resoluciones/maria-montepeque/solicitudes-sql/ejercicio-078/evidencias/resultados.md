# Evidencias - Solicitudes SQL - Ejercicio 078 (Torneo Esports)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-078.db < ddl/schema.sql
sqlite3 ejercicio-078.db < dml/inserts.sql
sqlite3 ejercicio-078.db < dml/operaciones.sql
sqlite3 ejercicio-078.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 equipos, 9 jugadores, 4 partidas
(3 marcadas `jugada` en algun momento, 1 `programada`), 14 filas de
estadisticas (incluye 2 cargadas por error para la partida que se
debia cancelar) y el ranking inicial en 0.

**Caso comentado verificado:**

- `INSERT INTO estadisticas (id_partida, id_jugador, ...) VALUES (1, 1, ...);` (repetir a TitanBlaze en la partida 1) → `UNIQUE constraint failed: estadisticas.id_partida, estadisticas.id_jugador`.

**2. Partidas por estado (la partida 3 ya aparece `cancelada`, y la
partida 4 sigue `programada` — el caso pendiente que pidio el
cliente):**

```text
id_partida | fecha_partida   | estado
3           | 2026-08-05        | cancelada
1           | 2026-08-01        | jugada
2           | 2026-08-03        | jugada
4           | 2026-08-08        | programada
```

**4. Ranking final:**

```text
nombre_equipo      puntos_totales
Fenix Digital         36
Lobos Binarios        30
Titanes Cyber          24
```

**5. Equipos con al menos 30 puntos (candidatos a la siguiente fase):**

```text
nombre_equipo      puntos_calculados
Fenix Digital         36
Lobos Binarios        30
```

## Operaciones de mantenimiento verificadas

- `UPDATE partidas SET estado = 'cancelada' WHERE id_partida = 3 ...;` → la partida del 2026-08-05 se anulo despues de confirmarse la falla del servidor.
- **DELETE controlado (multiple)**: se eliminaron las 2 estadisticas que habian quedado huerfanas de la partida 3. Total de estadisticas: 14 -> 12. Ninguna estadistica de una partida `jugada` se toco.
- **UPDATE de recalculo del ranking**: los 3 equipos pasaron de `puntos_totales = 0` a los valores reales, calculados solo con las partidas `jugada` (1 y 2); la partida cancelada no aporto puntos porque sus estadisticas ya no existian cuando se ejecuto este `UPDATE`.

## Aprendizaje

El `UNIQUE (id_partida, id_jugador)` en `estadisticas` evita cargar al
mismo jugador dos veces en la misma partida. El `DELETE` controlado
(multiple, con una subconsulta sobre `estado = 'cancelada'`) limpia de
un solo golpe todas las estadisticas huerfanas sin arriesgar ninguna
partida `jugada`. El ranking, guardado como su propia tabla tal como
pidio el cliente, se mantiene siempre consistente porque su `UPDATE`
de recalculo solo cuenta partidas reales: la consulta 2 muestra
exactamente los "casos pendientes" (partidas `programada`) que el
cliente queria poder consultar directamente.
