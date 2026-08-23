PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    correo,
    telefono
) VALUES (
    6,
    'Camila Torres',
    'camila.torres@example.com',
    '555-0106'
);

INSERT INTO ventas (
    id_venta,
    id_cliente,
    id_vendedor,
    total,
    fecha_venta,
    estado
) VALUES (
    11,
    6,
    2,
    890.00,
    '2026-08-11',
    'Completada'
);

-- UPDATES

UPDATE clientes
SET telefono = '555-0199'
WHERE id_cliente = 6;

UPDATE ventas
SET total = 920.00
WHERE id_venta = 11;

-- DELETES CONTROLADOS

DELETE FROM ventas
WHERE id_venta = 11;

DELETE FROM clientes
WHERE id_cliente = 6;

-- OPERACION INVALIDA: UNIQUE

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

-- OPERACION INVALIDA: CHECK

-- INSERT INTO ventas (
--     id_venta,
--     id_cliente,
--     id_vendedor,
--     total,
--     fecha_venta,
--     estado
-- ) VALUES (
--     12,
--     1,
--     1,
--     -500.00,
--     '2026-08-12',
--     'Completada'
-- );