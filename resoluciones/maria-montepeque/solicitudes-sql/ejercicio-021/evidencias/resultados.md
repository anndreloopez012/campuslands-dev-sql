# Evidencias - Solicitudes SQL - Ejercicio 021 (Battle Royale Ranking)

## Comandos ejecutados

```bash
sqlite3 ejercicio-021.db < ddl/schema.sql
sqlite3 ejercicio-021.db < dml/inserts.sql
sqlite3 ejercicio-021.db < dml/operaciones.sql
sqlite3 ejercicio-021.db < dql/consultas.sql
```

## Resultados

**1. Todas las estadisticas, con JOIN a jugadores y partidas (ya sin la duplicada y con la revision resuelta):**

```text
id_estadistica | gamertag     | mapa      | kills | posicion_final | estado
1              | ShadowFox      | desierto   | 8     | 1               | confirmada
2              | NightHunter    | desierto   | 5     | 4               | confirmada
3              | BlazeStorm     | isla       | 12    | 1               | confirmada
4              | IceQueen       | isla       | 3     | 10              | confirmada
5              | ShadowFox      | urbano     | 6     | 2               | confirmada
6              | GhostRider     | urbano     | 2     | 15              | confirmada
7              | NightHunter    | nieve      | 9     | 1               | confirmada
8              | IceQueen       | nieve      | 4     | 5               | confirmada
```

Quedan 8 estadisticas (empezaron 9, se elimino la duplicada del `id_estadistica = 9`).

**2. Estadisticas que no estan confirmadas todavia:**

```text
(sin filas)
```

La revision de BlazeStorm (id_estadistica = 3) ya no aparece aqui porque `operaciones.sql` la confirmo tras descartar la trampa.

**3. Jugador con mas actividad (mas partidas jugadas):**

```text
gamertag     | partidas_jugadas
ShadowFox      | 2
NightHunter    | 2
IceQueen        | 2
BlazeStorm      | 1
GhostRider      | 1
```

**4. Estadisticas ordenadas por fecha de partida:** ver tabla completa arriba, de 2026-08-10 a 2026-08-13.

**5. Ranking semanal (kills totales y victorias por jugador):**

```text
gamertag     | equipo     | kills_totales | victorias
ShadowFox      | Dragones    | 14             | 1
NightHunter    | Lobos       | 14             | 1
BlazeStorm      | Dragones    | 12             | 1
IceQueen        | Fenix       | 7              | 0
GhostRider      | Lobos       | 2              | 0
```

ShadowFox y NightHunter empatan en la cima con 14 kills totales cada uno; ambos serian candidatos a premio de la semana.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO estadisticas (id_jugador, id_partida, kills, posicion_final) VALUES (3, 4, 2, 0);` → `CHECK constraint failed: posicion_final > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE estadisticas SET estado = 'confirmada' WHERE id_estadistica = 3 AND estado = 'en_revision';` → la estadistica sospechosa de BlazeStorm se confirmo tras revision.
- `UPDATE jugadores SET nivel = nivel + 1 WHERE id_jugador = 1;` → ShadowFox subio de nivel 12 a 13.
- `DELETE FROM estadisticas WHERE id_estadistica = 9;` → la estadistica duplicada desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Este ejercicio aplico directamente el ejemplo de razonamiento del enunciado: en vez de guardar los kills como una columna en `jugadores` (que solo permitiria un numero por jugador, mezclando todas sus partidas), se creo `estadisticas` como tabla de detalle que conecta `jugadores` y `partidas` mediante dos `FOREIGN KEY`. Esta relacion muchos-a-muchos es lo que permite que el ranking semanal (consulta 5) agregue datos correctamente con `JOIN` + `GROUP BY`: cada fila de `estadisticas` representa exactamente "este jugador, en esta partida, hizo esto", y sumar sobre esas filas da el total real de la semana.
