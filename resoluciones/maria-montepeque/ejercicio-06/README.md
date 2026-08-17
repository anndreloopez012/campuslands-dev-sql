# Ejercicio 06: Torneo Esports

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-04

## Descripcion del problema

El torneo necesita reemplazar el registro manual de equipos, jugadores, partidas y resultados por una base de datos relacional que evite duplicidad y permita generar reportes de desempeno por jugador y por partida.

## Tablas y relaciones

- `equipos`: catalogo de equipos participantes (nombre).
- `jugadores`: catalogo de jugadores por equipo (`equipos` 1—N `jugadores`).
- `partidas`: enfrentamiento entre dos equipos (`equipos` 1—N `partidas`, dos veces: local y visitante).
- `resultados`: desempeno de un jugador en una partida (`partidas` 1—N `resultados`, `jugadores` 1—N `resultados`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `jugadores.id_equipo`, `partidas.equipo_local`, `partidas.equipo_visitante`, `resultados.id_partida`, `resultados.id_jugador`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `equipos.nombre`, `jugadores.nickname`, `(id_partida, id_jugador)` en `resultados`.
- `CHECK`: `jugadores.rol IN (...)`, `partidas.equipo_local <> partidas.equipo_visitante`, `resultados.kills >= 0`, `resultados.muertes >= 0`, `resultados.puntos >= 0`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con SQLite:

- 6 equipos, 5 jugadores, 6 partidas y 9 resultados tras aplicar `operaciones.sql`.
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al ejecutarlas: una por `UNIQUE (equipos.nombre)` y otra por `CHECK (equipo_local <> equipo_visitante)`.
- Consulta de decision de negocio (jugador con mas puntos acumulados / MVP): `BlackHawk` con 180 puntos.

## Como ejecutar

```bash
sqlite3 ejercicio-06.db < ddl/schema.sql
sqlite3 ejercicio-06.db < dml/inserts.sql
sqlite3 ejercicio-06.db < dml/operaciones.sql
sqlite3 ejercicio-06.db < dql/consultas.sql
```
