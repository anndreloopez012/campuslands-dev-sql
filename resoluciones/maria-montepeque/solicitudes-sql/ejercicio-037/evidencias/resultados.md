# Evidencias - Solicitudes SQL - Ejercicio 037 (Club Futbol Sala)

## Comandos ejecutados

```bash
sqlite3 ejercicio-037.db < ddl/schema.sql
sqlite3 ejercicio-037.db < dml/inserts.sql
sqlite3 ejercicio-037.db < dml/operaciones.sql
sqlite3 ejercicio-037.db < dql/consultas.sql
```

## Resultados

**1. Todos los partidos, con JOIN doble a jugadores y equipos rivales (ya sin el duplicado, con el gol de Emilio corregido y el partido de Rodrigo suspendido):**

```text
id_partido | nombre_jugador   | rival             | fecha_partido | goles | tarjeta   | estado
1          | Andres Vela      | Tigres FS         | 2026-08-02    | 2     | ninguna   | jugado
2          | Rodrigo Chuc     | Tigres FS         | 2026-08-02    | 0     | amarilla  | jugado
3          | Emilio Solares   | Aguilas Rapidas   | 2026-08-09    | 2     | ninguna   | jugado
4          | Andres Vela      | Aguilas Rapidas   | 2026-08-09    | 0     | amarilla  | jugado
5          | Bryan Tuyuc      | Halcones del Sur  | 2026-08-16    | 0     | roja      | jugado
6          | Diego Marroquin  | Halcones del Sur  | 2026-08-16    | 1     | ninguna   | jugado
7          | Andres Vela      | Halcones del Sur  | 2026-08-16    | 1     | amarilla  | jugado
8          | Rodrigo Chuc     | Panteras Negras   | 2026-08-23    | 0     | ninguna   | suspendido
9          | Emilio Solares   | Titanes FS        | 2026-08-30    | 0     | ninguna   | programado
```

Quedan 9 registros de partido (empezaron 10, se elimino el duplicado del `id_partido = 10`).

**2. Partidos que no se han jugado todavia:**

```text
id_partido | id_jugador | id_equipo_rival | fecha_partido | estado
8          | 2          | 5               | 2026-08-23    | suspendido
9          | 3          | 6               | 2026-08-30    | programado
```

**3. Jugador con mas goles en total:**

```text
nombre_jugador   | total_goles
Andres Vela      | 3
Emilio Solares   | 2
Diego Marroquin  | 1
Bryan Tuyuc      | 0
Rodrigo Chuc     | 0
```

**4. Partidos ordenados por fecha:** ver tabla completa arriba, de 2026-08-02 a 2026-08-30.

**5. Jugadores en riesgo de sancion (2 o mas amarillas, o alguna roja), para decidir a quien cuidar en el siguiente partido:**

```text
nombre_jugador | amarillas | rojas
Bryan Tuyuc    | 0         | 1
Andres Vela    | 2         | 0
```

Bryan Tuyuc esta suspendido por la tarjeta roja directa; Andres Vela ya acumulo 2 amarillas y arriesga suspension si recibe una mas. El club puede usar este reporte para decidir a quien dar descanso en el siguiente partido.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO partidos (..., goles) VALUES (..., -1);` → `CHECK constraint failed: goles >= 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE partidos SET estado = 'suspendido' WHERE id_partido = 8 AND estado = 'programado';` → el partido de Rodrigo Chuc contra Panteras Negras paso de `programado` a `suspendido`, sin borrar el registro.
- `UPDATE partidos SET goles = 2 WHERE id_partido = 3;` → el gol de Emilio Solares contra Aguilas Rapidas se corrigio de 1 a 2 tras revisar el video, sin borrar el registro.
- `DELETE FROM partidos WHERE id_partido = 10;` → el registro duplicado desaparecio; el conteo final es 9, no 10. Este si se elimino porque era un error de captura, no un estado de negocio.

## Aprendizaje

La solicitud pedia explicitamente corregir estados sin borrar informacion importante, y el modelo lo resuelve con `UPDATE` sobre columnas con `CHECK` (`estado`, `goles`, `tarjeta`) en vez de reemplazar filas. Solo se uso `DELETE` para el caso que de verdad era un error de captura (el duplicado), nunca para corregir un dato real del negocio. Con `jugadores` como tabla real ligada a `equipos`, el reporte de riesgo de sancion (consulta 5) tambien queda protegido: si "Andres Vela" se escribiera distinto en un partido, sus tarjetas quedarian repartidas entre dos identidades y el club no veria el riesgo real de suspension.
