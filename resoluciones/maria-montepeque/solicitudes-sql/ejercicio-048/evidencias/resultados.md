# Evidencias - Solicitudes SQL - Ejercicio 048 (Clanes Shooter)

## Comandos ejecutados

```bash
sqlite3 ejercicio-048.db < ddl/schema.sql
sqlite3 ejercicio-048.db < dml/inserts.sql
sqlite3 ejercicio-048.db < dml/operaciones.sql
sqlite3 ejercicio-048.db < dql/consultas.sql
```

## Resultados

**1. Todos los scrims, con JOIN doble a clanes y mapas (ya sin el duplicado, sin el scrim vacio, con el scrim 8 jugado y el conteo del scrim 6 corregido):**

```text
id_scrim | rival               | nombre_mapa      | fecha_scrim | rondas_ganadas | rondas_perdidas | estado
1         | Furia Escarlata      | Refineria         | 2026-08-01    | 13              | 7                | jugado
2         | Lobos de Acero       | Bunker Norte      | 2026-08-02    | 10              | 12               | jugado
3         | Furia Escarlata      | Puerto Fantasma   | 2026-08-04    | 13              | 4                | jugado
4         | Sombra Tactica       | Refineria         | 2026-08-05    | 9               | 13               | jugado
5         | Vortice Rojo         | Zona Roja         | 2026-08-07    | 13              | 10               | jugado
6         | Furia Escarlata      | Bunker Norte      | 2026-08-09    | 14              | 6                | jugado
7         | Lobos de Acero       | Puerto Fantasma   | 2026-08-11    | 6               | 13               | jugado
8         | Trueno Silencioso    | Complejo Aereo    | 2026-08-13    | 13              | 9                | jugado
10        | Furia Escarlata      | Complejo Aereo    | 2026-08-17    | 0               | 0                | programado
```

Quedan 9 scrims (empezaron 11: se elimino el duplicado `id_scrim = 11` y el scrim cancelado sin rondas `id_scrim = 9`).

**2. Scrims que no estan jugados todavia (casos pendientes):**

```text
id_scrim | id_clan_rival | fecha_scrim | estado
10        | 2              | 2026-08-17    | programado
```

**3. Contra que clan rival se ha jugado mas (ranking de actividad):**

```text
rival               | total_scrims
Furia Escarlata      | 4
Lobos de Acero       | 2
Sombra Tactica       | 1
Trueno Silencioso    | 1
Vortice Rojo         | 1
```

**4. Scrims ordenados por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-17.

**5. Ratio de victoria por clan rival (solo scrims jugados), para decidir contra quien practicar mas:**

```text
rival               | rondas_ganadas_total | rondas_perdidas_total | ratio_victoria
Lobos de Acero       | 16                     | 25                     | 0.39
Sombra Tactica       | 9                      | 13                     | 0.409
Vortice Rojo         | 13                     | 10                     | 0.565
Trueno Silencioso    | 13                     | 9                      | 0.591
Furia Escarlata      | 40                     | 17                     | 0.702
```

Lobos de Acero es el rival con el ratio de victoria mas bajo: es el clan contra el que conviene programar mas scrims de practica.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO clanes (nombre_clan, ...) VALUES ('Furia Escarlata', ...);` → `UNIQUE constraint failed: clanes.nombre_clan`.
- Valor fuera de rango: `INSERT INTO scrims (..., rondas_ganadas, ...) VALUES (..., -1, ...);` → `CHECK constraint failed: rondas_ganadas >= 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE scrims SET estado = 'jugado', rondas_ganadas = 13, rondas_perdidas = 9 WHERE id_scrim = 8 AND estado = 'programado';` → el scrim contra Trueno Silencioso quedo jugado con resultado.
- `UPDATE scrims SET rondas_ganadas = 14 WHERE id_scrim = 6;` → se corrigio el conteo de rondas ganadas contra Furia Escarlata (13 a 14) tras revisar el replay.
- `DELETE FROM scrims WHERE id_scrim = 9 AND estado = 'cancelado' AND rondas_ganadas = 0 AND rondas_perdidas = 0;` → **DELETE controlado**: elimino unicamente el scrim 9 (cancelado, sin ninguna ronda jugada). El scrim 10, que solo estaba `programado` (no cancelado), no cumplia la condicion y se conservo.
- `DELETE FROM scrims WHERE id_scrim = 11;` → el scrim duplicado desaparecio. Conteo final verificado: 9 scrims (empezaron 11).

## Aprendizaje

El ranking de actividad (consulta 3) y el ratio de victoria (consulta 5) responden exactamente lo que pidio el cliente: rankings, totales y casos pendientes, todo calculado desde la base de datos y no a mano. El `DELETE` controlado exige estado `cancelado` **y** cero rondas jugadas a la vez, lo que evita borrar por error un scrim que ya genero informacion real (como el scrim 10, que sigue pendiente pero no cancelado).
