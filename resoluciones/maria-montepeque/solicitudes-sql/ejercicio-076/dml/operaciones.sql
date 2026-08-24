PRAGMA foreign_keys = ON;

-- Ejercicio 076: Cafeteria Campus
-- Operaciones de mantenimiento sobre los datos base.

-- 1 DELETE controlado: la venta 4 todavia esta 'abierta' (sin pago),
-- asi que es seguro corregir el Sandwich Jamon que se agrego por
-- error. Si la venta ya tuviera pago, esta linea no se tocaria.
DELETE FROM detalle_ventas
WHERE id_venta = 4 AND id_producto = 3;

-- 1 UPDATE de estado: la venta 3 se cobra y se cierra.
UPDATE ventas
SET estado = 'cerrada'
WHERE id_venta = 3 AND estado = 'abierta';

-- Pago oficial de la venta 3, ahora que ya esta cerrada (monto =
-- 12.00 + 20.00, la suma de sus lineas).
INSERT INTO pagos (id_venta, monto, metodo_pago) VALUES
    (3, 32.00, 'transferencia');

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar una linea de la venta 1, que ya tiene pago registrado (dato
-- oficial de la cafeteria). El DELETE de arriba solo se aplico
-- mientras la venta 4 seguia 'abierta' y sin pago, por diseno.
-- DELETE FROM detalle_ventas WHERE id_venta = 1 AND id_producto = 1;
