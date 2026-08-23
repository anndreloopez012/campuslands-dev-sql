# Ejercicio 028: Solicitud de cliente - Torneo Esports

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una organizacion de esports registra equipos, jugadores, partidas y puntos. El cliente pidio explicitamente poder consultar rankings, totales y casos pendientes directamente desde la base de datos.

## Tablas y relaciones

- `equipos`: catalogo de equipos (nombre unico, region).
- `jugadores`: catalogo de jugadores, cada uno con su equipo y rol (`equipos` 1—N `jugadores`).
- `partidas`: registro transaccional de cada partida jugada, con su estado (`jugadores` 1—N `partidas`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `jugadores.id_equipo` -> `equipos.id_equipo`, `partidas.id_jugador` -> `jugadores.id_jugador`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `equipos.nombre_equipo`, `jugadores.nickname`.
- `CHECK`: `puntos_obtenidos >= 0`, `resultado IN ('victoria', 'derrota')`, `rol IN (...)`, `estado IN ('confirmada', 'pendiente', 'anulada')`.
- `DEFAULT`: `estado` en `'confirmada'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 4 equipos, 6 jugadores y 9 partidas base (una de ellas, la partida 9, es una duplicada por error de digitacion).
- `operaciones.sql` confirma una partida que estaba pendiente, cambia el rol de un jugador y elimina la duplicada: quedan 8 partidas.
- El caso comentado (`puntos_obtenidos = -10`) falla al ejecutarlo: `CHECK constraint failed: puntos_obtenidos >= 0`.
- Ranking (jugador con mas puntos): ShadowFox lidera con 55.
- Totales (puntos por equipo, JOIN de las tres tablas): Dragones Rojos lidera con 70.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-028.db < ddl/schema.sql
sqlite3 ejercicio-028.db < dml/inserts.sql
sqlite3 ejercicio-028.db < dml/operaciones.sql
sqlite3 ejercicio-028.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
