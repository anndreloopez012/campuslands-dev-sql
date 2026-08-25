INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    correo,
    telefono,
    fecha_registro
) VALUES (
    6,
    'Diego Hernandez',
    'diego.hernandez@example.com',
    '55510006',
    '2026-03-01'
);

INSERT INTO productos (
    id_producto,
    nombre,
    precio,
    stock,
    id_categoria
) VALUES (
    6,
    'Memoria USB 128GB',
    120.00,
    50,
    5
);

-- UPDATE

UPDATE clientes
SET telefono = '55519999'
WHERE id_cliente = 6;

UPDATE productos
SET precio = 135.00,
    stock = 45
WHERE id_producto = 6;

-- DELETE

DELETE FROM productos
WHERE id_producto = 6;

DELETE FROM clientes
WHERE id_cliente = 6;

-- OPERACIONES INVALIDAS

-- CHECK
-- INSERT INTO productos (
--     id_producto,
--     nombre,
--     precio,
--     stock,
--     id_categoria
-- ) VALUES (
--     7,
--     'Producto invalido',
--     -50.00,
--     10,
--     1
-- );

-- UNIQUE
-- INSERT INTO clientes (
--     id_cliente,
--     nombre_completo,
--     correo,
--     telefono,
--     fecha_registro
-- ) VALUES (
--     7,
--     'Cliente duplicado',
--     'ana.lopez@example.com',
--     '55510007',
--     '2026-03-05'
-- );