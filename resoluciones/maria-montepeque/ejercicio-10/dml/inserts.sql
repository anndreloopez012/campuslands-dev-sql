-- Ejercicio 10: Hotel Reservas
-- Datos base: 5 huespedes, 5 habitaciones, 6 reservas, 10 pagos

INSERT INTO huespedes (nombre, documento, correo) VALUES
    ('Manuel Estrada', 'DPI-1001', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'DPI-1002', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'DPI-1003', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'DPI-1004', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'DPI-1005', 'douglas.pineda@correo.com');

INSERT INTO habitaciones (numero, tipo, precio_noche) VALUES
    (101, 'sencilla', 250.00),
    (102, 'doble', 350.00),
    (201, 'suite', 600.00),
    (202, 'doble', 350.00),
    (301, 'sencilla', 250.00);

INSERT INTO reservas (id_huesped, id_habitacion, fecha_checkin, fecha_checkout, estado) VALUES
    (1, 1, '2026-08-01', '2026-08-03', 'finalizada'),
    (2, 2, '2026-08-02', '2026-08-05', 'finalizada'),
    (3, 3, '2026-08-04', '2026-08-06', 'en_curso'),
    (4, 4, '2026-08-05', '2026-08-07', 'confirmada'),
    (5, 5, '2026-08-06', '2026-08-08', 'confirmada'),
    (1, 3, '2026-08-10', '2026-08-11', 'cancelada');

INSERT INTO pagos (id_reserva, monto, fecha_pago, metodo) VALUES
    (1, 500.00, '2026-08-01', 'tarjeta'),
    (2, 1050.00, '2026-08-02', 'transferencia'),
    (3, 1200.00, '2026-08-04', 'tarjeta'),
    (4, 700.00, '2026-08-05', 'efectivo'),
    (5, 500.00, '2026-08-06', 'tarjeta'),
    (1, 250.00, '2026-08-03', 'efectivo'),
    (2, 100.00, '2026-08-05', 'efectivo'),
    (3, 600.00, '2026-08-06', 'transferencia'),
    (4, 350.00, '2026-08-07', 'tarjeta'),
    (5, 500.00, '2026-08-08', 'transferencia');
