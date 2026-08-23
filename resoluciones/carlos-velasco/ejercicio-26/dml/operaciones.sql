PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    correo,
    telefono
) VALUES (
    6,
    'Miguel Castillo',
    'miguel.castillo@example.com',
    '555-0106'
);

INSERT INTO compras (
    id_compra,
    id_cliente,
    id_producto,
    cantidad,
    fecha_compra
) VALUES (
    11,
    6,
    2,
    1,
    '2026-08-11'
);

-- UPDATES

UPDATE clientes
SET telefono = '555-0199'
WHERE id_cliente = 6;

UPDATE productos
SET precio = 299.99
WHERE id_producto = 2;

-- DELETES CONTROLADOS

DELETE FROM compras
WHERE id_compra = 11;

DELETE FROM clientes
WHERE id_cliente = 6;

-- OPERACIONES INVALIDAS: UNIQUE

-- INSERT INTO clientes (
--     id_cliente,
--     nombre_completo,
--     correo,
--     telefono
-- ) VALUES (
--     7,
--     'Cliente Duplicado',
--     'ana.martinez@example.com',
--     '555-0190'
-- );

-- OPERACION INVALIDA: FOREIGN KEY

-- INSERT INTO compras (
--     id_compra,
--     id_cliente,
--     id_producto,
--     cantidad,
--     fecha_compra
-- ) VALUES (
--     12,
--     999,
--     1,
--     1,
--     '2026-08-12'
-- );