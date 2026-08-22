INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    email,
    telefono,
    fecha_registro
) VALUES
(6, 'Andrea Silva', 'andrea.silva@email.com', '55510006', '2026-03-10');

INSERT INTO ventas (
    id_venta,
    id_cliente,
    id_vendedor,
    fecha_venta,
    total,
    estado
) VALUES
(11, 6, 3, '2026-08-21', 720.00, 'completada');

UPDATE clientes
SET telefono = '55519999'
WHERE id_cliente = 1;

UPDATE vendedores
SET comision = 0.09
WHERE id_vendedor = 5;

DELETE FROM ventas
WHERE id_venta = 11;

DELETE FROM clientes
WHERE id_cliente = 6;

-- INSERT que falla por UNIQUE
-- INSERT INTO clientes (
--     id_cliente,
--     nombre_completo,
--     email,
--     telefono,
--     fecha_registro
-- ) VALUES (
--     7,
--     'Cliente Duplicado',
--     'jose.perez@email.com',
--     '55510007',
--     '2026-08-21'
-- );

-- INSERT que falla por CHECK
-- INSERT INTO ventas (
--     id_venta,
--     id_cliente,
--     id_vendedor,
--     fecha_venta,
--     total,
--     estado
-- ) VALUES (
--     12,
--     1,
--     1,
--     '2026-08-21',
--     -100.00,
--     'completada'
-- );