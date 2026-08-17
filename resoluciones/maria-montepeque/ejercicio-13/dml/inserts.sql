-- Ejercicio 13: Banco Cuentas
-- Datos base: 5 clientes, 5 cuentas, 5 tarjetas, 10 transacciones

INSERT INTO clientes (nombre, dpi, correo) VALUES
    ('Manuel Estrada', 'DPI-2001', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'DPI-2002', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'DPI-2003', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'DPI-2004', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'DPI-2005', 'douglas.pineda@correo.com');

INSERT INTO cuentas (id_cliente, numero_cuenta, tipo, saldo) VALUES
    (1, 'CTA-0001', 'ahorro', 1500.00),
    (2, 'CTA-0002', 'corriente', 3200.00),
    (3, 'CTA-0003', 'ahorro', 800.00),
    (4, 'CTA-0004', 'corriente', 4500.00),
    (5, 'CTA-0005', 'ahorro', 200.00);

INSERT INTO tarjetas (id_cuenta, numero_tarjeta, tipo, fecha_expira) VALUES
    (1, '4000-1111-2222-0001', 'debito', '2028-05-01'),
    (2, '4000-1111-2222-0002', 'credito', '2027-11-01'),
    (3, '4000-1111-2222-0003', 'debito', '2029-02-01'),
    (4, '4000-1111-2222-0004', 'credito', '2026-09-01'),
    (5, '4000-1111-2222-0005', 'debito', '2028-08-01');

INSERT INTO transacciones (id_cuenta, tipo, monto, fecha) VALUES
    (1, 'deposito', 500.00, '2026-07-01'),
    (1, 'retiro', 100.00, '2026-07-05'),
    (2, 'deposito', 1000.00, '2026-07-02'),
    (2, 'transferencia', 300.00, '2026-07-06'),
    (3, 'deposito', 200.00, '2026-07-03'),
    (3, 'retiro', 50.00, '2026-07-07'),
    (4, 'deposito', 1500.00, '2026-07-04'),
    (4, 'transferencia', 700.00, '2026-07-08'),
    (5, 'deposito', 150.00, '2026-07-05'),
    (5, 'retiro', 30.00, '2026-07-09');
