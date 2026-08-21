INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    documento,
    telefono,
    correo,
    estado
) VALUES (
    6,
    'Daniel Fernandez',
    'CLI1006',
    '55510006',
    'daniel.fernandez@email.com',
    'ACTIVO'
);

INSERT INTO membresias (
    id_membresia,
    id_cliente,
    id_plan,
    fecha_inicio,
    fecha_fin,
    estado
) VALUES (
    11,
    6,
    2,
    '2026-08-01',
    '2026-10-31',
    'ACTIVA'
);

UPDATE clientes
SET telefono = '55510999'
WHERE id_cliente = 6;

UPDATE membresias
SET estado = 'VENCIDA'
WHERE id_membresia = 11;

DELETE FROM membresias
WHERE id_membresia = 11;

DELETE FROM clientes
WHERE id_cliente = 6;

-- Operacion invalida: UNIQUE
-- INSERT INTO clientes (
--     id_cliente, nombre_completo, documento, telefono, correo, estado
-- ) VALUES (
--     7, 'Cliente Duplicado', 'CLI1001', '55510007', 'duplicado@email.com', 'ACTIVO'
-- );

-- Operacion invalida: CHECK
-- INSERT INTO planes (
--     id_plan, nombre, duracion_meses, precio, descripcion
-- ) VALUES (
--     6, 'Plan Invalido', 0, 100.00, 'Plan con duracion invalida'
-- );