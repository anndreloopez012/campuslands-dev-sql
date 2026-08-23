-- Ejercicio 23: Facturacion Simple
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO clientes (nombre, nit, correo) VALUES
    ('Ingrid Say', 'NIT-4006', 'ingrid.say@correo.com');

INSERT INTO detalle_factura (id_factura, id_producto, cantidad, precio_unitario) VALUES
    (2, 2, 4, 75.00);

-- 2 UPDATE validos
UPDATE detalle_factura
SET cantidad = 3
WHERE id_detalle = 9;

UPDATE productos
SET precio_unitario = 700.00
WHERE id_producto = 5;

-- 2 DELETE controlados con WHERE
DELETE FROM detalle_factura
WHERE id_detalle = 6;

DELETE FROM detalle_factura
WHERE id_producto = 3 AND id_detalle = 3;
