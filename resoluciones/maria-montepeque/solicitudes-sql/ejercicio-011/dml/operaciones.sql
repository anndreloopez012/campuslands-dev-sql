PRAGMA foreign_keys = ON;

-- Ejercicio 011: Delivery de Comida
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. El pedido de Karen Solis ya se entrego (id_pedido = 3): se corrige
--    el estado de 'en_camino' a 'entregado'. WHERE especifico por PK +
--    estado actual.
UPDATE pedidos
SET estado = 'entregado'
WHERE id_pedido = 3 AND estado = 'en_camino';

-- 2. El negocio ajusta el precio de la Pizza Familiar (id_menu = 2) de
--    120.00 a 130.00.
UPDATE menus
SET precio = 130.00
WHERE id_menu = 2;

-- 3. Se elimina el pedido de prueba (id_pedido = 10): nunca fue un
--    pedido real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM pedidos
WHERE id_pedido = 10;
