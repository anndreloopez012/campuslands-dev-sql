PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    documento,
    telefono,
    correo,
    fecha_registro
) VALUES
(6, 'Miguel Torres Sanchez', 'CLI-1006', '5551-1006', 'miguel.torres@email.com', '2026-08-15');

INSERT INTO membresias (
    id_membresia,
    id_cliente,
    id_plan,
    fecha_inicio,
    fecha_fin,
    estado
) VALUES
(11, 6, 1, '2026-08-15', '2026-09-14', 'Activa');

-- UPDATES

UPDATE clientes
SET telefono = '5551-9001'
WHERE id_cliente = 1;

UPDATE membresias
SET estado = 'Suspendida'
WHERE id_membresia = 9;

-- DELETES

DELETE FROM membresias
WHERE id_membresia = 11;

DELETE FROM clientes
WHERE id_cliente = 6;

-- OPERACIONES INVALIDAS

-- UNIQUE: documento duplicado
-- INSERT INTO clientes (
--     id_cliente,
--     nombre_completo,
--     documento,
--     telefono,
--     correo,
--     fecha_registro
-- ) VALUES (
--     7,
--     'Cliente Documento Duplicado',
--     'CLI-1001',
--     '5551-1007',
--     'duplicado@email.com',
--     '2026-08-20'
-- );

-- FOREIGN KEY: plan inexistente
-- INSERT INTO membresias (
--     id_membresia,
--     id_cliente,
--     id_plan,
--     fecha_inicio,
--     fecha_fin,
--     estado
-- ) VALUES (
--     12,
--     1,
--     99,
--     '2026-08-20',
--     '2026-09-19',
--     'Activa'
-- );