-- Ejercicio 09: Gimnasio Membresias
-- Datos base: 5 clientes, 5 planes, 6 membresias, 10 pagos

INSERT INTO clientes (nombre, correo) VALUES
    ('Patricia Loarca', 'patricia.loarca@correo.com'),
    ('Oscar Villagran', 'oscar.villagran@correo.com'),
    ('Gabriela Marroquin', 'gabriela.marroquin@correo.com'),
    ('Nestor Cabrera', 'nestor.cabrera@correo.com'),
    ('Yesenia Poroj', 'yesenia.poroj@correo.com');

INSERT INTO planes (nombre, duracion_meses, precio) VALUES
    ('Plan Basico', 1, 150.00),
    ('Plan Trimestral', 3, 400.00),
    ('Plan Semestral', 6, 720.00),
    ('Plan Anual', 12, 1300.00),
    ('Plan Estudiante', 1, 100.00);

INSERT INTO membresias (id_cliente, id_plan, fecha_inicio, fecha_fin, estado) VALUES
    (1, 1, '2026-07-01', '2026-08-01', 'activa'),
    (2, 2, '2026-06-01', '2026-09-01', 'activa'),
    (3, 3, '2026-05-01', '2026-11-01', 'activa'),
    (4, 4, '2026-01-01', '2027-01-01', 'activa'),
    (5, 5, '2026-07-15', '2026-08-15', 'activa'),
    (1, 5, '2026-05-01', '2026-06-01', 'vencida');

INSERT INTO pagos (id_membresia, monto, fecha_pago, metodo) VALUES
    (1, 150.00, '2026-07-01', 'tarjeta'),
    (2, 400.00, '2026-06-01', 'transferencia'),
    (3, 720.00, '2026-05-01', 'tarjeta'),
    (4, 1300.00, '2026-01-01', 'transferencia'),
    (5, 100.00, '2026-07-15', 'efectivo'),
    (6, 100.00, '2026-05-01', 'efectivo'),
    (1, 150.00, '2026-07-28', 'tarjeta'),
    (2, 400.00, '2026-06-28', 'transferencia'),
    (3, 720.00, '2026-05-28', 'tarjeta'),
    (4, 1300.00, '2026-01-28', 'transferencia');
