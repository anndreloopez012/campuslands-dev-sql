-- Ejercicio 14: Marketplace Campus
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO compradores (nombre, correo) VALUES
    ('Ingrid Say', 'ingrid.say@correo.com');

INSERT INTO ordenes (id_comprador, id_producto, cantidad, fecha, estado) VALUES
    (2, 3, 2, '2026-07-10', 'pendiente');

-- 2 UPDATE validos
UPDATE productos
SET stock = stock - 2
WHERE id_producto = 1;

UPDATE ordenes
SET estado = 'enviada'
WHERE id_orden = 4;

-- 2 DELETE controlados con WHERE
DELETE FROM ordenes
WHERE id_orden = 8;

DELETE FROM ordenes
WHERE estado = 'pendiente' AND id_orden = 10;
