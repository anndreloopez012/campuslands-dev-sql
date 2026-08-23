# Ejercicio 021: Solicitud de cliente - Battle Royale Ranking

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una comunidad gamer registra partidas de battle royale, kills, posiciones y arma un ranking semanal. Hoy todo se maneja en hojas de calculo y varias personas duplican datos sin darse cuenta. El cliente pidio relaciones reales entre tablas, poder corregir estados y sacar reportes de ranking.

## Tablas y relaciones

- `jugadores`: catalogo de jugadores de la comunidad (gamertag unico, equipo, nivel).
- `partidas`: catalogo de partidas jugadas (mapa, fecha, total de jugadores).
- `estadisticas`: tabla de detalle que conecta un jugador con una partida especifica (`jugadores` 1—N `estadisticas`, `partidas` 1—N `estadisticas`), resolviendo la relacion muchos-a-muchos entre jugadores y partidas — el mismo patron que sugiere el ejemplo de razonamiento del enunciado (`ventas` + `detalle_ventas`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `estadisticas.id_jugador` -> `jugadores.id_jugador`, `estadisticas.id_partida` -> `partidas.id_partida`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `jugadores.gamertag`.
- `CHECK`: `nivel > 0`, `mapa IN (...)`, `total_jugadores > 0`, `kills >= 0`, `posicion_final > 0`, `estado IN ('confirmada', 'en_revision', 'anulada')`.
- `DEFAULT`: `nivel` en 1, `kills` en 0, `estado` en `'confirmada'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 jugadores, 4 partidas y 9 filas de estadisticas base (una de ellas, la 9, es una duplicada por error de digitacion).
- `operaciones.sql` confirma una estadistica que estaba en revision por posible trampa, sube de nivel a un jugador y elimina la fila duplicada: quedan 8 estadisticas.
- El caso comentado (`posicion_final = 0`) falla al ejecutarlo: `CHECK constraint failed: posicion_final > 0`.
- Todas las consultas usan `JOIN` entre `jugadores`, `partidas` y `estadisticas`, tal como pide el alcance tecnico de este nivel.
- Ranking semanal: ShadowFox y NightHunter empatan en la cima con 14 kills totales cada uno.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-021.db < ddl/schema.sql
sqlite3 ejercicio-021.db < dml/inserts.sql
sqlite3 ejercicio-021.db < dml/operaciones.sql
sqlite3 ejercicio-021.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
