# Evidencias - Solicitudes SQL - Ejercicio 086 (Delivery de Comida)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-086.db < ddl/schema.sql
sqlite3 ejercicio-086.db < dml/inserts.sql
sqlite3 ejercicio-086.db < dml/operaciones.sql
sqlite3 ejercicio-086.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 4 clientes, 5 platillos, 2
repartidores, 5 pedidos (2 `entregado` con pago, 1 `en_camino`, 1
marcado `entregado` por error con pago, 1 `recibido`) y 3 pagos.

**Caso comentado verificado:**

- `INSERT INTO pagos (id_pedido, ...) VALUES (1, ...);` (segundo pago para el pedido 1) → `UNIQUE constraint failed: pagos.id_pedido`.

**1. Resumen completo via `vista_pedidos_completos` (ya con el pedido
4 cancelado y sin pago):**

```text
id_pedido | nombre_cliente        | nombre_platillo       | categoria | nombre_repartidor   | cantidad | estado      | monto_pagado
1           | Manuel Estrada          | Hamburguesa Clasica     | comida       | Hugo Marroquin         | 2           | entregado     | 90.0
2           | Alejandra Chinchilla    | Pizza Pepperoni         | comida       | Esteban Cifuentes      | 1           | entregado     | 60.0
3           | Byron Xicay             | Gaseosa                 | bebida       | Hugo Marroquin         | 3           | en_camino     | (NULL)
4           | Cristina Barrios        | Tacos al Pastor         | comida       | Esteban Cifuentes      | 2           | cancelado     | (NULL)
5           | Manuel Estrada          | Flan de Caramelo        | postre       | Hugo Marroquin         | 1           | recibido      | (NULL)
```

**5. Ingresos totales por categoria de menu (para decidir en cual
enfocar promociones):**

```text
categoria    ingresos_totales
comida         150.0
```

(Solo "comida" tiene pagos confirmados; bebida y postre todavia no
generaron ingresos reales.)

## Operaciones de mantenimiento verificadas

- `UPDATE pedidos SET estado = 'cancelado' WHERE id_pedido = 4 ...;` → el pedido de Cristina Barrios se corrigio despues de confirmarse la cancelacion.
- **DELETE controlado**: se elimino el pago que habia quedado invalido en el pedido 4, apenas se marco `cancelado`. Total de pagos: 3 -> 2. Ningun pago de un pedido `entregado` se toco.

## Aprendizaje

Separar catalogos (`clientes`, `menus`, `repartidores`), operacion
(`pedidos`) y resultado (`pagos`) en tablas distintas, tal como pidio
el cliente, hizo que el `UNIQUE (id_pedido)` en `pagos` fuera la unica
restriccion necesaria para evitar pagos duplicados: no hubo que
mezclar esa regla dentro de la tabla de pedidos. La vista
`vista_pedidos_completos`, con `LEFT JOIN` a pagos, mantiene esa
separacion visible en el reporte: un pedido sin pago sigue apareciendo
con `monto_pagado = NULL`, en vez de mezclarse o desaparecer.
