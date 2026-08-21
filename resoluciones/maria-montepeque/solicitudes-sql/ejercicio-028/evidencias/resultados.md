# Evidencias - Solicitudes SQL - Ejercicio 028 (Torneo Esports)

## Comandos ejecutados

```bash
sqlite3 ejercicio-028.db < ddl/schema.sql
sqlite3 ejercicio-028.db < dml/inserts.sql
sqlite3 ejercicio-028.db < dml/operaciones.sql
sqlite3 ejercicio-028.db < dql/consultas.sql
```

## Resultados

**1. Todas las partidas, con JOIN a jugadores (ya sin la duplicada y con la revision de IceQueen confirmada):**

```text
id_partida | nickname     | puntos_obtenidos | resultado | fecha_partida       | estado
1          | ShadowFox      | 25                 | victoria   | 2026-08-01 18:00     | confirmada
2          | WolfBite       | 18                 | derrota    | 2026-08-01 18:00     | confirmada
3          | IceQueen       | 15                 | victoria   | 2026-08-02 19:00     | confirmada
4          | PhoenixX       | 10                 | derrota    | 2026-08-02 19:00     | confirmada
5          | ShadowFox      | 30                 | victoria   | 2026-08-03 20:00     | confirmada
6          | NightHunter    | 22                 | victoria   | 2026-08-03 20:00     | confirmada
7          | BlackEagle     | 20                 | derrota    | 2026-08-04 18:30     | confirmada
8          | WolfBite       | 28                 | victoria   | 2026-08-04 18:30     | confirmada
```

Quedan 8 partidas (empezaron 9, se elimino la duplicada del `id_partida = 9`).

**2. Casos pendientes:**

```text
(sin filas)
```

La partida de IceQueen (id_partida = 3) ya no aparece aqui porque `operaciones.sql` la confirmo tras la revision.

**3. Ranking: jugador con mas puntos totales:**

```text
nickname     | rol      | puntos_totales
ShadowFox      | duelist   | 55
WolfBite        | entry     | 46
NightHunter     | duelist   | 22
BlackEagle      | igl       | 20
IceQueen        | entry     | 15
PhoenixX        | support   | 10
```

**4. Partidas ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-04.

**5. Totales: puntos acumulados por equipo (JOIN de las tres tablas):**

```text
nombre_equipo     | region          | puntos_totales_equipo
Dragones Rojos       | Norteamerica     | 70
Lobos del Norte       | Sudamerica       | 68
Aguilas Negras         | Asia             | 20
Fenix Gaming            | Europa           | 10
```

Dragones Rojos lidera con 70 puntos totales, buen candidato para el proximo torneo.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO partidas (id_jugador, puntos_obtenidos, resultado) VALUES (5, -10, 'derrota');` → `CHECK constraint failed: puntos_obtenidos >= 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE partidas SET estado = 'confirmada' WHERE id_partida = 3 AND estado = 'pendiente';` → la partida de IceQueen paso de `pendiente` a `confirmada`.
- `UPDATE jugadores SET rol = 'entry' WHERE id_jugador = 2;` → IceQueen cambio de rol `support` a `entry`.
- `DELETE FROM partidas WHERE id_partida = 9;` → la partida duplicada desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Las tres preguntas del cliente ("rankings, totales y casos pendientes") se responden con la misma estructura de datos vista antes, pero aqui con una relacion en cadena de tres tablas: el ranking de jugador agrupa a un salto de distancia (`jugadores` + `partidas`), mientras que el total por equipo agrega a dos saltos de distancia (`equipos` + `jugadores` + `partidas`). Confirmar que ambos niveles de agregacion dan resultados coherentes (Dragones Rojos = ShadowFox 55 + IceQueen 15 = 70) es una buena forma de verificar que las llaves foraneas estan bien encadenadas.
