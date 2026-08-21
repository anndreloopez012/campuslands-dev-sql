# Evidencias - Solicitudes SQL - Ejercicio 036 (Delivery de Comida)

## Comandos ejecutados

```bash
sqlite3 ejercicio-036.db < ddl/schema.sql
sqlite3 ejercicio-036.db < dml/inserts.sql
sqlite3 ejercicio-036.db < dml/operaciones.sql
sqlite3 ejercicio-036.db < dql/consultas.sql
```

## Resultados

**1. Todos los pedidos, con JOIN doble a clientes y menus (ya sin el duplicado, con el pedido 4 en camino y el pedido 3 entregado y calificado):**

```text
id_pedido | nombre_cliente     | nombre_platillo          | repartidor    | fecha_pedido | monto_pagado | estado     | calificacion
1         | Mariana Castillo   | Pizza Pepperoni Familiar | Kevin Ajpop   | 2026-08-10    | 120.0         | entregado  | 5
2         | Estuardo Perez     | Hamburguesa Doble        | Kevin Ajpop   | 2026-08-11    | 65.0          | entregado  | 4
3         | Lucia Ramirez      | Tacos al Pastor x6       | Sara Tuy      | 2026-08-12    | 50.0          | entregado  | 4
4         | Mariana Castillo   | Tres Leches              | Kevin Ajpop   | 2026-08-12    | 30.0          | en_camino  | (vacio)
5         | Hector Gonzalez    | Alitas BBQ               | Sara Tuy      | 2026-08-13    | 45.0          | entregado  | 3
6         | Paola Enriquez     | Pasta Alfredo            | Rene Xitumul  | 2026-08-14    | 58.0          | entregado  | 5
7         | Estuardo Perez     | Limonada Frozen          | Kevin Ajpop   | 2026-08-14    | 18.0          | cancelado  | (vacio)
8         | Lucia Ramirez      | Pupusas Revueltas        | Sara Tuy      | 2026-08-15    | 25.0          | entregado  | 2
9         | Mariana Castillo   | Hamburguesa Doble        | Rene Xitumul  | 2026-08-16    | 65.0          | pendiente  | (vacio)
```

Quedan 9 pedidos (empezaron 10, se elimino el duplicado del `id_pedido = 10`).

**2. Pedidos que no estan entregados todavia:**

```text
id_pedido | id_cliente | id_menu | monto_pagado | estado
4         | 1          | 6       | 30.0          | en_camino
7         | 2          | 7       | 18.0          | cancelado
9         | 1          | 3       | 65.0          | pendiente
```

**3. Cliente con mas pedidos:**

```text
nombre_cliente     | total_pedidos
Mariana Castillo   | 3
Estuardo Perez     | 2
Lucia Ramirez       | 2
Hector Gonzalez     | 1
Paola Enriquez      | 1
```

**4. Pedidos ordenados por fecha:** ver tabla completa arriba, de 2026-08-10 a 2026-08-16.

**5. Calificacion promedio por repartidor (solo pedidos ya calificados), para decidir a quien asignar mas pedidos:**

```text
repartidor      | promedio_calificacion | pedidos_calificados
Rene Xitumul    | 5.0                    | 1
Kevin Ajpop     | 4.5                    | 2
Sara Tuy        | 3.0                    | 3
```

Con este reporte el negocio puede decidir asignarle mas pedidos a Rene Xitumul y Kevin Ajpop, y revisar con Sara Tuy por que su promedio es el mas bajo.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO pedidos (..., calificacion) VALUES (..., 6);` → `CHECK constraint failed: calificacion IS NULL OR (calificacion BETWEEN 1 AND 5)`.

## Operaciones de mantenimiento verificadas

- `UPDATE pedidos SET estado = 'en_camino' WHERE id_pedido = 4 AND estado = 'pendiente';` → el pedido de Tres Leches para Mariana Castillo paso de `pendiente` a `en_camino`.
- `UPDATE pedidos SET estado = 'entregado', calificacion = 4 WHERE id_pedido = 3;` → el pedido de tacos para Lucia Ramirez quedo `entregado` y calificado con 4.
- `DELETE FROM pedidos WHERE id_pedido = 10;` → el pedido duplicado desaparecio; el conteo final es 9, no 10.

## Aprendizaje

Con `clientes` y `menus` como catalogos reales (no como texto dentro del pedido), el reporte de calificacion promedio por repartidor (consulta 5) queda protegido del problema que le importa al negocio: si "Kevin Ajpop" se escribiera con una variacion minima en un pedido, ese pedido quedaria fuera de su promedio y la decision de a quien asignar mas trabajo se basaria en datos incompletos. Separar catalogos (clientes, menus) de movimientos (pedidos), tal como pidio el cliente, es lo que permite que estos reportes sean confiables.
