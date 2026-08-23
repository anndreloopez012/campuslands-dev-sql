# Evidencias - Solicitudes SQL - Ejercicio 004 (Tienda Sneakers)

## Comandos ejecutados

```bash
sqlite3 ejercicio-004.db < ddl/schema.sql
sqlite3 ejercicio-004.db < dml/inserts.sql
sqlite3 ejercicio-004.db < dml/operaciones.sql
sqlite3 ejercicio-004.db < dql/consultas.sql
```

## Resultados

**1. Todos los pedidos (ya con la duplicada eliminada y el estado de Karen corregido):**

```text
id_pedido | id_producto | nombre_cliente   | cantidad | precio_total | fecha_pedido       | estado
1         | 1           | Ana Gomez         | 1        | 450.0        | 2026-08-10 10:00   | entregado
2         | 3           | Luis Marroquin    | 1        | 520.0        | 2026-08-11 11:00   | entregado
3         | 4           | Karen Solis       | 1        | 680.0        | 2026-08-11 15:00   | entregado
4         | 2           | Ana Gomez         | 2        | 900.0        | 2026-08-12 09:00   | pendiente
5         | 5           | Diego Paz         | 1        | 320.0        | 2026-08-13 14:00   | entregado
6         | 6           | Rosa Chavez       | 1        | 750.0        | 2026-08-14 10:30   | cancelado
7         | 1           | Luis Marroquin    | 1        | 450.0        | 2026-08-15 12:00   | entregado
9         | 2           | Luis Marroquin    | 1        | 450.0        | 2026-08-16 09:00   | pendiente
```

Quedan 8 pedidos (empezaron 9, se elimino la duplicada del `id_pedido = 8`).

**2. Pedidos que todavia no llegan al cliente (pendientes o cancelados):**

```text
id_pedido | nombre_cliente   | precio_total | fecha_pedido       | estado
4         | Ana Gomez         | 900.0        | 2026-08-12 09:00   | pendiente
6         | Rosa Chavez       | 750.0        | 2026-08-14 10:30   | cancelado
9         | Luis Marroquin    | 450.0        | 2026-08-16 09:00   | pendiente
```

Karen Solis ya no aparece aqui porque `operaciones.sql` corrigio su pedido de `enviado` a `entregado`.

**3. Cliente con mas actividad en la semana:**

```text
nombre_cliente    | total_pedidos
Luis Marroquin      | 3
Ana Gomez           | 2
Rosa Chavez          | 1
Karen Solis          | 1
Diego Paz            | 1
```

**4. Pedidos ordenados por fecha:** ver tabla completa arriba, ordenada de 2026-08-10 a 2026-08-16.

**5. Reporte semanal para el cliente: ingresos por dia (solo pedidos entregados):**

```text
dia         | ingresos_del_dia | pedidos_entregados
2026-08-10  | 450.0            | 1
2026-08-11  | 1200.0           | 2
2026-08-13  | 320.0            | 1
2026-08-15  | 450.0            | 1
```

El 2026-08-11 fue el dia de mas ingresos de la semana (dos pedidos entregados: Ultraboost 22 y Jordan Retro 1).

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO productos (nombre_modelo, talla, precio) VALUES ('Air Max 90', 60, 450.00);` → `CHECK constraint failed: talla BETWEEN 20 AND 46`.

## Operaciones de mantenimiento verificadas

- `UPDATE pedidos SET estado = 'entregado' WHERE id_pedido = 3 AND estado = 'enviado';` → el pedido de Karen Solis paso de `enviado` a `entregado`.
- `UPDATE productos SET stock = stock + 10 WHERE id_producto = 6;` → el stock de Yeezy Boost 350 aumento de 3 a 13.
- `DELETE FROM pedidos WHERE id_pedido = 8;` → el pedido duplicado (copia exacta del pedido 2) desaparecio; el conteo final de pedidos es 8, no 9.

## Aprendizaje

El pedido del cliente ("un reporte rapido para tomar decisiones al final de cada semana") se resuelve agrupando `pedidos` por dia con `date(fecha_pedido)` y filtrando solo los pedidos `entregado` (los que ya representan ingreso real, no una promesa de venta pendiente o cancelada). Esta consulta solo es confiable porque `fecha_pedido` y `precio_total` son `NOT NULL` con `CHECK` de rango: si algun pedido tuviera un precio en cero o una fecha vacia, el reporte semanal quedaria incompleto sin que el cliente lo notara. Igual que en los ejercicios anteriores, la duplicada se resolvio con un `DELETE` que apunta al `id_pedido` exacto, y el cambio de estado se hizo con `UPDATE` para no perder el historial del pedido.
