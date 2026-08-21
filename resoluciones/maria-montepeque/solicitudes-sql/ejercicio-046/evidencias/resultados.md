# Evidencias - Solicitudes SQL - Ejercicio 046 (Battle Royale Ranking)

## Comandos ejecutados

```bash
sqlite3 ejercicio-046.db < ddl/schema.sql
sqlite3 ejercicio-046.db < dml/inserts.sql
sqlite3 ejercicio-046.db < dml/operaciones.sql
sqlite3 ejercicio-046.db < dql/consultas.sql
```

## Resultados

**1. Todas las partidas, con JOIN a temporadas (ya sin la duplicada, sin la partida sin resultados, y con las partidas 6 y 9 finalizadas):**

```text
id_partida | nombre_temporada        | fecha_partida | mapa            | estado
1          | Temporada 1 - Verano    | 2026-07-05      | Isla Tormenta    | finalizada
2          | Temporada 1 - Verano    | 2026-07-12      | Desierto Rojo    | finalizada
3          | Temporada 2 - Otono     | 2026-08-02      | Isla Tormenta    | finalizada
4          | Temporada 2 - Otono     | 2026-08-05      | Zona Artica      | finalizada
5          | Temporada 2 - Otono     | 2026-08-09      | Desierto Rojo    | finalizada
6          | Temporada 2 - Otono     | 2026-08-12      | Isla Tormenta    | finalizada
8          | Temporada 2 - Otono     | 2026-08-18      | Desierto Rojo    | anulada
9          | Temporada 2 - Otono     | 2026-08-20      | Isla Tormenta    | finalizada
```

Quedan 8 partidas (empezaron 10: se elimino la duplicada `id_partida = 10` y la partida sin resultados `id_partida = 7`).

**2. Partidas que no estan finalizadas todavia:**

```text
id_partida | id_temporada | fecha_partida | estado
8          | 2             | 2026-08-18      | anulada
```

Esta es la partida anulada que si tiene un resultado parcial registrado, por eso el `DELETE` controlado nunca la toco.

**3. Jugador con mas partidas jugadas:**

```text
nombre_jugador   | partidas_jugadas
ShadowFox_502    | 4
NightBlade99     | 3
QuetzalSniper    | 2
PixelHunter      | 1
RunaWarrior      | 1
VortexGG         | 1
```

**4. Partidas ordenadas por fecha:** ver tabla completa arriba, de 2026-07-05 a 2026-08-20.

**5. Ranking de puntos de la temporada activa (Temporada 2 - Otono), para decidir a quien reconocer esta temporada:**

```text
nombre_jugador   | puntos_temporada
ShadowFox_502    | 28
RunaWarrior      | 24
PixelHunter      | 19
QuetzalSniper    | 17
VortexGG         | 16
NightBlade99     | 14
```

Este ranking solo cuenta puntos de partidas de la temporada `activa`; la Temporada 1 (cerrada) no entra en el calculo aunque ShadowFox_502 tambien jugo ahi.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO jugadores (nombre_jugador, ...) VALUES ('ShadowFox_502', ...);` → `UNIQUE constraint failed: jugadores.nombre_jugador`.
- Fechas invalidas: `INSERT INTO temporadas (..., fecha_inicio, fecha_fin) VALUES (..., '2026-09-30', '2026-09-01');` → `CHECK constraint failed: fecha_fin > fecha_inicio`.

## Operaciones de mantenimiento verificadas

- `UPDATE partidas SET estado = 'finalizada' WHERE id_partida = 6 AND estado = 'en_curso';` → la partida del 2026-08-12 quedo finalizada.
- `UPDATE partidas SET estado = 'finalizada' WHERE id_partida = 9 AND estado = 'en_curso';` → la partida del 2026-08-20 quedo finalizada.
- `DELETE FROM partidas WHERE id_partida = 7 AND estado = 'anulada' AND NOT EXISTS (...);` → **DELETE controlado**: elimino unicamente la partida 7 (se cayo el servidor sin generar ningun resultado). La partida 8, tambien anulada pero con un resultado parcial guardado, no cumplia la condicion `NOT EXISTS` y por eso se conservo intacta.
- `DELETE FROM partidas WHERE id_partida = 10;` → la partida duplicada desaparecio. Conteo final verificado: 8 partidas, 12 estadisticas, sin huerfanos.

## Aprendizaje

Separar catalogos (`jugadores`, `temporadas`) de operaciones (`partidas`) y resultados (`estadisticas`), tal como pidio el cliente, es lo que permite que el ranking de la consulta 5 filtre limpio por `temporadas.estado = 'activa'`: la informacion permanente (quien es un jugador) nunca se mezcla con el movimiento (que partida se jugo) ni con el resultado (que puntos gano). El `DELETE` controlado con `NOT EXISTS` protege exactamente el caso donde un movimiento anulado ya genero un resultado real: ese historial no se pierde.
