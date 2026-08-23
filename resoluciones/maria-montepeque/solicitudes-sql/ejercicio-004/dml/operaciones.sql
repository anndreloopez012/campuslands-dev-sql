PRAGMA foreign_keys = ON;

-- Ejercicio 004: Tienda Sneakers
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Karen Solis ya recibio su Jordan Retro 1 (id_pedido = 3): se corrige
--    el estado de 'enviado' a 'entregado'. WHERE especifico por PK +
--    estado actual.
UPDATE pedidos
SET estado = 'entregado'
WHERE id_pedido = 3 AND estado = 'enviado';

-- 2. Llego un reabastecimiento de Yeezy Boost 350 (id_producto = 6), el
--    modelo con menos stock: se suman 10 unidades.
UPDATE productos
SET stock = stock + 10
WHERE id_producto = 6;

-- 3. Se elimina el pedido duplicado (id_pedido = 8): es una copia exacta
--    del pedido 2 por error de digitacion. DELETE seguro porque usa el id
--    exacto de la fila.
DELETE FROM pedidos
WHERE id_pedido = 8;
