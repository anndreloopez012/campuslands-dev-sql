PRAGMA foreign_keys = ON;

-- Ejercicio 026: Cafeteria Campus
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Karen Solis ya pago lo que debia (id_venta = 3): se corrige el
--    estado de 'pendiente' a 'pagada'. WHERE especifico por PK + estado
--    actual.
UPDATE ventas
SET estado = 'pagada'
WHERE id_venta = 3 AND estado = 'pendiente';

-- 2. Ajuste de precio del Cafe Americano (id_producto = 1): de 8.50 a
--    9.00.
UPDATE productos
SET precio = 9.00
WHERE id_producto = 1;

-- 3. Se elimina la venta duplicada (id_venta = 9): es una copia exacta
--    de la venta 1 por error de digitacion. DELETE seguro porque usa el
--    id exacto de la fila.
DELETE FROM ventas
WHERE id_venta = 9;
