PRAGMA foreign_keys = ON;

-- INSERT ADICIONALES

INSERT INTO productos (
    id_producto,
    id_categoria,
    nombre,
    precio,
    stock,
    fecha_ingreso
) VALUES
(8, 2, 'Mouse Pad XL', 180.00, 35, '2026-03-11');

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    correo,
    telefono,
    fecha_registro
) VALUES
(8, 'Andres Morales', 'andres.morales@email.com', '55510008', '2026-03-11');

-- UPDATE

UPDATE productos
SET precio = 460.00,
    stock = 28
WHERE id_producto = 3;

UPDATE clientes
SET telefono = '55510101'
WHERE id_cliente = 2;

-- DELETE

DELETE FROM productos
WHERE id_producto = 8;

DELETE FROM clientes
WHERE id_cliente = 8;

-- OPERACIONES INVALIDAS

-- UNIQUE
-- INSERT INTO productos (
--     id_producto,
--     id_categoria,
--     nombre,
--     precio,
--     stock,
--     fecha_ingreso
-- ) VALUES (
--     9,
--     1,
--     'Laptop Pro 14',
--     5000.00,
--     10,
--     '2026-03-12'
-- );

-- FOREIGN KEY
-- INSERT INTO ventas (
--     id_venta,
--     id_cliente,
--     id_producto,
--     cantidad,
--     precio_unitario,
--     fecha_venta
-- ) VALUES (
--     11,
--     999,
--     1,
--     1,
--     4200.00,
--     '2026-03-12'
-- );