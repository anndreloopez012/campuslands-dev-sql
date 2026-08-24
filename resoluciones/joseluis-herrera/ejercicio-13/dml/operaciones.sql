INSERT INTO clientes (id_cliente, nombre_completo, correo, telefono)
VALUES
    (6, 'Laura Herrera', 'laura.herrera@email.com', '55510006');

INSERT INTO cuentas (id_cuenta, id_cliente, numero_cuenta, tipo_cuenta, saldo, fecha_apertura)
VALUES
    (6, 6, '100000006', 'Ahorros', 3500.00, '2026-08-11');

UPDATE clientes
SET telefono = '55519999'
WHERE id_cliente = 1;

UPDATE cuentas
SET saldo = 4700.00
WHERE id_cuenta = 1;

DELETE FROM clientes
WHERE id_cliente = 6;

DELETE FROM cuentas
WHERE id_cuenta = 6;

INSERT INTO transacciones (
    id_transaccion,
    id_cuenta,
    tipo_transaccion,
    monto,
    fecha_transaccion,
    descripcion
)
VALUES
    (11, 1, 'Deposito', 200.00, '2026-08-12 10:30', 'Deposito adicional');

DELETE FROM transacciones
WHERE id_transaccion = 11;

INSERT INTO transacciones (
    id_transaccion,
    id_cuenta,
    tipo_transaccion,
    monto,
    fecha_transaccion,
    descripcion
)
VALUES
    (12, 2, 'Retiro', 100.00, '2026-08-12 12:00', 'Retiro temporal');

DELETE FROM transacciones
WHERE id_transaccion = 12;

-- Operación inválida: viola UNIQUE en clientes.correo
-- INSERT INTO clientes (id_cliente, nombre_completo, correo, telefono)
-- VALUES (7, 'Cliente Duplicado', 'carlos.mendoza@email.com', '55510007');

-- Operación inválida: viola CHECK en transacciones.monto
-- INSERT INTO transacciones (
--     id_transaccion,
--     id_cuenta,
--     tipo_transaccion,
--     monto,
--     fecha_transaccion,
--     descripcion
-- )
-- VALUES (13, 1, 'Deposito', -500.00, '2026-08-13 10:00', 'Operacion invalida');