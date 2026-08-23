# Evidencias - Solicitudes SQL - Ejercicio 014 (Mecanica de Autos)

## Comandos ejecutados

```bash
sqlite3 ejercicio-014.db < ddl/schema.sql
sqlite3 ejercicio-014.db < dml/inserts.sql
sqlite3 ejercicio-014.db < dml/operaciones.sql
sqlite3 ejercicio-014.db < dql/consultas.sql
```

## Resultados

**1. Todas las reparaciones (ya con la de prueba eliminada y la alineacion completada):**

```text
id_reparacion | id_vehiculo | diagnostico             | costo  | fecha_reparacion  | garantia_dias | estado
1             | 1           | Cambio de frenos          | 450.0  | 2026-08-10 09:00   | 30             | completada
2             | 2           | Diagnostico de motor      | 200.0  | 2026-08-11 10:00   | 15             | completada
3             | 3           | Cambio de bateria         | 350.0  | 2026-08-11 14:00   | 90             | completada
4             | 1           | Alineacion y balanceo     | 180.0  | 2026-08-12 08:30   | 30             | completada
5             | 4           | Cambio de aceite          | 120.0  | 2026-08-13 11:00   | 30             | completada
6             | 5           | Reparacion de transmision | 1200.0 | 2026-08-14 09:00   | 60             | cancelada
7             | 2           | Cambio de llantas         | 800.0  | 2026-08-15 10:00   | 90             | completada
8             | 3           | Revision electrica        | 150.0  | 2026-08-16 12:00   | 15             | en_proceso
```

Quedan 8 reparaciones (empezaron 9, se elimino la entrada de prueba del `id_reparacion = 9`).

**2. Reparaciones que no estan completadas todavia:**

```text
id_reparacion | id_vehiculo | diagnostico             | costo  | fecha_reparacion  | estado
6             | 5           | Reparacion de transmision | 1200.0 | 2026-08-14 09:00   | cancelada
8             | 3           | Revision electrica        | 150.0  | 2026-08-16 12:00   | en_proceso
```

**3. Vehiculo con mas reparaciones:**

```text
placa    | marca      | modelo   | total_reparaciones
P111AAA   | Toyota      | Corolla   | 2
P222BBB   | Honda       | Civic     | 2
P333CCC   | Nissan      | Sentra    | 2
P444DDD   | Ford        | Focus     | 1
P555EEE   | Chevrolet   | Spark     | 1
```

**4. Reparaciones ordenadas por fecha:** ver tabla completa arriba, de 2026-08-10 a 2026-08-16.

**5. Reporte semanal para el taller: ingresos por dia (solo completadas):**

```text
dia         | ingresos_del_dia | reparaciones_completadas
2026-08-10  | 450.0             | 1
2026-08-11  | 550.0             | 2
2026-08-12  | 180.0             | 1
2026-08-13  | 120.0             | 1
2026-08-15  | 800.0             | 1
```

El 2026-08-15 fue el dia de mas ingresos de la semana (cambio de llantas, un solo trabajo grande).

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO reparaciones (id_vehiculo, diagnostico, costo) VALUES (2, 'Revision gratuita', 0);` → `CHECK constraint failed: costo > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE reparaciones SET estado = 'completada' WHERE id_reparacion = 4 AND estado = 'en_proceso';` → la alineacion y balanceo del vehiculo 1 paso de `en_proceso` a `completada`.
- `UPDATE vehiculos SET nombre_dueno = 'Karla Diaz Lopez' WHERE id_vehiculo = 4;` → se corrigio el nombre incompleto del dueno.
- `DELETE FROM reparaciones WHERE id_reparacion = 9;` → la entrada de prueba desaparecio; el conteo final es 8, no 9.

## Aprendizaje

El reporte que pidio el cliente ("un reporte rapido para tomar decisiones al final de cada semana") se resuelve con la misma tecnica del ejercicio de la tienda de sneakers: agrupar por `date(fecha_reparacion)` y sumar solo lo que representa dinero real (`estado = 'completada'`). La reparacion cancelada de 1200.0 (la mas cara de todas) correctamente no aparece en el reporte de ingresos; incluirla habria inflado el numero y llevado al taller a una decision equivocada sobre cuanto realmente factura por semana.
