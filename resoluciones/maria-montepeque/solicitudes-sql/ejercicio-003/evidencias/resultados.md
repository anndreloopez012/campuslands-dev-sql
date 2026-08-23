# Evidencias - Solicitudes SQL - Ejercicio 003 (Torneo Esports)

## Comandos ejecutados

```bash
sqlite3 ejercicio-003.db < ddl/schema.sql
sqlite3 ejercicio-003.db < dml/inserts.sql
sqlite3 ejercicio-003.db < dml/operaciones.sql
sqlite3 ejercicio-003.db < dql/consultas.sql
```

## Resultados

**1. Todos los jugadores (ya con la cuenta de prueba eliminada, puntos actualizados y estado corregido):**

```text
id_jugador | id_equipo | nickname     | nombre_real     | rol      | puntos_totales | estado
1          | 1         | ShadowFox     | Andres Lopez     | duelist  | 370            | activo
2          | 1         | IceQueen      | Marta Vega       | support  | 210            | activo
3          | 1         | CaptainRed    | Carlos Ruiz      | igl      | 180            | activo
4          | 2         | WolfBite      | Diana Cruz       | entry    | 275            | activo
5          | 2         | NightHunter   | Pedro Gomez      | duelist  | 300            | suspendido
6          | 3         | PhoenixX      | Laura Ortiz      | support  | 150            | activo
7          | 3         | BlazeStorm    | Sofia Reyes      | entry    | 190            | activo
8          | 4         | BlackEagle    | Mario Paz        | igl      | 260            | activo
```

Quedan 8 jugadores (empezaron 9, se elimino la cuenta de prueba del `id_jugador = 9`).

**2. Jugadores que no estan disponibles para competir:**

```text
id_jugador | nickname     | id_equipo | estado
5          | NightHunter   | 2         | suspendido
```

BlazeStorm ya no aparece aqui porque `operaciones.sql` corrigio su estado de `inactivo` a `activo`.

**3. Equipo con mas jugadores activos:**

```text
nombre_equipo    | jugadores_activos
Dragones Rojos    | 3
Fenix Gaming      | 2
Lobos del Norte   | 1
Aguilas Negras    | 1
```

**4. Jugadores ordenados por puntos, de mayor a menor:** ShadowFox lidera con 370 puntos (despues de sumarle 50 por su ultima victoria).

**5. Reporte para el cliente: ranking de equipos por puntos totales acumulados:**

```text
nombre_equipo     | puntos_totales_equipo | total_jugadores
Dragones Rojos      | 760                    | 3
Lobos del Norte     | 575                    | 2
Fenix Gaming         | 340                    | 2
Aguilas Negras       | 260                    | 1
```

Dragones Rojos es el equipo con mas puntos acumulados, buen candidato para el proximo torneo.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO jugadores (..., puntos_totales) VALUES (..., -10);` → `CHECK constraint failed: puntos_totales >= 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE jugadores SET puntos_totales = puntos_totales + 50 WHERE id_jugador = 1;` → ShadowFox subio de 320 a 370 puntos.
- `UPDATE jugadores SET estado = 'activo' WHERE id_jugador = 7 AND estado = 'inactivo';` → BlazeStorm volvio de `inactivo` a `activo`.
- `DELETE FROM jugadores WHERE id_jugador = 9;` → la cuenta de prueba desaparecio; el conteo final de jugadores es 8, no 9.

## Aprendizaje

La queja del cliente ("evitar registros incompletos porque despues no puede hacer reportes confiables") se resuelve directamente con `NOT NULL` en los campos que alimentan los reportes: si `puntos_totales` pudiera quedar vacio, el ranking de la consulta 5 (`SUM(j.puntos_totales)`) daria resultados incompletos sin que nadie lo notara. Ademas, el `CHECK (puntos_totales >= 0)` cierra el otro lado del problema: no basta con que el dato exista, tambien tiene que tener sentido de negocio. Las operaciones de mantenimiento muestran que corregir un registro (sumar puntos, reactivar un jugador) no es lo mismo que borrarlo y reinsertarlo: se usa `UPDATE` con `WHERE` especifico para conservar el historial, y el `DELETE` solo se aplica a un registro que realmente nunca debio existir (la cuenta de prueba), usando su `id_jugador` exacto.
