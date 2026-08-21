INSERT INTO huespedes (
    id_huesped,
    nombre_completo,
    documento,
    telefono,
    correo
) VALUES
    (1, 'Ana Lopez', 'HSP1001', '55510001', 'ana.lopez@email.com'),
    (2, 'Carlos Ramirez', 'HSP1002', '55510002', 'carlos.ramirez@email.com'),
    (3, 'Maria Gonzalez', 'HSP1003', '55510003', 'maria.gonzalez@email.com'),
    (4, 'Luis Martinez', 'HSP1004', '55510004', 'luis.martinez@email.com'),
    (5, 'Andrea Castillo', 'HSP1005', '55510005', 'andrea.castillo@email.com');

INSERT INTO habitaciones (
    id_habitacion,
    numero,
    tipo,
    capacidad,
    precio_noche,
    estado
) VALUES
    (1, 101, 'INDIVIDUAL', 1, 80.00, 'DISPONIBLE'),
    (2, 102, 'DOBLE', 2, 120.00, 'DISPONIBLE'),
    (3, 201, 'DOBLE', 2, 130.00, 'DISPONIBLE'),
    (4, 202, 'SUITE', 4, 220.00, 'DISPONIBLE'),
    (5, 301, 'SUITE', 4, 250.00, 'DISPONIBLE');

INSERT INTO reservas (
    id_reserva,
    id_huesped,
    id_habitacion,
    fecha_entrada,
    fecha_salida,
    cantidad_huespedes,
    estado
) VALUES
    (1, 1, 1, '2026-01-10', '2026-01-12', 1, 'FINALIZADA'),
    (2, 2, 2, '2026-02-05', '2026-02-08', 2, 'FINALIZADA'),
    (3, 3, 3, '2026-03-12', '2026-03-15', 2, 'FINALIZADA'),
    (4, 4, 4, '2026-04-20', '2026-04-25', 3, 'FINALIZADA'),
    (5, 5, 5, '2026-05-02', '2026-05-07', 4, 'FINALIZADA'),
    (6, 1, 2, '2026-06-10', '2026-06-13', 2, 'FINALIZADA'),
    (7, 2, 3, '2026-07-05', '2026-07-09', 2, 'FINALIZADA'),
    (8, 3, 4, '2026-08-01', '2026-08-05', 3, 'CHECK_IN'),
    (9, 4, 5, '2026-08-10', '2026-08-15', 4, 'CONFIRMADA'),
    (10, 5, 2, '2026-08-20', '2026-08-23', 2, 'CONFIRMADA');

INSERT INTO pagos (
    id_pago,
    id_reserva,
    fecha_pago,
    monto,
    metodo_pago,
    estado
) VALUES
    (1, 1, '2026-01-10', 160.00, 'EFECTIVO', 'PAGADO'),
    (2, 2, '2026-02-05', 360.00, 'TARJETA', 'PAGADO'),
    (3, 3, '2026-03-12', 390.00, 'TRANSFERENCIA', 'PAGADO'),
    (4, 4, '2026-04-20', 1100.00, 'TARJETA', 'PAGADO'),
    (5, 5, '2026-05-02', 1250.00, 'TRANSFERENCIA', 'PAGADO'),
    (6, 6, '2026-06-10', 360.00, 'EFECTIVO', 'PAGADO'),
    (7, 7, '2026-07-05', 520.00, 'TARJETA', 'PAGADO'),
    (8, 8, '2026-08-01', 880.00, 'TRANSFERENCIA', 'PAGADO'),
    (9, 9, '2026-08-10', 1250.00, 'TARJETA', 'PAGADO'),
    (10, 10, '2026-08-20', 360.00, 'EFECTIVO', 'PENDIENTE');