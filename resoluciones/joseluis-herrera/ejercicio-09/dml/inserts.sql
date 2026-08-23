INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    documento,
    telefono,
    correo,
    estado
) VALUES
    (1, 'Ana Lopez', 'CLI1001', '55510001', 'ana.lopez@email.com', 'ACTIVO'),
    (2, 'Carlos Ramirez', 'CLI1002', '55510002', 'carlos.ramirez@email.com', 'ACTIVO'),
    (3, 'Maria Gonzalez', 'CLI1003', '55510003', 'maria.gonzalez@email.com', 'ACTIVO'),
    (4, 'Luis Martinez', 'CLI1004', '55510004', 'luis.martinez@email.com', 'ACTIVO'),
    (5, 'Andrea Castillo', 'CLI1005', '55510005', 'andrea.castillo@email.com', 'ACTIVO');

INSERT INTO planes (
    id_plan,
    nombre,
    duracion_meses,
    precio,
    descripcion
) VALUES
    (1, 'Basico', 1, 150.00, 'Acceso general al gimnasio'),
    (2, 'Estandar', 3, 400.00, 'Acceso general y clases grupales'),
    (3, 'Premium', 6, 700.00, 'Acceso general, clases y zona premium'),
    (4, 'Anual', 12, 1200.00, 'Acceso completo durante un año'),
    (5, 'Personalizado', 2, 300.00, 'Plan adaptado a las necesidades del cliente');

INSERT INTO membresias (
    id_membresia,
    id_cliente,
    id_plan,
    fecha_inicio,
    fecha_fin,
    estado
) VALUES
    (1, 1, 1, '2026-01-10', '2026-02-09', 'VENCIDA'),
    (2, 2, 2, '2026-02-01', '2026-04-30', 'VENCIDA'),
    (3, 3, 3, '2026-03-15', '2026-09-14', 'ACTIVA'),
    (4, 4, 4, '2026-01-05', '2027-01-04', 'ACTIVA'),
    (5, 5, 5, '2026-05-01', '2026-06-30', 'VENCIDA'),
    (6, 1, 2, '2026-04-01', '2026-06-30', 'VENCIDA'),
    (7, 2, 3, '2026-05-15', '2026-11-14', 'ACTIVA'),
    (8, 3, 1, '2026-06-01', '2026-06-30', 'VENCIDA'),
    (9, 4, 2, '2026-07-01', '2026-09-30', 'ACTIVA'),
    (10, 5, 4, '2026-07-15', '2027-07-14', 'ACTIVA');

INSERT INTO pagos (
    id_pago,
    id_membresia,
    fecha_pago,
    monto,
    metodo_pago,
    estado
) VALUES
    (1, 1, '2026-01-10', 150.00, 'EFECTIVO', 'PAGADO'),
    (2, 2, '2026-02-01', 400.00, 'TARJETA', 'PAGADO'),
    (3, 3, '2026-03-15', 700.00, 'TRANSFERENCIA', 'PAGADO'),
    (4, 4, '2026-01-05', 1200.00, 'TARJETA', 'PAGADO'),
    (5, 5, '2026-05-01', 300.00, 'EFECTIVO', 'PAGADO'),
    (6, 6, '2026-04-01', 400.00, 'TRANSFERENCIA', 'PAGADO'),
    (7, 7, '2026-05-15', 700.00, 'TARJETA', 'PAGADO'),
    (8, 8, '2026-06-01', 150.00, 'EFECTIVO', 'PAGADO'),
    (9, 9, '2026-07-01', 400.00, 'TARJETA', 'PAGADO'),
    (10, 10, '2026-07-15', 1200.00, 'TRANSFERENCIA', 'PAGADO');