PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO transacciones (
    id_transaccion,
    id_cuenta,
    tipo_transaccion,
    monto,
    fecha_hora,
    descripcion
) VALUES (
    16,
    1,
    'Deposito',
    600.00,
    '2026-08-18 09:15',
    'Bono mensual'
);

INSERT INTO tarjetas (
    id_tarjeta,
    id_cuenta,
    numero_tarjeta,
    tipo_tarjeta,
    fecha_emision,
    fecha_vencimiento,
    estado
) VALUES (
    6,
    3,
    '450000000006',
    'Debito',
    '2026-08-18',
    '2030-08-31',
    'Activa'
);

-- UPDATES

UPDATE cuentas
SET saldo = saldo + 600.00
WHERE id_cuenta = 1;

UPDATE tarjetas
SET estado = 'Bloqueada'
WHERE id_tarjeta = 6;

-- DELETES

DELETE FROM transacciones
WHERE id_transaccion = 16;

DELETE FROM tarjetas
WHERE id_tarjeta = 6;

-- OPERACIONES INVALIDAS

-- UNIQUE: numero de cuenta duplicado
-- INSERT INTO cuentas (
--     id_cuenta,
--     id_cliente,
--     numero_cuenta,
--     tipo_cuenta,
--     saldo,
--     fecha_apertura,
--     estado
-- ) VALUES (
--     6,
--     1,
--     'CTA100001',
--     'Ahorros',
--     1000.00,
--     '2026-08-18',
--     'Activa'
-- );

-- FOREIGN KEY: cliente inexistente
-- INSERT INTO cuentas (
--     id_cuenta,
--     id_cliente,
--     numero_cuenta,
--     tipo_cuenta,
--     saldo,
--     fecha_apertura,
--     estado
-- ) VALUES (
--     7,
--     99,
--     'CTA100007',
--     'Ahorros',
--     500.00,
--     '2026-08-18',
--     'Activa'
-- );