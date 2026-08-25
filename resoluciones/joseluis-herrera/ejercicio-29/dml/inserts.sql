INSERT INTO usuarios (
    id_usuario,
    nombre_completo,
    email,
    telefono,
    fecha_registro
) VALUES
(1, 'Jose Perez', 'jose.perez@email.com', '55510001', '2026-01-05'),
(2, 'Maria Lopez', 'maria.lopez@email.com', '55510002', '2026-01-10'),
(3, 'Carlos Gomez', 'carlos.gomez@email.com', '55510003', '2026-01-15'),
(4, 'Ana Martinez', 'ana.martinez@email.com', '55510004', '2026-01-20'),
(5, 'Luis Ramirez', 'luis.ramirez@email.com', '55510005', '2026-01-25');

INSERT INTO recursos (
    id_recurso,
    nombre,
    tipo,
    capacidad,
    precio_hora,
    estado
) VALUES
(1, 'Sala Ejecutiva A', 'sala', 10, 80.00, 'disponible'),
(2, 'Sala Ejecutiva B', 'sala', 15, 100.00, 'disponible'),
(3, 'Auditorio Central', 'auditorio', 80, 250.00, 'disponible'),
(4, 'Laboratorio Tecnologico', 'laboratorio', 30, 180.00, 'disponible'),
(5, 'Sala de Reuniones C', 'sala', 8, 60.00, 'mantenimiento');

INSERT INTO reservas (
    id_reserva,
    id_usuario,
    id_recurso,
    fecha_reserva,
    hora_inicio,
    hora_fin,
    cantidad_horas,
    total,
    estado
) VALUES
(1, 1, 1, '2026-09-01', '08:00', '10:00', 2, 160.00, 'confirmada'),
(2, 2, 2, '2026-09-02', '09:00', '12:00', 3, 300.00, 'confirmada'),
(3, 3, 3, '2026-09-03', '10:00', '14:00', 4, 1000.00, 'confirmada'),
(4, 4, 4, '2026-09-04', '08:00', '11:00', 3, 540.00, 'finalizada'),
(5, 5, 1, '2026-09-05', '14:00', '17:00', 3, 240.00, 'pendiente'),
(6, 1, 2, '2026-09-06', '13:00', '15:00', 2, 200.00, 'confirmada'),
(7, 2, 3, '2026-09-07', '08:00', '12:00', 4, 1000.00, 'finalizada'),
(8, 3, 4, '2026-09-08', '15:00', '18:00', 3, 540.00, 'confirmada'),
(9, 4, 1, '2026-09-09', '10:00', '12:00', 2, 160.00, 'cancelada'),
(10, 5, 2, '2026-09-10', '16:00', '19:00', 3, 300.00, 'confirmada');

INSERT INTO pagos (
    id_pago,
    id_reserva,
    fecha_pago,
    monto,
    metodo_pago,
    estado
) VALUES
(1, 1, '2026-08-20', 160.00, 'tarjeta', 'aprobado'),
(2, 2, '2026-08-21', 300.00, 'transferencia', 'aprobado'),
(3, 3, '2026-08-22', 1000.00, 'tarjeta', 'aprobado'),
(4, 4, '2026-08-23', 540.00, 'efectivo', 'aprobado'),
(5, 5, '2026-08-24', 120.00, 'transferencia', 'aprobado'),
(6, 6, '2026-08-25', 200.00, 'tarjeta', 'aprobado'),
(7, 7, '2026-08-26', 1000.00, 'transferencia', 'aprobado'),
(8, 8, '2026-08-27', 540.00, 'tarjeta', 'aprobado'),
(9, 9, 160.00, '2026-08-28', 'efectivo', 'rechazado'),
(10, 10, '2026-08-29', 300.00, 'tarjeta', 'aprobado');