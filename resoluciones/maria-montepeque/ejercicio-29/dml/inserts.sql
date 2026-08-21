-- Ejercicio 29: Transacciones Reservas
-- Datos base: 5 usuarios, 5 recursos, 10 reservas, 6 pagos (solo reservas confirmadas)

INSERT INTO usuarios (nombre, correo) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'douglas.pineda@correo.com');

INSERT INTO recursos (nombre, precio_hora) VALUES
    ('Sala de Reuniones A', 80.00),
    ('Sala de Reuniones B', 60.00),
    ('Cancha Deportiva', 120.00),
    ('Auditorio Principal', 250.00),
    ('Laboratorio de Computo', 100.00);

INSERT INTO reservas (id_usuario, id_recurso, fecha_inicio, fecha_fin, estado) VALUES
    (1, 1, '2026-08-01 08:00', '2026-08-01 10:00', 'confirmada'),
    (1, 3, '2026-08-05 14:00', '2026-08-05 16:00', 'confirmada'),
    (2, 2, '2026-08-02 09:00', '2026-08-02 11:00', 'confirmada'),
    (2, 4, '2026-08-08 18:00', '2026-08-08 21:00', 'pendiente'),
    (3, 3, '2026-08-03 15:00', '2026-08-03 17:00', 'confirmada'),
    (3, 5, '2026-08-09 08:00', '2026-08-09 12:00', 'confirmada'),
    (4, 4, '2026-08-04 19:00', '2026-08-04 22:00', 'confirmada'),
    (4, 2, '2026-08-10 10:00', '2026-08-10 12:00', 'cancelada'),
    (5, 5, '2026-08-05 08:00', '2026-08-05 10:00', 'confirmada'),
    (5, 1, '2026-08-11 13:00', '2026-08-11 15:00', 'pendiente');

INSERT INTO pagos (id_reserva, monto, fecha) VALUES
    (1, 160.00, '2026-08-01'),
    (2, 240.00, '2026-08-05'),
    (3, 120.00, '2026-08-02'),
    (5, 240.00, '2026-08-03'),
    (6, 400.00, '2026-08-09'),
    (7, 750.00, '2026-08-04');
