# Solicitud SQL - Ejercicio 071: Battle Royale Ranking

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una comunidad gamer registra partidas, kills, posiciones y ranking
semanal de battle royale. Hoy todo se maneja en hojas de calculo y
varias personas duplican datos sin darse cuenta. El cliente pidio
convertir esa operacion en una base de datos que permita consultar
datos, corregir estados, registrar movimientos y sacar reportes
utiles, no solo guardar texto.

## Que entendi de la solicitud

El problema central no es solo "guardar resultados", es evitar los
duplicados que hoy pasan en la hoja de calculo (el mismo jugador
cargado dos veces en la misma partida). El nivel pedido (4, reportes y
agrupaciones) exige ademas `JOIN`, `GROUP BY`, `HAVING`, totales y
ranking. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `jugadores`: catalogo de participantes de la comunidad.
- `temporadas`: catalogo de periodos de competencia.
- `partidas`: tabla transaccional, cada una dentro de una temporada.
- `estadisticas`: detalle de cada partida (kills y posicion final por
  jugador). Aqui es donde se ataca el problema del cliente: un
  `UNIQUE (id_partida, id_jugador)` impide que un jugador quede
  cargado dos veces en la misma partida.
- `ranking`: resumen de puntos por jugador y temporada, con su propio
  `UNIQUE (id_temporada, id_jugador)`. Se corrige con `UPDATE` a
  medida que se juegan mas partidas, nunca se reconstruye borrando
  filas.

## Como se relacionan

`temporadas` 1:N `partidas`; `partidas` 1:N `estadisticas`;
`jugadores` 1:N `estadisticas`; `temporadas` 1:N `ranking`;
`jugadores` 1:N `ranking`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

5 jugadores, 1 temporada, 5 partidas (3 `jugada`, 1 `programada` y 1
que se juega y despues se anula por una caida de servidor), 16 filas
de estadisticas y el ranking inicial en 0, ademas de un `INSERT`
comentado que reproduce exactamente el problema del cliente (cargar
dos veces al mismo jugador en la misma partida) y debe fallar.
Detalle en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(la partida anulada pasa a `cancelada`), un `DELETE` controlado que
limpia las estadisticas huerfanas de esa partida (y solo de partidas
`cancelada`, nunca de una `jugada`), y un `UPDATE` que recalcula el
ranking de la temporada a partir de las estadisticas reales.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que estadisticas existen
(JOIN jugador-partida), en que estado esta cada partida, que jugador
participo en mas partidas, el ranking final de la temporada ordenado
de mayor a menor, y un reporte con `GROUP BY` + `HAVING` de que
jugadores acumularon mas kills, para decidir a quien destacar como
MVP.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-071.db < ddl/schema.sql
sqlite3 ejercicio-071.db < dml/inserts.sql
sqlite3 ejercicio-071.db < dml/operaciones.sql
sqlite3 ejercicio-071.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
