# Evidencias - Solicitudes SQL - Ejercicio 008 (Viajes y Paracaidismo)

## Comandos ejecutados

```bash
sqlite3 ejercicio-008.db < ddl/schema.sql
sqlite3 ejercicio-008.db < dml/inserts.sql
sqlite3 ejercicio-008.db < dml/operaciones.sql
sqlite3 ejercicio-008.db < dql/consultas.sql
```

## Resultados

**1. Todas las reservas (ya con la de prueba eliminada y el estado de Karen Solis corregido):**

```text
id_reserva | id_experiencia | nombre_cliente   | fecha_reserva | monto_pagado | estado
1          | 1               | Ana Gomez         | 2026-07-01     | 1500.0        | completada
2          | 3               | Luis Marroquin    | 2026-07-05     | 2200.0        | completada
3          | 2               | Karen Solis       | 2026-07-10     | 1800.0        | confirmada
4          | 1               | Diego Paz         | 2026-07-12     | 1500.0        | confirmada
5          | 4               | Rosa Chavez       | 2026-07-15     | 3200.0        | completada
6          | 5               | Julio Perez       | 2026-07-18     | 950.0         | cancelada
7          | 1               | Ana Gomez         | 2026-07-20     | 1500.0        | pendiente
8          | 2               | Luis Marroquin    | 2026-07-22     | 1800.0        | completada
```

Quedan 8 reservas (empezaron 9, se elimino la entrada de prueba del `id_reserva = 9`).

**2. Casos pendientes (tal como pidio el cliente):**

```text
id_reserva | id_experiencia | nombre_cliente | fecha_reserva
7          | 1               | Ana Gomez       | 2026-07-20
```

Karen Solis ya no aparece aqui porque `operaciones.sql` corrigio su reserva de `pendiente` a `confirmada`.

**3. Ranking: experiencia con mas reservas:**

```text
nombre_experiencia            | total_reservas
Salto en Paracaidas Nivel 1     | 3
Salto en Paracaidas Tandem      | 2
Tour Volcanes Guatemala         | 1
Aventura Selva Peten            | 1
Ruta Cafetera                   | 1
```

**4. Reservas ordenadas por fecha:** ver tabla completa arriba, de 2026-07-01 a 2026-07-22.

**5. Totales: cuanto genera cada experiencia (sin contar canceladas):**

```text
nombre_experiencia            | tipo          | total_generado
Salto en Paracaidas Nivel 1     | paracaidismo   | 4500.0
Salto en Paracaidas Tandem      | paracaidismo   | 3600.0
Aventura Selva Peten             | viaje          | 3200.0
Tour Volcanes Guatemala          | turismo        | 2200.0
```

`Ruta Cafetera` no aparece en el reporte de totales porque su unica reserva esta `cancelada`; el `WHERE r.estado <> 'cancelada'` la excluye correctamente.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO experiencias (nombre_experiencia, tipo, precio) VALUES ('Buceo en Arrecife', 'buceo', 1200.00);` → `CHECK constraint failed: tipo IN ('viaje', 'paracaidismo', 'turismo')`.

## Operaciones de mantenimiento verificadas

- `UPDATE reservas SET estado = 'confirmada' WHERE id_reserva = 3 AND estado = 'pendiente';` → la reserva de Karen Solis paso de `pendiente` a `confirmada`.
- `UPDATE experiencias SET precio = 1900.00 WHERE id_experiencia = 2;` → el precio del salto en tandem subio de 1800.00 a 1900.00.
- `DELETE FROM reservas WHERE id_reserva = 9;` → la entrada de prueba desaparecio; el conteo final de reservas es 8, no 9.

## Aprendizaje

Las tres cosas que pidio el cliente ("rankings, totales y casos pendientes") salen de la misma tabla `reservas` con enfoques distintos: el ranking agrupa por experiencia y cuenta filas (`COUNT`), el total agrupa y suma dinero (`SUM`) filtrando lo que no representa ingreso real (`estado <> 'cancelada'`), y los casos pendientes son un simple `WHERE estado = 'pendiente'`. Ninguna de las tres consultas necesito una tabla nueva: el diseño de `estado` como una columna con valores controlados por `CHECK` es lo que hace posible responder las tres preguntas del cliente sin tener que reestructurar el modelo.
