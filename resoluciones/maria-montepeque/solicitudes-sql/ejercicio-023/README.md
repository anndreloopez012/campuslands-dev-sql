# Ejercicio 023: Solicitud de cliente - Clanes Shooter

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una plataforma de shooter administra clanes, jugadores, scrims (enfrentamientos amistosos) en distintos mapas y sus resultados. El cliente pidio explicitamente evitar registros incompletos porque despues no puede hacer reportes confiables.

## Tablas y relaciones

- `clanes`: catalogo de clanes (nombre unico, region).
- `jugadores`: catalogo de jugadores, cada uno con su clan y rol (`clanes` 1—N `jugadores`).
- `scrims`: registro transaccional de cada enfrentamiento entre dos clanes (`clanes` 1—N `scrims` dos veces: como local y como rival).

No se creo una tabla `mapas` separada: el mapa se guarda como texto con `CHECK` de lista cerrada dentro de `scrims` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `jugadores.id_clan` -> `clanes.id_clan`, `scrims.id_clan_local` -> `clanes.id_clan`, `scrims.id_clan_rival` -> `clanes.id_clan`.
- `NOT NULL` en `mapa`, `marcador_local`, `marcador_rival` y `fecha_scrim`: exactamente los campos que, si faltaran, romperian el reporte de victorias.
- `UNIQUE`: `clanes.nombre_clan`, `jugadores.gamertag`.
- `CHECK`: `marcador_local >= 0`, `marcador_rival >= 0`, `mapa IN (...)`, `rol IN (...)`, `estado IN ('jugado', 'disputado', 'anulado')`, y `id_clan_local <> id_clan_rival` (un clan no puede enfrentarse a si mismo).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 clanes, 6 jugadores y 9 scrims base (uno de ellos, el scrim 9, es una duplicada por error de digitacion).
- `operaciones.sql` confirma un scrim que estaba en disputa, cambia el rol de un jugador y elimina la duplicada: quedan 8 scrims.
- El caso comentado (un clan enfrentandose a si mismo) falla al ejecutarlo: `CHECK constraint failed: id_clan_local <> id_clan_rival`.
- Ranking de victorias (combinando cuando un clan gano como local o como rival con `UNION ALL`): Lobos Nocturnos lidera con 4 victorias de 4 scrims jugados.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-023.db < ddl/schema.sql
sqlite3 ejercicio-023.db < dml/inserts.sql
sqlite3 ejercicio-023.db < dml/operaciones.sql
sqlite3 ejercicio-023.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
