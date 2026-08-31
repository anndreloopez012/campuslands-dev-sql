PRAGMA foreign_keys = ON;

-- Ejercicio 086: Delivery de Comida
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se confirma que Cristina Barrios cancelo el
-- pedido 4 antes de que saliera el repartidor.
UPDATE pedidos
SET estado = 'cancelado'
WHERE id_pedido = 4 AND estado = 'entregado';

-- 1 DELETE controlado: el pago del pedido 4 quedo invalido apenas se
-- corrigio el estado (el pedido nunca se entrego de verdad). Solo se
-- borran pagos de pedidos 'cancelado'; un pedido 'entregado' nunca
-- pierde su pago por este DELETE.
DELETE FROM pagos
WHERE id_pedido IN (
    SELECT id_pedido FROM pedidos WHERE estado = 'cancelado'
);

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar el pago del pedido 1, que ya esta 'entregado' (resultado
-- oficial). El DELETE de arriba solo alcanza pedidos 'cancelado' por
-- diseno.
-- DELETE FROM pagos WHERE id_pedido = 1;
