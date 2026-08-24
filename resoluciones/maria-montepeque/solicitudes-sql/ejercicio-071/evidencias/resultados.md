# Evidencias - Solicitudes SQL - Ejercicio 071 (Battle Royale Ranking)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-071.db < ddl/schema.sql
sqlite3 ejercicio-071.db < dml/inserts.sql
sqlite3 ejercicio-071.db < dml/operaciones.sql
sqlite3 ejercicio-071.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 5 jugadores, 1 temporada, 5
partidas (3 jugadas, 1 programada, 1 jugada-por-error que se corrige
despues), 16 filas de estadisticas y 5 filas de ranking en 0.

**Caso comentado verificado** (el problema central del cliente):

- `INSERT INTO estadisticas (id_partida, id_jugador, ...) VALUES (1, 1, ...);` (repetir a ShadowKill en la partida 1) → `UNIQUE constraint failed: estadisticas.id_partida, estadisticas.id_jugador`.

**1. Todas las estadisticas, con JOIN a jugador y partida (14 filas
tras el DELETE de la partida cancelada):**

```text
id_estadistica | nickname     | mapa              | fecha_partida   | kills | posicion_final
1                | ShadowKill    | Isla Tormenta      | 2026-08-01        | 5      | 1
2                | NightFury     | Isla Tormenta      | 2026-08-01        | 3      | 2
3                | QuickScope    | Isla Tormenta      | 2026-08-01        | 1      | 4
4                | IronWolf      | Isla Tormenta      | 2026-08-01        | 0      | 8
5                | PixelQueen    | Isla Tormenta      | 2026-08-01        | 2      | 3
6                | ShadowKill    | Desierto Rojo      | 2026-08-03        | 2      | 3
7                | NightFury     | Desierto Rojo      | 2026-08-03        | 6      | 1
8                | QuickScope    | Desierto Rojo      | 2026-08-03        | 4      | 2
9                | IronWolf      | Desierto Rojo      | 2026-08-03        | 1      | 6
10               | ShadowKill    | Bosque Nocturno    | 2026-08-05        | 1      | 5
11               | NightFury     | Bosque Nocturno    | 2026-08-05        | 2      | 4
12               | QuickScope    | Bosque Nocturno    | 2026-08-05        | 7      | 1
13               | IronWolf      | Bosque Nocturno    | 2026-08-05        | 3      | 2
14               | PixelQueen    | Bosque Nocturno    | 2026-08-05        | 0      | 10
```

**2. Partidas por estado:**

```text
id_partida | mapa              | fecha_partida   | estado
5           | Desierto Rojo      | 2026-08-02        | cancelada
1           | Isla Tormenta      | 2026-08-01        | jugada
2           | Desierto Rojo      | 2026-08-03        | jugada
3           | Bosque Nocturno    | 2026-08-05        | jugada
4           | Isla Tormenta      | 2026-08-08        | programada
```

**3. Jugador con mas partidas jugadas:**

```text
nickname     | total_partidas
IronWolf       | 3
NightFury      | 3
QuickScope     | 3
ShadowKill     | 3
PixelQueen     | 2
```

**4. Ranking final de la temporada:**

```text
nickname     | puntos_totales
QuickScope     | 32
NightFury      | 31
ShadowKill     | 28
IronWolf       | 9
PixelQueen     | 7
```

**5. Jugadores con mas kills acumulados (candidatos a MVP, minimo 8
kills):**

```text
nickname     | kills_totales
QuickScope     | 12
NightFury      | 11
ShadowKill     | 8
```

## Operaciones de mantenimiento verificadas

- `UPDATE partidas SET estado = 'cancelada' WHERE id_partida = 5 ...;` → la partida de Desierto Rojo del 2026-08-02 se anulo despues de la caida del servidor.
- **DELETE controlado**: se eliminaron las 2 estadisticas huerfanas de la partida 5 apenas quedo `cancelada`. Total de estadisticas: 16 -> 14. Ninguna estadistica de una partida `jugada` se toco.
- **UPDATE de recalculo del ranking**: los 5 jugadores pasaron de `puntos_totales = 0` a los valores reales calculados solo con las partidas `jugada` (1, 2 y 3); la partida cancelada no aporto puntos porque sus estadisticas ya no existen quando se ejecuto este `UPDATE`.

## Aprendizaje

El `UNIQUE (id_partida, id_jugador)` en `estadisticas` resuelve
directamente el problema que describio el cliente: ya no es posible
cargar dos veces el resultado del mismo jugador en la misma partida,
sin importar cuantas personas editen la hoja de calculo original. El
`DELETE` controlado solo alcanza estadisticas de partidas `cancelada`,
nunca de una partida `jugada` cuyo resultado ya se conto en el
ranking, y el `UPDATE` de recalculo demuestra que el ranking es un
dato derivado que se corrige, no se reconstruye borrando e insertando
filas nuevas.
