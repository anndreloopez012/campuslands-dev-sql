PRAGMA foreign_keys = ON;

INSERT INTO usuarios (
    id_usuario,
    nombre_completo,
    correo,
    telefono
) VALUES
    (1, 'Ana Martinez', 'ana.martinez@example.com', '555-0101'),
    (2, 'Carlos Ramirez', 'carlos.ramirez@example.com', '555-0102'),
    (3, 'Laura Gomez', 'laura.gomez@example.com', '555-0103'),
    (4, 'Diego Hernandez', 'diego.hernandez@example.com', '555-0104'),
    (5, 'Sofia Lopez', 'sofia.lopez@example.com', '555-0105');

INSERT INTO recursos (
    id_recurso,
    nombre,
    tipo,
    capacidad,
    precio_hora,
    estado
) VALUES
    (1, 'Sala Ejecutiva', 'Sala', 10, 80.00, 'Disponible'),
    (2, 'Auditorio Central', 'Auditorio', 100, 250.00, 'Disponible'),
    (3, 'Sala Creativa', 'Sala', 20, 120.00, 'Disponible'),
    (4, 'Cancha Deportiva', 'Deportivo', 30, 150.00, 'Disponible'),
    (5, 'Laboratorio Tecnologico', 'Laboratorio', 25, 180.00, 'Disponible');

INSERT INTO reservas (
    id_reserva,
    id_usuario,
    id_recurso,
    fecha_inicio,
    fecha_fin,
    estado,
    total
) VALUES
    (1, 1, 1, '2026-08-01 09:00', '2026-08-01 11:00', 'Finalizada', 160.00),
    (2, 2, 2, '2026-08-02 10:00', '2026-08-02 13:00', 'Finalizada', 750.00),
    (3, 3, 3, '2026-08-03 14:00', '2026-08-03 17:00', 'Confirmada', 360.00),
    (4, 4, 4, '2026-08-04 08:00', '2026-08-04 10:00', 'Confirmada', 300.00),
    (5, 5, 5, '2026-08-05 09:00', '2026-08-05 12:00', 'Finalizada', 540.00),
    (6, 1, 2, '2026-08-06 15:00', '2026-08-06 17:00', 'Confirmada', 500.00),
    (7, 2, 3, '2026-08-07 10:00', '2026-08-07 12:00', 'Finalizada', 240.00),
    (8, 3, 4, '2026-08-08 16:00', '2026-08-08 19:00', 'Pendiente', 450.00),
    (9, 4, 5, '2026-08-09 09:00', '2026-08-09 11:00', 'Confirmada', 360.00),
    (10, 5, 1, '2026-08-10 14:00', '2026-08-10 17:00', 'Finalizada', 240.00);

INSERT INTO pagos (
    id_pago,
    id_reserva,
    monto,
    fecha_pago,
    metodo_pago,
    estado
) VALUES
    (1, 1, 160.00, '2026-08-01', 'Tarjeta', 'Confirmado'),
    (2, 2, 750.00, '2026-08-02', 'Transferencia', 'Confirmado'),
    (3, 3, 360.00, '2026-08-03', 'Tarjeta', 'Confirmado'),
    (4, 4, 300.00, '2026-08-04', 'Efectivo', 'Confirmado'),
    (5, 5, 540.00, '2026-08-05', 'Transferencia', 'Confirmado'),
    (6, 6, 500.00, '2026-08-06', 'Tarjeta', 'Confirmado'),
    (7, 7, 240.00, '2026-08-07', 'Efectivo', 'Confirmado'),
    (8, 8, 200.00, '2026-08-08', 'Transferencia', 'Confirmado'),
    (9, 9, 360.00, '2026-08-09', 'Tarjeta', 'Confirmado'),
    (10, 10, 240.00, '2026-08-10', 'Efectivo', 'Confirmado');