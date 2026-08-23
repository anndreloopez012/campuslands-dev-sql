# Evidencias - Solicitudes SQL - Ejercicio 001 (Cafeteria Campus)

## Comandos ejecutados

```bash
sqlite3 ejercicio-001.db < ddl/schema.sql
sqlite3 ejercicio-001.db < dml/inserts.sql
sqlite3 ejercicio-001.db < dml/operaciones.sql
sqlite3 ejercicio-001.db < dql/consultas.sql
```

## Resultados

**1. Todas las ventas (ya con la duplicada eliminada y el pago de Karen Solis corregido):**

```text
id_venta | id_producto | nombre_cliente  | cantidad | precio_pagado | fecha_venta       | estado
1        | 1           | Ana Gomez       | 2        | 17.0          | 2026-08-10 08:15  | pagada
2        | 2           | Luis Marroquin  | 1        | 25.0          | 2026-08-10 12:30  | pagada
3        | 1           | Karen Solis     | 1        | 8.5           | 2026-08-10 09:00  | pagada
4        | 4           | Ana Gomez       | 1        | 10.0          | 2026-08-11 08:00  | pagada
5        | 3           | Diego Paz       | 2        | 24.0          | 2026-08-11 13:00  | pagada
6        | 5           | Rosa Chavez     | 1        | 15.0          | 2026-08-12 09:30  | cancelada
7        | 6           | Ana Gomez       | 3        | 27.0          | 2026-08-12 15:00  | pagada
```

Quedan 7 ventas (empezaron 8, se elimino la duplicada del `id_venta = 8`).

**2. Ventas que no se cobraron (canceladas; ya no hay pendientes porque se corrigio la de Karen Solis):**

```text
id_venta | nombre_cliente | precio_pagado | fecha_venta       | estado
6        | Rosa Chavez    | 15.0          | 2026-08-12 09:30  | cancelada
```

**3. Cliente con mas actividad (mas compras pagadas):**

```text
nombre_cliente   | total_compras_pagadas
Ana Gomez         | 3
Luis Marroquin    | 1
Karen Solis       | 1
Diego Paz         | 1
```

Ana Gomez es la clienta mas frecuente.

**4. Ventas ordenadas por fecha:** ver tabla completa arriba, ordenada de 2026-08-10 a 2026-08-12.

**5. Reporte para el cliente: ingresos por producto (solo ventas pagadas):**

```text
nombre_producto        | categoria | total_recaudado | ventas_pagadas
Galletas artesanales   | snack     | 27.0             | 1
Cafe americano         | bebida    | 25.5             | 2
Sandwich de pollo      | comida    | 25.0             | 1
Papas fritas           | snack     | 24.0             | 1
Jugo natural           | bebida    | 10.0             | 1
```

El cafe es el producto que mas veces se vende (2 ventas pagadas), aunque las galletas generan un poco mas de ingreso total en este corte.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO productos (nombre_producto, precio, categoria) VALUES ('Agua embotellada', 5.00, 'liquido');` → `CHECK constraint failed: categoria IN ('bebida', 'comida', 'snack')`.

## Operaciones de mantenimiento verificadas

- `UPDATE ventas SET estado = 'pagada' WHERE id_venta = 3 AND estado = 'pendiente';` → la venta de Karen Solis paso de `pendiente` a `pagada` (visible en el resultado de la consulta 1).
- `UPDATE productos SET stock = stock + 30 WHERE id_producto = 1;` → el stock de Cafe americano aumento de 50 a 80.
- `DELETE FROM ventas WHERE id_venta = 8;` → la venta duplicada (copia exacta de la venta 2) desaparecio; el conteo final de ventas es 7, no 8.

## Aprendizaje

El problema real del cliente ("varias personas duplican datos sin darse cuenta") se puede reproducir y resolver con SQL basico: se inserta la duplicada a proposito (venta 8, identica a la venta 2) y despues se elimina con un `DELETE` que usa el `id_venta` exacto, nunca un filtro amplio que pudiera borrar mas de lo debido. De la misma forma, el estado de una venta no se "arregla" borrando y volviendo a insertar: se usa `UPDATE ... WHERE id_venta = X AND estado = 'pendiente'` para dejar registro de que la venta existio y solo cambiar su estado, conservando el historial que el cliente pidio poder consultar.
