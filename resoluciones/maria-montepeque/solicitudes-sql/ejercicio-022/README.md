# Ejercicio 022: Solicitud de cliente - Liga MOBA

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una liga MOBA controla equipos, jugadores, heroes usados, bans, partidas y estadisticas. El cliente pidio saber quien jugo, que heroe uso, cuando ocurrio la partida y cuanto dinero represento (cada victoria reparte un premio en efectivo).

## Tablas y relaciones

- `equipos`: catalogo de equipos de la liga (nombre unico, region).
- `jugadores`: catalogo de jugadores, cada uno con su equipo y rol (`equipos` 1—N `jugadores`).
- `partidas_jugadas`: registro transaccional de cada partida jugada (`jugadores` 1—N `partidas_jugadas`).

No se creo una tabla `heroes` separada: el heroe usado se guarda como texto dentro de `partidas_jugadas`, manteniendo el foco en la cadena de relaciones equipos-jugadores-partidas que pide este nivel (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `jugadores.id_equipo` -> `equipos.id_equipo`, `partidas_jugadas.id_jugador` -> `jugadores.id_jugador`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `equipos.nombre_equipo`, `jugadores.nickname`.
- `CHECK`: `region IN (...)`, `rol IN (...)`, `resultado IN ('victoria', 'derrota')`, `premio_ganado >= 0`, `estado IN ('confirmado', 'en_revision', 'anulado')`.
- `DEFAULT`: `premio_ganado` en 0, `estado` en `'confirmado'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 4 equipos, 6 jugadores y 9 registros de partidas base (uno de ellos, el registro 9, es una duplicada por error de digitacion).
- `operaciones.sql` confirma un registro que estaba en revision, cambia el rol de un jugador y elimina la duplicada: quedan 8 registros.
- El caso comentado (`premio_ganado = -100`) falla al ejecutarlo: `CHECK constraint failed: premio_ganado >= 0`.
- Todas las consultas usan `JOIN`, incluida la consulta 5 que encadena las tres tablas (`equipos` -> `jugadores` -> `partidas_jugadas`).
- Reporte de premios por equipo: Titanes Latam lidera con 1300.0.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-022.db < ddl/schema.sql
sqlite3 ejercicio-022.db < dml/inserts.sql
sqlite3 ejercicio-022.db < dml/operaciones.sql
sqlite3 ejercicio-022.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
