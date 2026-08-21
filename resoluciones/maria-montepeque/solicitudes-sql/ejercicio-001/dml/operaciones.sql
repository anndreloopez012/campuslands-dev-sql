PRAGMA foreign_keys = ON;

-- Ejercicio 001: Cafeteria Campus
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Karen Solis ya pago lo que debia: se corrige el estado de su venta
--    pendiente (id_venta = 3) a 'pagada'. WHERE especifico por PK + estado
--    actual, para no tocar otras ventas por accidente.
UPDATE ventas
SET estado = 'pagada'
WHERE id_venta = 3 AND estado = 'pendiente';

-- 2. Llego un pedido de cafe: se reabastece el stock del producto 1
--    (Cafe americano) en 30 unidades.
UPDATE productos
SET stock = stock + 30
WHERE id_producto = 1;

-- 3. Se elimina la venta duplicada (id_venta = 8): es una copia exacta de
--    la venta 2 por error de digitacion. DELETE seguro porque usa el id
--    exacto de la fila duplicada, no un filtro amplio.
DELETE FROM ventas
WHERE id_venta = 8;
