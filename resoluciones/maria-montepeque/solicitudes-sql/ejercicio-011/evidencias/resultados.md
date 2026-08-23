# Evidencias - Solicitudes SQL - Ejercicio 011 (Delivery de Comida)

## Comandos ejecutados

```bash
sqlite3 ejercicio-011.db < ddl/schema.sql
sqlite3 ejercicio-011.db < dml/inserts.sql
sqlite3 ejercicio-011.db < dml/operaciones.sql
sqlite3 ejercicio-011.db < dql/consultas.sql
```

## Resultados

**1. Todos los pedidos (ya con el de prueba eliminado y el estado de Karen Solis corregido):**

```text
id_pedido | id_menu | nombre_cliente   | repartidor    | cantidad | monto_total | fecha_pedido       | estado    | calificacion
1         | 1       | Ana Gomez         | Carlos Ruiz    | 1        | 65.0        | 2026-08-01 12:00   | entregado | 5
2         | 2       | Luis Marroquin    | Pedro Gomez    | 1        | 120.0       | 2026-08-01 13:00   | entregado | 4
3         | 4       | Karen Solis       | Carlos Ruiz    | 2        | 110.0       | 2026-08-02 12:30   | entregado | None
4         | 1       | Ana Gomez         | Sofia Reyes    | 1        | 65.0        | 2026-08-02 13:00   | recibido  | None
5         | 5       | Rosa Chavez       | Pedro Gomez    | 2        | 70.0        | 2026-08-03 14:00   | entregado | 5
6         | 6       | Julio Perez       | Carlos Ruiz    | 3        | 60.0        | 2026-08-03 15:00   | cancelado | None
7         | 2       | Ana Gomez         | Sofia Reyes    | 1        | 120.0       | 2026-08-04 12:00   | entregado | 3
8         | 3       | Luis Marroquin    | Pedro Gomez    | 1        | 45.0        | 2026-08-04 13:00   | en_camino | None
9         | 1       | Diego Paz         | Carlos Ruiz    | 1        | 65.0        | 2026-08-05 12:00   | recibido  | None
```

Quedan 9 pedidos (empezaron 10, se elimino el de prueba del `id_pedido = 10`).

**2. Pedidos que no estan entregados todavia:**

```text
id_pedido | nombre_cliente | repartidor    | fecha_pedido       | estado
4         | Ana Gomez       | Sofia Reyes    | 2026-08-02 13:00   | recibido
6         | Julio Perez     | Carlos Ruiz    | 2026-08-03 15:00   | cancelado
8         | Luis Marroquin  | Pedro Gomez    | 2026-08-04 13:00   | en_camino
9         | Diego Paz       | Carlos Ruiz    | 2026-08-05 12:00   | recibido
```

El pedido de Karen Solis (id 3) ya no aparece aqui porque `operaciones.sql` lo corrigio de `en_camino` a `entregado`.

**3. Cliente con mas pedidos:**

```text
nombre_cliente    | total_pedidos
Ana Gomez           | 3
Luis Marroquin       | 2
Rosa Chavez           | 1
Karen Solis           | 1
Julio Perez           | 1
Diego Paz             | 1
```

**4. Pedidos ordenados por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-05.

**5. Repartidor con mas entregas completadas:**

```text
repartidor       | entregas_completadas
Pedro Gomez        | 2
Carlos Ruiz         | 2
Sofia Reyes          | 1
```

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO pedidos (..., calificacion) VALUES (..., 9);` → `CHECK constraint failed: calificacion BETWEEN 1 AND 5`.

## Operaciones de mantenimiento verificadas

- `UPDATE pedidos SET estado = 'entregado' WHERE id_pedido = 3 AND estado = 'en_camino';` → el pedido de Karen Solis paso de `en_camino` a `entregado`.
- `UPDATE menus SET precio = 130.00 WHERE id_menu = 2;` → la Pizza Familiar subio de 120.00 a 130.00.
- `DELETE FROM pedidos WHERE id_pedido = 10;` → el pedido de prueba desaparecio; el conteo final es 9, no 10.

## Aprendizaje

El problema de duplicados que menciona el cliente ("varias personas duplican datos sin darse cuenta") se previene desde el diseno con `UNIQUE` en `menus.nombre_platillo`, evitando cargar el mismo platillo dos veces con distinto precio. Ademas, dejar `calificacion` sin `NOT NULL` fue una decision deliberada, no un descuido: forzar ese dato en pedidos `recibido` o `en_camino` habria obligado a inventar una calificacion antes de que el cliente realmente reciba su comida. El `CHECK (calificacion BETWEEN 1 AND 5)` garantiza que, cuando el dato si existe, sea un valor real de una escala de 1 a 5, no cualquier numero.
