# Evidencias - Solicitudes SQL - Ejercicio 054 (Tienda Sneakers)

## Comandos ejecutados

```bash
sqlite3 ejercicio-054.db < ddl/schema.sql
sqlite3 ejercicio-054.db < dml/inserts.sql
sqlite3 ejercicio-054.db < dml/operaciones.sql
sqlite3 ejercicio-054.db < dql/consultas.sql
```

## Resultados

**1. Todos los pedidos, con JOIN triple a clientes, tallas y productos (ya sin el duplicado, sin el pedido cancelado que nunca afecto stock, con el pedido 4 confirmado y el pedido 3 enviado):**

```text
id_pedido | nombre_cliente    | nombre_producto  | numero_talla | fecha_pedido | cantidad | estado
1          | Fabiola Mendez    | Air Max Pulse     | 25            | 2026-08-01     | 1         | enviado
2          | Sergio Barrios    | Ultraboost 22     | 24            | 2026-08-02     | 2         | enviado
3          | Ninoska Tul       | Suede Classic     | 23            | 2026-08-03     | 1         | enviado
4          | Cristian Lopez    | 550 Retro         | 26            | 2026-08-04     | 1         | confirmado
5          | Fabiola Mendez    | Old Skool         | 24            | 2026-08-05     | 2         | enviado
6          | Yesica Morataya   | Old Skool         | 27            | 2026-08-06     | 1         | pendiente
8          | Ninoska Tul       | Ultraboost 22     | 27            | 2026-08-08     | 1         | cancelado
9          | Cristian Lopez    | Air Max Pulse     | 27            | 2026-08-09     | 1         | pendiente
10         | Fabiola Mendez    | Suede Classic     | 25            | 2026-08-10     | 1         | pendiente
```

Quedan 9 pedidos (empezaron 11: se elimino el duplicado `id_pedido = 11` y el cancelado sin stock descontado `id_pedido = 7`).

**2. Pedidos que no estan enviados todavia:**

```text
id_pedido | id_cliente | id_talla | fecha_pedido | estado
4          | 4          | 7         | 2026-08-04     | confirmado
6          | 5          | 9         | 2026-08-06     | pendiente
8          | 3          | 4         | 2026-08-08     | cancelado
9          | 4          | 10        | 2026-08-09     | pendiente
10         | 1          | 6         | 2026-08-10     | pendiente
```

**3. Cliente con mas pedidos:**

```text
nombre_cliente    | total_pedidos
Fabiola Mendez     | 3
Cristian Lopez     | 2
Ninoska Tul        | 2
Sergio Barrios     | 1
Yesica Morataya    | 1
```

**4. Pedidos ordenados por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-10.

**5. Pedidos pendientes o confirmados con menos stock disponible en su talla, para decidir a cuales atender o reabastecer primero (el reporte semanal que pidio el cliente):**

```text
nombre_cliente    | nombre_producto  | numero_talla | cantidad | stock_disponible | estado
Cristian Lopez     | Air Max Pulse     | 27            | 1         | 0                  | pendiente
Yesica Morataya    | Old Skool         | 27            | 1         | 2                  | pendiente
Cristian Lopez     | 550 Retro         | 26            | 1         | 3                  | confirmado
Fabiola Mendez     | Suede Classic     | 25            | 1         | 6                  | pendiente
```

El pedido de Cristian Lopez por el Air Max Pulse talla 27 es el mas urgente: su talla esta completamente agotada (stock = 0) y el pedido sigue sin confirmar.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO tallas (id_producto, numero_talla, ...) VALUES (1, 25, ...);` → `UNIQUE constraint failed: tallas.id_producto, tallas.numero_talla`.
- Valor fuera de rango: `INSERT INTO tallas (..., numero_talla, ...) VALUES (..., 50, ...);` → `CHECK constraint failed: numero_talla BETWEEN 20 AND 33`.

## Operaciones de mantenimiento verificadas

- `UPDATE pedidos SET estado = 'confirmado', stock_descontado = 1 WHERE id_pedido = 4 AND estado = 'pendiente';` + `UPDATE tallas SET stock = stock - 1 WHERE id_talla = 7;` → el pedido de Cristian Lopez quedo `confirmado` y el stock de esa talla bajo de 4 a 3.
- `UPDATE pedidos SET estado = 'enviado' WHERE id_pedido = 3 AND estado = 'confirmado';` → el pedido de Ninoska Tul quedo `enviado`.
- `DELETE FROM pedidos WHERE id_pedido = 7 AND estado = 'cancelado' AND stock_descontado = 0;` → **DELETE controlado**: elimino unicamente el pedido 7 (cancelado, nunca afecto el inventario). El pedido 8, tambien cancelado pero con `stock_descontado = 1`, no se toco: sigue como historial pendiente de que alguien devuelva el stock manualmente.
- `DELETE FROM pedidos WHERE id_pedido = 11;` → el pedido duplicado desaparecio. Conteo final verificado: 9 pedidos (empezaron 11).

## Aprendizaje

La columna `stock_descontado` convierte una decision ambigua ("¿este pedido cancelado se puede borrar?") en una condicion verificable: solo si nunca toco el inventario. Eso protege a la tienda de perder el rastro de un pedido cancelado que si afecto el stock, y el reporte semanal (consulta 5) usa ese mismo stock en tiempo real para mostrar, sin calculos manuales, cual pedido esta en riesgo por falta de inventario.
