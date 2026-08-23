# Evidencias - Solicitudes SQL - Ejercicio 024 (Liga Videojuego Futbol)

## Comandos ejecutados

```bash
sqlite3 ejercicio-024.db < ddl/schema.sql
sqlite3 ejercicio-024.db < dml/inserts.sql
sqlite3 ejercicio-024.db < dml/operaciones.sql
sqlite3 ejercicio-024.db < dql/consultas.sql
```

## Resultados

**1. Todos los partidos, con JOIN doble a clubes (local y visitante), ya sin la duplicada y con el pendiente actualizado:**

```text
id_partido | club_local          | club_visitante      | jornada | goles_local | goles_visitante | estado
1          | Real Estelar          | Atletico Fenix        | 1        | 3            | 1                | jugado
2          | Deportivo Trueno      | Union Cometa          | 1        | 2            | 2                | jugado
3          | Sporting Nova         | Real Estelar          | 1        | 0            | 1                | jugado
4          | Atletico Fenix        | Deportivo Trueno      | 2        | 2            | 2                | jugado
5          | Union Cometa          | Sporting Nova         | 2        | 1            | 1                | jugado
6          | Real Estelar          | Deportivo Trueno      | 2        | 4            | 0                | jugado
7          | Atletico Fenix        | Sporting Nova         | 1        | 2            | 2                | jugado
8          | Union Cometa          | Real Estelar          | 2        | 1            | 3                | jugado
```

Quedan 8 partidos (empezaron 9, se elimino la duplicada del `id_partido = 9`). El partido 4 ya no tiene marcador `0-0` (placeholder), sino el resultado real `2-2`, y su estado paso de `pendiente` a `jugado`.

**2. Partidos que no estan jugados todavia:**

```text
(sin filas)
```

**3. Club con mas partidos jugados:**

```text
nombre_club          | total_partidos
Real Estelar            | 4
Atletico Fenix           | 3
Deportivo Trueno         | 3
Union Cometa             | 3
Sporting Nova            | 3
```

**4. Partidos ordenados por fecha:** ver tabla completa arriba, de 2026-08-10 a 2026-08-14.

**5. Reporte semanal para la liga: goles totales por dia (solo partidos jugados):**

```text
dia         | goles_del_dia | partidos_jugados
2026-08-10  | 8              | 2
2026-08-11  | 5              | 2
2026-08-12  | 4              | 1
2026-08-13  | 6              | 2
2026-08-14  | 4              | 1
```

El 2026-08-10 fue el dia con mas goles de la semana (8, en 2 partidos).

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO partidos (id_club_local, id_club_visitante, ...) VALUES (1, 1, ...);` → `CHECK constraint failed: id_club_local <> id_club_visitante`.

## Operaciones de mantenimiento verificadas

- `UPDATE partidos SET goles_local = 2, goles_visitante = 2, estado = 'jugado' WHERE id_partido = 4 AND estado = 'pendiente';` → el partido pendiente se actualizo con su marcador real y paso a `jugado`.
- `UPDATE clubes SET division = 'primera' WHERE id_club = 3;` → Deportivo Trueno ascendio de `segunda` a `primera`.
- `DELETE FROM partidos WHERE id_partido = 9;` → el partido duplicado desaparecio; el conteo final es 8, no 9.

## Aprendizaje

El reporte que pidio el cliente ("decisiones al final de cada semana") usa la misma tecnica de `date(fecha_partido)` agrupada que en los ejercicios de la tienda de sneakers y el taller de autos, pero aqui se combina con un segundo caso interesante: un partido `pendiente` se inserta con un marcador temporal (`0-0`) que no representa un resultado real, y solo cuando se corrige con `UPDATE` (marcador real + estado `jugado`) empieza a contar en el reporte de goles. Si el reporte hubiera sumado partidos `pendiente` sin distinguir el estado, el total de goles habria estado equivocado desde el principio.
