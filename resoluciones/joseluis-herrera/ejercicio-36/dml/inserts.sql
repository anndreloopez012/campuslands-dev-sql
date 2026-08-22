INSERT INTO huespedes (
    id_huesped,
    nombre_completo,
    documento,
    telefono,
    email,
    estado
) VALUES
(1, 'Carlos Mendoza', 'DPI10001', '55501001', 'carlos.mendoza@example.com', 'activo'),
(2, 'Ana Lopez', 'DPI10002', '55501002', 'ana.lopez@example.com', 'activo'),
(3, 'Miguel Ramirez', 'DPI10003', '55501003', 'miguel.ramirez@example.com', 'activo'),
(4, 'Sofia Castillo', 'DPI10004', '55501004', 'sofia.castillo@example.com', 'activo'),
(5, 'Daniel Morales', 'DPI10005', '55501005', 'daniel.morales@example.com', 'activo'),
(6, 'Laura Perez', 'DPI10006', '55501006', 'laura.perez@example.com', 'activo');

INSERT INTO habitaciones (
    id_habitacion,
    numero,
    tipo,
    capacidad,
    precio_noche,
    estado
) VALUES
(1, 101, 'Individual', 1, 350.00, 'disponible'),
(2, 102, 'Doble', 2, 500.00, 'disponible'),
(3, 103, 'Doble', 2, 550.00, 'disponible'),
(4, 201, 'Suite', 3, 950.00, 'disponible'),
(5, 202, 'Suite', 4, 1200.00, 'disponible'),
(6, 301, 'Familiar', 5, 1450.00, 'disponible');

INSERT INTO servicios (
    id_servicio,
    nombre,
    descripcion,
    costo,
    estado
) VALUES
(1, 'Desayuno', 'Desayuno buffet', 75.00, 'activo'),
(2, 'Lavanderia', 'Servicio de lavado y planchado', 100.00, 'activo'),
(3, 'Spa', 'Acceso a tratamiento de spa', 250.00, 'activo'),
(4, 'Transporte', 'Transporte desde o hacia el aeropuerto', 175.00, 'activo'),
(5, 'Room Service', 'Servicio de alimentos en habitación', 125.00, 'activo'),
(6, 'Estacionamiento', 'Estacionamiento privado', 50.00, 'activo');

INSERT INTO reservas (
    id_reserva,
    id_huesped,
    id_habitacion,
    fecha_entrada,
    fecha_salida,
    estado
) VALUES
(1, 1, 1, '2026-08-01', '2026-08-03', 'finalizada'),
(2, 2, 2, '2026-08-02', '2026-08-05', 'finalizada'),
(3, 3, 4, '2026-08-04', '2026-08-07', 'finalizada'),
(4, 4, 3, '2026-08-06', '2026-08-09', 'finalizada'),
(5, 5, 5, '2026-08-08', '2026-08-12', 'confirmada'),
(6, 6, 6, '2026-08-10', '2026-08-15', 'confirmada'),
(7, 1, 2, '2026-08-15', '2026-08-18', 'confirmada'),
(8, 2, 4, '2026-08-16', '2026-08-20', 'pendiente');

INSERT INTO detalle_servicio (
    id_detalle,
    id_reserva,
    id_servicio,
    cantidad,
    fecha_servicio,
    costo_unitario
) VALUES
(1, 1, 1, 2, '2026-08-02', 75.00),
(2, 1, 6, 2, '2026-08-02', 50.00),
(3, 2, 1, 3, '2026-08-03', 75.00),
(4, 2, 2, 1, '2026-08-04', 100.00),
(5, 3, 3, 2, '2026-08-05', 250.00),
(6, 3, 5, 1, '2026-08-06', 125.00),
(7, 4, 1, 3, '2026-08-07', 75.00),
(8, 5, 4, 1, '2026-08-09', 175.00),
(9, 5, 6, 3, '2026-08-10', 50.00),
(10, 6, 1, 5, '2026-08-11', 75.00),
(11, 6, 5, 2, '2026-08-12', 125.00),
(12, 7, 2, 2, '2026-08-16', 100.00),
(13, 7, 6, 3, '2026-08-17', 50.00),
(14, 8, 1, 4, '2026-08-17', 75.00),
(15, 8, 3, 1, '2026-08-18', 250.00);

-- CASOS INVALIDOS

-- INSERT INTO huespedes (id_huesped, nombre_completo, documento, telefono, email, estado)
-- VALUES (7, 'Huesped duplicado', 'DPI10001', '55501007', 'duplicado@example.com', 'activo');

-- INSERT INTO reservas (id_reserva, id_huesped, id_habitacion, fecha_entrada, fecha_salida, estado)
-- VALUES (9, 3, 4, '2026-08-20', '2026-08-18', 'confirmada');