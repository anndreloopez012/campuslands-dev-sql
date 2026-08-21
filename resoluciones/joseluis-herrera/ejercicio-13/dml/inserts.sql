INSERT INTO clientes (id_cliente, nombre_completo, correo, telefono)
VALUES
    (1, 'Carlos Mendoza', 'carlos.mendoza@email.com', '55510001'),
    (2, 'Ana Lopez', 'ana.lopez@email.com', '55510002'),
    (3, 'Miguel Torres', 'miguel.torres@email.com', '55510003'),
    (4, 'Sofia Ramirez', 'sofia.ramirez@email.com', '55510004'),
    (5, 'Daniel Castillo', 'daniel.castillo@email.com', '55510005');

INSERT INTO cuentas (id_cuenta, id_cliente, numero_cuenta, tipo_cuenta, saldo, fecha_apertura)
VALUES
    (1, 1, '100000001', 'Ahorros', 4500.00, '2025-01-15'),
    (2, 2, '100000002', 'Corriente', 8200.00, '2025-02-10'),
    (3, 3, '100000003', 'Ahorros', 2750.00, '2025-03-20'),
    (4, 4, '100000004', 'Corriente', 10300.00, '2025-04-05'),
    (5, 5, '100000005', 'Ahorros', 6150.00, '2025-05-12');

INSERT INTO tarjetas (id_tarjeta, id_cuenta, numero_tarjeta, tipo_tarjeta, estado, fecha_emision)
VALUES
    (1, 1, '400000000001', 'Debito', 'Activa', '2025-01-20'),
    (2, 2, '400000000002', 'Credito', 'Activa', '2025-02-15'),
    (3, 3, '400000000003', 'Debito', 'Activa', '2025-03-25'),
    (4, 4, '400000000004', 'Credito', 'Bloqueada', '2025-04-10'),
    (5, 5, '400000000005', 'Debito', 'Activa', '2025-05-17');

INSERT INTO transacciones (
    id_transaccion,
    id_cuenta,
    tipo_transaccion,
    monto,
    fecha_transaccion,
    descripcion
)
VALUES
    (1, 1, 'Deposito', 1500.00, '2026-08-01 09:15', 'Deposito de salario'),
    (2, 1, 'Retiro', 300.00, '2026-08-02 14:20', 'Retiro en cajero'),
    (3, 2, 'Deposito', 2500.00, '2026-08-03 10:00', 'Transferencia recibida'),
    (4, 2, 'Retiro', 750.00, '2026-08-04 16:30', 'Pago de servicios'),
    (5, 3, 'Deposito', 1200.00, '2026-08-05 08:45', 'Deposito bancario'),
    (6, 3, 'Transferencia', 500.00, '2026-08-06 13:10', 'Transferencia enviada'),
    (7, 4, 'Deposito', 3000.00, '2026-08-07 11:25', 'Deposito empresarial'),
    (8, 4, 'Retiro', 950.00, '2026-08-08 17:40', 'Pago a proveedor'),
    (9, 5, 'Deposito', 1800.00, '2026-08-09 09:50', 'Deposito de salario'),
    (10, 5, 'Retiro', 400.00, '2026-08-10 15:15', 'Compra con tarjeta');