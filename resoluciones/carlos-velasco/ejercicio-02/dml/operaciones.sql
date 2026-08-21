PRAGMA foreign_keys = ON;

INSERT INTO productos (
    categoria_id,
    nombre,
    precio,
    stock,
    fecha_ingreso,
    sku
)
VALUES (
    3,
    'Logitech MX Keys',
    650.00,
    13,
    '2026-08-12',
    'CS-PER-003'
);

INSERT INTO clientes (
    nombre_completo,
    correo,
    telefono,
    fecha_registro
)
VALUES (
    'Fabian Torres',
    'fabian.torres@example.com',
    '555-0106',
    '2026-08-17'
);

UPDATE productos
SET precio = 1500.00
WHERE id = 3;

UPDATE clientes
SET telefono = '555-0199'
WHERE id = 2;

DELETE FROM ventas
WHERE id = 10;

DELETE FROM ventas
WHERE id = 9;

-- Debe fallar por la restricción CHECK de precio.
-- INSERT INTO productos (
--     categoria_id,
--     nombre,
--     precio,
--     stock,
--     fecha_ingreso,
--     sku
-- )
-- VALUES (
--     1,
--     'Producto Invalido',
--     -100.00,
--     5,
--     '2026-08-18',
--     'CS-INVALID-001'
-- );

-- Debe fallar por la restricción UNIQUE de correo.
-- INSERT INTO clientes (
--     nombre_completo,
--     correo,
--     telefono,
--     fecha_registro
-- )
-- VALUES (
--     'Cliente Duplicado',
--     'ana.lopez@example.com',
--     '555-0999',
--     '2026-08-18'
-- );