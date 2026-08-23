-- 2 INSERT adicionales a los anteriormente agregados

INSERT INTO categorias (nombre) VALUES
    ('Software');

INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES
    (2, 6, 1, 28.00, '2026-08-06');

-- 2 UPDATE validos adicionales
UPDATE productos
SET stock = stock - 1
WHERE id_producto = 1;

UPDATE clientes
SET telefono = '5559999'
WHERE id_cliente = 3;

-- 2 DELETE controlados con WHERE
DELETE FROM ventas
WHERE id_venta = 6;

DELETE FROM ventas
WHERE id_cliente = 5
  AND fecha_venta = '2026-08-05';

