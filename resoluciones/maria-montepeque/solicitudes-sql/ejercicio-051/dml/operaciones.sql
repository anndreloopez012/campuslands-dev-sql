PRAGMA foreign_keys = ON;

-- Ejercicio 051: Cafeteria Campus
-- Operaciones de mantenimiento: UPDATE de estado (y correccion de
-- datos) y DELETE controlado.

-- 1. Melany Roblero pago su cuenta pendiente (id_venta = 4): se
--    corrige el estado de 'pendiente_pago' a 'pagada'.
UPDATE ventas
SET estado = 'pagada'
WHERE id_venta = 4 AND estado = 'pendiente_pago';

-- 2. El cajero conto mal el pedido de Josue Tojin: en realidad
--    fueron 2 cafes americanos, no 1 (venta 5). Se corrige la
--    cantidad sin borrar la linea.
UPDATE detalle_ventas
SET cantidad = 2
WHERE id_venta = 5 AND id_producto = 1;

-- 3. DELETE controlado: se elimina el detalle de la venta cancelada
--    de Andrea Chavez (id_venta = 7). Solo se borra el detalle
--    cuando la venta a la que pertenece esta 'cancelada'; el
--    encabezado de la venta se conserva como historial.
DELETE FROM detalle_ventas
WHERE id_venta = 7
  AND EXISTS (
      SELECT 1 FROM ventas WHERE ventas.id_venta = detalle_ventas.id_venta AND ventas.estado = 'cancelada'
  );

-- 4. Se elimina la venta duplicada (id_venta = 9): es una copia
--    exacta de la venta 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio); no tiene detalle asociado propio, asi que
--    no deja huerfanos.
DELETE FROM ventas
WHERE id_venta = 9;
