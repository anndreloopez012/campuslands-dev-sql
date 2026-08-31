# Evidencias - Solicitudes SQL - Ejercicio 072 (Liga MOBA)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-072.db < ddl/schema.sql
sqlite3 ejercicio-072.db < dml/inserts.sql
sqlite3 ejercicio-072.db < dml/operaciones.sql
sqlite3 ejercicio-072.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 equipos, 15 jugadores, 10 heroes,
3 partidas (2 `jugada`, 1 `programada`) y 21 filas de estadisticas
(incluye la cargada por error para la partida 3).

**Caso comentado verificado:**

- `INSERT INTO estadisticas (id_partida, id_jugador, ...) VALUES (2, 11, ...);` (repetir a NeonFang en la partida 2) → `UNIQUE constraint failed: estadisticas.id_partida, estadisticas.id_jugador`.

**1. Todas las estadisticas, con JOIN a jugador, heroe y partida (20
filas tras el `DELETE` de la partida cancelada).**

**2. Partidas por estado:**

```text
id_partida | fecha_partida   | estado       | id_equipo_ganador
3           | 2026-08-08        | cancelada     | (NULL)
1           | 2026-08-01        | jugada        | 1
2           | 2026-08-03        | jugada        | 3
```

**3. Jugadores con mas kills acumulados (top 5):**

```text
nickname     | kills_totales
RapidFire      | 9
PulseWave      | 7
StormArrow     | 7
GlitchMind     | 6
MidGlitch      | 6
```

**4. Estadisticas ordenadas por oro conseguido (top de la tabla):**

```text
nickname     | nombre_heroe | oro_conseguido
StormArrow     | Vayne          | 14900
GlitchMind     | Lux             | 14100
NeonFang       | Yasuo           | 13400
MidGlitch      | Zed             | 13200
SniperByte     | Jinx            | 12900
MoonHowl       | Ahri            | 12800
```

**5. Oro total generado por equipo (reporte economico):**

```text
nombre_equipo          | oro_total
Fenix Cibernetico        | 102200
Lobos de Neon            | 65400
Dragones Electricos      | 60200
```

(Fenix Cibernetico jugo las dos partidas ya finalizadas, por eso
acumula el oro de ambas; Dragones Electricos y Lobos de Neon solo
jugaron una cada uno.)

## Operaciones de mantenimiento verificadas

- `UPDATE partidas SET id_equipo_ganador = 1 WHERE id_partida = 1;` → Dragones Electricos (18 kills de equipo) confirmado ganador sobre Fenix Cibernetico (10 kills).
- `UPDATE partidas SET id_equipo_ganador = 3 WHERE id_partida = 2;` → Lobos de Neon (23 kills de equipo) confirmado ganador sobre Fenix Cibernetico (14 kills).
- `UPDATE partidas SET estado = 'cancelada' WHERE id_partida = 3 ...;` → la partida del 2026-08-08 se cancelo por un conflicto de calendario.
- **DELETE controlado**: se elimino la unica estadistica que se habia cargado por error para la partida 3 (todavia no jugada), apenas quedo `cancelada`. Total de estadisticas: 21 -> 20. Ninguna estadistica de una partida `jugada` se toco.

## Aprendizaje

El `UNIQUE (id_partida, id_jugador)` en `estadisticas` evita que un
jugador quede cargado dos veces en la misma partida. El `CHECK` sobre
`id_equipo_ganador` obliga a que el ganador confirmado sea siempre uno
de los dos equipos que jugaron esa partida, nunca un tercero. El
`DELETE` controlado solo alcanza estadisticas de partidas
`cancelada`, protegiendo cualquier resultado ya oficial (`jugada`). Y
el reporte de oro por equipo (`GROUP BY` + `HAVING`) responde
directamente la pregunta economica que trajo el cliente, adaptada al
dominio de una liga MOBA: cuanto "dinero" (oro del juego) genero cada
equipo.
