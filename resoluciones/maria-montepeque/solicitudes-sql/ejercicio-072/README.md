# Solicitud SQL - Ejercicio 072: Liga MOBA

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una liga MOBA controla equipos, heroes usados, bans, partidas y
estadisticas. El cliente pide saber quien "compro", que "compro",
cuando ocurrio y cuanto dinero representa cada movimiento. En el
contexto de una liga MOBA (no de una tienda), esto se traduce en: que
jugador uso que heroe, en que partida, y cuanto oro del juego
consiguio.

## Que entendi de la solicitud

El nivel pedido (4, reportes y agrupaciones) exige, ademas del modelo
base con `CHECK`/`FOREIGN KEY`/`UNIQUE`, consultas con `JOIN`,
`GROUP BY`, `HAVING`, totales y ranking. El detalle completo del
analisis (incluida la interpretacion de la cita del cliente sobre
"dinero") esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `equipos`: catalogo de equipos de la liga.
- `jugadores`: catalogo de jugadores, cada uno con un rol fijo dentro
  de su equipo.
- `heroes`: catalogo de heroes disponibles en el juego.
- `partidas`: tabla transaccional, con un `id_equipo_ganador` que solo
  puede ser uno de los dos equipos que jugaron esa partida (`CHECK`
  que compara columnas de la misma fila).
- `estadisticas`: detalle de cada partida (que heroe uso cada jugador,
  kills, muertes, asistencias y oro conseguido). Aqui esta el
  `UNIQUE (id_partida, id_jugador)` que impide cargar dos veces al
  mismo jugador en la misma partida.

## Como se relacionan

`equipos` 1:N `jugadores`; `equipos` 1:N `partidas` (como local y como
visitante); `partidas` 1:N `estadisticas`; `jugadores` 1:N
`estadisticas`; `heroes` 1:N `estadisticas`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

3 equipos, 15 jugadores (5 por equipo, un rol de cada tipo), 10
heroes, 3 partidas (2 `jugada`, 1 `programada`), 21 filas de
estadisticas (incluye una cargada por error para la partida todavia no
jugada), ademas de un `INSERT` comentado que reproduce el error de
cargar dos veces al mismo jugador en la misma partida y debe fallar.
Detalle en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): dos `UPDATE` que
confirman el equipo ganador de cada partida jugada (segun el total de
kills del equipo), un `UPDATE` de estado (la partida sin jugar se
cancela por un conflicto de calendario), y un `DELETE` controlado que
limpia la estadistica que se habia cargado por error para esa partida
cancelada, sin tocar ninguna estadistica de una partida ya `jugada`.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que estadisticas existen
(JOIN jugador-heroe-partida), en que estado esta cada partida, que
jugador tiene mas kills, las estadisticas ordenadas por oro
conseguido, y un reporte con `GROUP BY` + `HAVING` de cuanto oro total
genero cada equipo, para saber cual domina economicamente la liga.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-072.db < ddl/schema.sql
sqlite3 ejercicio-072.db < dml/inserts.sql
sqlite3 ejercicio-072.db < dml/operaciones.sql
sqlite3 ejercicio-072.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
