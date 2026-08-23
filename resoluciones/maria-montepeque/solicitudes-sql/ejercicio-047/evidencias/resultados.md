# Evidencias - Solicitudes SQL - Ejercicio 047 (Liga MOBA)

## Comandos ejecutados

```bash
sqlite3 ejercicio-047.db < ddl/schema.sql
sqlite3 ejercicio-047.db < dml/inserts.sql
sqlite3 ejercicio-047.db < dml/operaciones.sql
sqlite3 ejercicio-047.db < dql/consultas.sql
```

## Resultados

**1. Todas las partidas, con JOIN triple a jugadores, heroes y equipos rivales (ya sin la duplicada, sin la partida vacia, con la partida 7 revisada y corregida, y la partida 3 anulada pero con sus estadisticas intactas):**

```text
id_partida | nombre_jugador | nombre_heroe | rival             | fecha_partida | kills | deaths | assists | resultado | estado
1          | NovaBlade       | Vexara        | Lobos del Norte    | 2026-08-01      | 8      | 2       | 5        | victoria    | valida
2          | IronWisp        | Grimtusk      | Lobos del Norte    | 2026-08-01      | 2      | 3       | 10       | victoria    | valida
3          | SolaraFX        | Threx         | Fenix Electrico    | 2026-08-03      | 5      | 4       | 3        | derrota     | anulada
4          | ZephyrDash      | Kaidon        | Fenix Electrico    | 2026-08-03      | 10     | 1       | 4        | derrota     | valida
5          | NovaBlade       | Morvash       | Titanes Boreales   | 2026-08-06      | 12     | 2       | 6        | victoria    | valida
6          | MysticVale      | Lyrienne      | Titanes Boreales   | 2026-08-06      | 0      | 1       | 15       | victoria    | valida
7          | IronWisp        | Grimtusk      | Sombra Eterna      | 2026-08-09      | 4      | 5       | 2        | derrota     | valida
8          | SolaraFX        | Threx         | Lobos del Norte    | 2026-08-11      | 6      | 3       | 4        | victoria    | valida
10         | NovaBlade       | Vexara        | Fenix Electrico    | 2026-08-15      | 9      | 1       | 7        | victoria    | valida
```

Quedan 9 partidas (empezaron 11: se elimino la duplicada `id_partida = 11` y la partida sin estadisticas reales `id_partida = 9`).

**2. Partidas que no estan validas todavia:**

```text
id_partida | id_jugador | fecha_partida | estado
3          | 3          | 2026-08-03      | anulada
```

Esta es la partida anulada por el bug reportado, que conserva intactas sus estadisticas (5/4/3) como evidencia.

**3. Jugador con mas partidas jugadas:**

```text
nombre_jugador | total_partidas
NovaBlade      | 3
IronWisp       | 2
SolaraFX       | 2
MysticVale     | 1
ZephyrDash     | 1
```

**4. Partidas ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-15.

**5. Jugador con mejor KDA (solo partidas validas), para decidir a quien priorizar en el proximo draft:**

```text
nombre_jugador | kills_totales | deaths_totales | assists_totales | kda
MysticVale     | 0              | 1               | 15               | 15.0
ZephyrDash     | 10             | 1               | 4                 | 14.0
NovaBlade      | 29             | 5               | 18                | 9.4
SolaraFX       | 6              | 3               | 4                 | 3.33
IronWisp       | 6              | 8               | 12                | 2.25
```

La partida 3 (anulada) no cuenta en este ranking, aunque sus estadisticas siguen guardadas en la base de datos.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO heroes (nombre_heroe, ...) VALUES ('Grimtusk', ...);` → `UNIQUE constraint failed: heroes.nombre_heroe`.
- Valor fuera de rango: `INSERT INTO partidas (..., resultado) VALUES (..., 'empate');` → `CHECK constraint failed: resultado IN ('victoria', 'derrota')`.

## Operaciones de mantenimiento verificadas

- `UPDATE partidas SET estado = 'valida', kills = 4 WHERE id_partida = 7 AND estado = 'en_revision';` → la partida de IronWisp se confirmo valida y su conteo de kills se corrigio de 3 a 4.
- `UPDATE partidas SET estado = 'anulada' WHERE id_partida = 3 AND estado = 'valida';` → se anulo el resultado de SolaraFX por un bug confirmado, sin borrar sus estadisticas (5/4/3 siguen en la fila).
- `DELETE FROM partidas WHERE id_partida = 9 AND estado = 'anulada' AND kills = 0 AND deaths = 0 AND assists = 0;` → **DELETE controlado**: elimino unicamente la partida 9 (0/0/0, nunca empezo el combate). La partida 3, tambien anulada pero con estadisticas reales, no cumplia la condicion y se conservo.
- `DELETE FROM partidas WHERE id_partida = 11;` → la partida duplicada desaparecio. Conteo final verificado: 9 partidas (empezaron 11).

## Aprendizaje

La partida 3 demuestra exactamente lo que pidio el cliente: se corrigio el estado (`valida` -> `anulada`) sin tocar ni una sola cifra de sus estadisticas. El `DELETE` controlado, en cambio, exige tres condiciones numericas a la vez (`kills = 0 AND deaths = 0 AND assists = 0`) ademas del estado, lo que garantiza que jamas se borre una partida que ya genero informacion real, aunque este anulada.
