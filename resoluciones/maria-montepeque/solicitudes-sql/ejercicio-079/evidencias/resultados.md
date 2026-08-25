# Evidencias - Solicitudes SQL - Ejercicio 079 (Tienda Sneakers)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-079.db < ddl/schema.sql
sqlite3 ejercicio-079.db < dml/inserts.sql
sqlite3 ejercicio-079.db < dml/operaciones.sql
sqlite3 ejercicio-079.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 4 clientes, 4 productos, 5 tallas,
4 pedidos (2 `entregado`, 1 `enviado`, 1 `pendiente`) y 7 lineas de
detalle (incluye el Ultraboost talla 41 agregado por error en el
pedido 4).

**Caso comentado verificado:**

- `INSERT INTO detalle_pedidos (id_pedido, id_producto, id_talla, ...) VALUES (1, 1, 3, ...);` (segunda linea de Air Max 90 talla 3 en el pedido 1) → `UNIQUE constraint failed: detalle_pedidos.id_pedido, detalle_pedidos.id_producto, detalle_pedidos.id_talla`.

**3. Cliente con mas pedidos:** los 4 clientes tienen exactamente 1
pedido cada uno.

**5. Productos mas pedidos por unidades (para decidir cuales
reabastecer primero):**

```text
nombre_producto    unidades_pedidas
Air Max 90           3
Superstar            2
Chuck Taylor         1
Ultraboost           1
```

## Operaciones de mantenimiento verificadas

- **DELETE controlado**: se elimino el Ultraboost talla 41 agregado por error en el pedido 4, mientras este seguia `pendiente`. El pedido 4 quedo solo con Superstar talla 39.
- `UPDATE pedidos SET estado = 'confirmado' WHERE id_pedido = 4 ...;` → el pedido de Cristina Barrios, ya corregido, se confirmo.

## Aprendizaje

El `UNIQUE (id_pedido, id_producto, id_talla)` en `detalle_pedidos`
evita registrar el mismo producto en la misma talla dos veces como
linea separada en el mismo pedido. El `DELETE` controlado de este
ejercicio solo se aplica mientras un pedido sigue `pendiente`: una vez
que pasa a `confirmado` en adelante, sus lineas ya son parte del
historico de auditoria que pidio el cliente y no se borran. Los
estados se corrigen siempre con `UPDATE`, nunca eliminando y
recreando el pedido, para que en una auditoria siempre se pueda
reconstruir que se pidio y cuando paso.
