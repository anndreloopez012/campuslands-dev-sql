PRAGMA foreign_keys = ON;

-- Ejercicio 036: Delivery de Comida
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Kevin Ajpop recogio el pedido de Tres Leches para Mariana
--    Castillo (id_pedido = 4): se corrige el estado de 'pendiente' a
--    'en_camino'. WHERE especifico por PK + estado actual.
UPDATE pedidos
SET estado = 'en_camino'
WHERE id_pedido = 4 AND estado = 'pendiente';

-- 2. El pedido de tacos para Lucia Ramirez (id_pedido = 3) se entrego
--    y la clienta lo califico con 4 estrellas.
UPDATE pedidos
SET estado = 'entregado',
    calificacion = 4
WHERE id_pedido = 3;

-- 3. Se elimina el pedido duplicado (id_pedido = 10): es una copia
--    exacta del pedido 9 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila.
DELETE FROM pedidos
WHERE id_pedido = 10;
