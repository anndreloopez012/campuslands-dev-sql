# Solicitud SQL - Ejercicio 078: Torneo Esports

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una organizacion de esports registra equipos, jugadores, partidas y
puntos. El cliente quiere consultar rankings, totales y casos
pendientes desde la base de datos. Pidio convertir esa operacion en
una base de datos que permita consultar datos, corregir estados,
registrar movimientos y sacar reportes utiles.

## Que entendi de la solicitud

"Casos pendientes" se traduce en partidas `programada`: el cliente
necesita poder distinguirlas de las que ya se jugaron o se
cancelaron. Y "consultar rankings... desde la base de datos" sugiere
que el ranking no se calcula siempre al vuelo, sino que vive en su
propia tabla y se corrige con `UPDATE`. El nivel pedido (4, reportes y
agrupaciones) exige ademas `JOIN`, `GROUP BY`, `HAVING`, totales y
ranking. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `equipos`: catalogo de equipos del torneo.
- `jugadores`: catalogo de jugadores, cada uno de un equipo.
- `partidas`: tabla transaccional, con `estado` para distinguir casos
  pendientes de partidas ya resueltas.
- `estadisticas`: detalle de cada partida. Aqui esta el
  `UNIQUE (id_partida, id_jugador)` que impide cargar dos veces al
  mismo jugador en la misma partida.
- `ranking`: una fila por equipo (`UNIQUE (id_equipo)`), que se
  corrige con `UPDATE` a partir de las estadisticas reales.

## Como se relacionan

`equipos` 1:N `jugadores`; `equipos` 1:N `partidas` (como local y como
visitante); `partidas` 1:N `estadisticas`; `jugadores` 1:N
`estadisticas`; `equipos` 1:1 `ranking`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

3 equipos, 9 jugadores, 4 partidas (3 marcadas `jugada` en algun
momento, 1 `programada` como caso pendiente), 14 filas de
estadisticas (incluye 2 cargadas por error para una partida que
despues se descubrio que habia que cancelar) y el ranking inicial en
0. Tambien un `INSERT` comentado que reproduce el problema de cargar
dos veces al mismo jugador en la misma partida y debe fallar. Detalle
en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(la partida que fallo por el servidor pasa a `cancelada`), un
`DELETE` controlado (multiple) que limpia las estadisticas huerfanas
de esa partida, y un `UPDATE` que recalcula el ranking de los 3
equipos a partir de las partidas realmente jugadas.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que estadisticas existen
(JOIN jugador-partida), que partidas estan pendientes, jugadas o
canceladas, que jugador tiene mas actividad, el ranking final
ordenado, y un reporte con `GROUP BY` + `HAVING` de que equipos
superan un puntaje minimo, para decidir quienes avanzan a la
siguiente fase.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-078.db < ddl/schema.sql
sqlite3 ejercicio-078.db < dml/inserts.sql
sqlite3 ejercicio-078.db < dml/operaciones.sql
sqlite3 ejercicio-078.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
