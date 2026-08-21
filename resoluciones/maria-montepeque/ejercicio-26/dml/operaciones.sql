-- Ejercicio 26: Normalizacion Tienda
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO clientes (nombre, correo) VALUES
    ('Ingrid Say', 'ingrid.say@correo.com');

INSERT INTO compras (id_cliente, id_producto, cantidad, fecha) VALUES
    (2, 5, 2, '2026-07-28');

-- 2 UPDATE validos
UPDATE compras
SET cantidad = 4
WHERE id_compra = 9;

UPDATE productos
SET precio = 270.00
WHERE id_producto = 1;

-- 2 DELETE controlados con WHERE
DELETE FROM compras
WHERE id_compra = 6;

DELETE FROM compras
WHERE id_producto = 2 AND id_compra = 10;
