PRAGMA foreign_keys = ON;

-- CLIENTES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    documento,
    correo,
    fecha_registro
) VALUES
(1, 'Carlos Ramirez', 'DOC1001', 'carlos.ramirez@email.com', '2025-01-15'),
(2, 'Ana Martinez', 'DOC1002', 'ana.martinez@email.com', '2025-02-10'),
(3, 'Luis Gonzalez', 'DOC1003', 'luis.gonzalez@email.com', '2025-03-05'),
(4, 'Sofia Herrera', 'DOC1004', 'sofia.herrera@email.com', '2025-04-18'),
(5, 'Diego Morales', 'DOC1005', 'diego.morales@email.com', '2025-05-22');

-- CUENTAS

INSERT INTO cuentas (
    id_cuenta,
    id_cliente,
    numero_cuenta,
    tipo_cuenta,
    saldo,
    fecha_apertura,
    estado
) VALUES
(1, 1, 'CTA100001', 'Ahorros', 3250.00, '2025-01-20', 'Activa'),
(2, 2, 'CTA100002', 'Corriente', 5800.00, '2025-02-15', 'Activa'),
(3, 3, 'CTA100003', 'Ahorros', 2100.00, '2025-03-10', 'Activa'),
(4, 4, 'CTA100004', 'Corriente', 7600.00, '2025-04-20', 'Activa'),
(5, 5, 'CTA100005', 'Ahorros', 1450.00, '2025-05-25', 'Activa');

-- TRANSACCIONES

INSERT INTO transacciones (
    id_transaccion,
    id_cuenta,
    tipo_transaccion,
    monto,
    fecha_hora,
    descripcion
) VALUES
(1, 1, 'Deposito', 1500.00, '2026-08-01 09:00', 'Deposito de salario'),
(2, 1, 'Retiro', 250.00, '2026-08-03 11:30', 'Retiro en cajero'),
(3, 2, 'Deposito', 2500.00, '2026-08-04 10:15', 'Deposito empresarial'),
(4, 2, 'Transferencia', 800.00, '2026-08-05 14:20', 'Transferencia recibida'),
(5, 3, 'Deposito', 900.00, '2026-08-06 08:45', 'Ahorro mensual'),
(6, 3, 'Retiro', 300.00, '2026-08-07 16:10', 'Pago de servicios'),
(7, 4, 'Deposito', 3200.00, '2026-08-08 09:30', 'Ingreso comercial'),
(8, 4, 'Transferencia', 1200.00, '2026-08-10 13:00', 'Transferencia recibida'),
(9, 5, 'Deposito', 750.00, '2026-08-11 10:40', 'Ahorro mensual'),
(10, 5, 'Retiro', 180.00, '2026-08-12 17:15', 'Compra con tarjeta'),
(11, 1, 'Transferencia', 500.00, '2026-08-13 12:00', 'Transferencia recibida'),
(12, 2, 'Retiro', 650.00, '2026-08-14 15:30', 'Pago de proveedor'),
(13, 3, 'Deposito', 1100.00, '2026-08-15 09:20', 'Ingreso adicional'),
(14, 4, 'Retiro', 900.00, '2026-08-16 18:00', 'Pago operativo'),
(15, 5, 'Transferencia', 400.00, '2026-08-17 11:50', 'Transferencia recibida');

-- TARJETAS

INSERT INTO tarjetas (
    id_tarjeta,
    id_cuenta,
    numero_tarjeta,
    tipo_tarjeta,
    fecha_emision,
    fecha_vencimiento,
    estado
) VALUES
(1, 1, '450000000001', 'Debito', '2025-01-21', '2029-01-31', 'Activa'),
(2, 2, '450000000002', 'Credito', '2025-02-16', '2029-02-28', 'Activa'),
(3, 3, '450000000003', 'Debito', '2025-03-11', '2029-03-31', 'Activa'),
(4, 4, '450000000004', 'Credito', '2025-04-21', '2029-04-30', 'Activa'),
(5, 5, '450000000005', 'Debito', '2025-05-26', '2029-05-31', 'Activa');