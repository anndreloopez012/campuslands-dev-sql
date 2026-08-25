PRAGMA foreign_keys = ON;

-- Ejercicio 061: Delivery de Comida
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se asigna repartidor al pedido 7 (estaba pendiente
-- sin repartidor) y pasa a 'en_camino'.
UPDATE pedidos
SET id_repartidor = 2,
    estado = 'en_camino'
WHERE id_pedido = 7;

-- 1 UPDATE de estado: el pago del pedido 4 se confirma como pagado una
-- vez que el pedido se entrega.
UPDATE pagos
SET estado_pago = 'pagado'
WHERE id_pedido = 4;

-- 1 DELETE controlado: se elimina un pedido cancelado que nunca genero
-- pago (no rompe integridad referencial porque no existe fila en pagos
-- para id_pedido = 9).
DELETE FROM pedidos
WHERE id_pedido = 9 AND estado = 'cancelado';

-- Caso que debe fallar (queda comentado): eliminar un cliente que tiene
-- pedidos asociados viola la FOREIGN KEY de pedidos.id_cliente.
-- DELETE FROM clientes WHERE id_cliente = 1;
