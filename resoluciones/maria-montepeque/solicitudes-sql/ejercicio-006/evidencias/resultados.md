# Evidencias - Solicitudes SQL - Ejercicio 006 (Renta Autos de Lujo)

## Comandos ejecutados

```bash
sqlite3 ejercicio-006.db < ddl/schema.sql
sqlite3 ejercicio-006.db < dml/inserts.sql
sqlite3 ejercicio-006.db < dml/operaciones.sql
sqlite3 ejercicio-006.db < dql/consultas.sql
```

## Resultados

**1. Todas las reservas (ya con la de prueba eliminada y el estado de Tomas Blanco corregido):**

```text
id_reserva | id_vehiculo | nombre_cliente   | fecha_inicio | fecha_fin  | monto_total | estado
1          | 1           | Jorge Alvarado    | 2026-08-10   | 2026-08-12 | 2400.0      | finalizada
2          | 3           | Rosa Mendez       | 2026-08-11   | 2026-08-14 | 2400.0      | finalizada
3          | 2           | Tomas Blanco      | 2026-08-15   | 2026-08-17 | 2800.0      | finalizada
4          | 4           | Karla Diaz        | 2026-08-16   | 2026-08-18 | 1900.0      | confirmada
5          | 5           | Julio Perez       | 2026-08-18   | 2026-08-20 | 2200.0      | confirmada
6          | 1           | Rosa Mendez       | 2026-08-20   | 2026-08-21 | 1200.0      | cancelada
7          | 3           | Jorge Alvarado    | 2026-08-22   | 2026-08-23 | 800.0       | confirmada
9          | 4           | Jorge Alvarado    | 2026-08-24   | 2026-08-25 | 950.0       | confirmada
```

Quedan 8 reservas (empezaron 9, se elimino la reserva de prueba del `id_reserva = 8`).

**2. Reservas que todavia no terminan:**

```text
id_reserva | id_vehiculo | nombre_cliente | fecha_inicio | estado
4          | 4           | Karla Diaz      | 2026-08-16   | confirmada
5          | 5           | Julio Perez     | 2026-08-18   | confirmada
6          | 1           | Rosa Mendez     | 2026-08-20   | cancelada
7          | 3           | Jorge Alvarado  | 2026-08-22   | confirmada
9          | 4           | Jorge Alvarado  | 2026-08-24   | confirmada
```

Tomas Blanco ya no aparece aqui porque `operaciones.sql` corrigio su reserva de `en_curso` a `finalizada`.

**3. Cliente que mas reserva:**

```text
nombre_cliente   | total_reservas
Jorge Alvarado     | 3
Rosa Mendez         | 2
Tomas Blanco        | 1
Karla Diaz          | 1
Julio Perez         | 1
```

**4. Reservas ordenadas por fecha de inicio:** ver tabla completa arriba, de 2026-08-10 a 2026-08-24.

**5. Reporte para la empresa: ingresos por vehiculo (sin contar canceladas):**

```text
marca            | modelo        | placa    | ingresos_generados | reservas_validas
Porsche            | 911 Carrera    | LUX-003  | 3200.0              | 2
Mercedes-Benz       | AMG GT         | LUX-004  | 2850.0              | 2
Lamborghini         | Huracan        | LUX-002  | 2800.0              | 1
Ferrari             | 488 GTB        | LUX-001  | 2400.0              | 1
Aston Martin        | DB11           | LUX-005  | 2200.0              | 1
```

El Porsche 911 es el vehiculo que mas ingresos genera, buen candidato para mantener en la flota.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO reservas (..., monto_total) VALUES (..., 0);` → `CHECK constraint failed: monto_total > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE reservas SET estado = 'finalizada' WHERE id_reserva = 3 AND estado = 'en_curso';` → la reserva de Tomas Blanco paso de `en_curso` a `finalizada`.
- `UPDATE vehiculos SET estado = 'mantenimiento' WHERE id_vehiculo = 1;` → el Ferrari 488 GTB paso de `disponible` a `mantenimiento`.
- `DELETE FROM reservas WHERE id_reserva = 8;` → la reserva de prueba desaparecio; el conteo final de reservas es 8, no 9.

## Aprendizaje

La peticion del cliente ("diferenciar catalogos, operaciones y resultados para no mezclar informacion permanente con movimientos") se traduce directamente en dos tablas con responsabilidades distintas: `vehiculos` es el catalogo permanente (cambia poco, solo cuando un auto entra o sale de servicio) y `reservas` es el movimiento (cambia todos los dias). Por eso cada tabla tiene su propio `estado` con significados distintos: el de `vehiculos` describe disponibilidad fisica del auto ahora mismo, el de `reservas` describe el avance de un alquiler puntual en el tiempo. Mezclarlos en una sola tabla habria obligado a repetir marca/modelo/precio en cada reserva, justo el problema que el cliente queria evitar.
