PRAGMA foreign_keys = ON;

-- Ejercicio 079: Tienda Sneakers
-- Operaciones de mantenimiento sobre los datos base.

-- 1 DELETE controlado: el pedido 4 todavia esta 'pendiente' (sin
-- confirmar), asi que es seguro corregir el Ultraboost talla 41 que
-- se agrego por error.
DELETE FROM detalle_pedidos
WHERE id_pedido = 4 AND id_producto = 4 AND id_talla = 4;

-- 1 UPDATE de estado: el pedido 4 se confirma una vez corregido.
UPDATE pedidos
SET estado = 'confirmado'
WHERE id_pedido = 4 AND estado = 'pendiente';

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar una linea del pedido 1, que ya esta 'entregado' (parte del
-- historico de auditoria). El DELETE de arriba solo se aplico
-- mientras el pedido 4 seguia 'pendiente', por diseno: el cliente
-- pidio conservar el historico para auditorias, y un pedido
-- confirmado en adelante ya es informacion de auditoria.
-- DELETE FROM detalle_pedidos WHERE id_pedido = 1 AND id_producto = 1 AND id_talla = 3;
