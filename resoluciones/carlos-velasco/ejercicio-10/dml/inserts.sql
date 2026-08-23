PRAGMA foreign_keys = ON;

-- HUESPEDES

INSERT INTO huespedes (
    id_huesped,
    nombre_completo,
    documento,
    telefono,
    correo,
    fecha_registro
) VALUES
(1, 'Carlos Mendoza Lopez', 'HSP-1001', '5551-1001', 'carlos.mendoza@email.com', '2026-01-05'),
(2, 'Ana Rodriguez Perez', 'HSP-1002', '5551-1002', 'ana.rodriguez@email.com', '2026-01-10'),
(3, 'Luis Hernandez Garcia', 'HSP-1003', '5551-1003', 'luis.hernandez@email.com', '2026-02-15'),
(4, 'Sofia Martinez Torres', 'HSP-1004', '5551-1004', 'sofia.martinez@email.com', '2026-03-01'),
(5, 'Daniela Castillo Ruiz', 'HSP-1005', '5551-1005', 'daniela.castillo@email.com', '2026-03-20');

-- HABITACIONES

INSERT INTO habitaciones (
    id_habitacion,
    numero,
    tipo,
    capacidad,
    precio_noche,
    estado
) VALUES
(1, 101, 'Individual', 1, 55.00, 'Disponible'),
(2, 102, 'Doble', 2, 85.00, 'Disponible'),
(3, 201, 'Doble', 2, 95.00, 'Disponible'),
(4, 202, 'Suite', 4, 180.00, 'Disponible'),
(5, 301, 'Familiar', 5, 220.00, 'Disponible');

-- RESERVAS

INSERT INTO reservas (
    id_reserva,
    id_huesped,
    id_habitacion,
    fecha_entrada,
    fecha_salida,
    cantidad_huespedes,
    estado
) VALUES
(1, 1, 1, '2026-08-01', '2026-08-03', 1, 'Completada'),
(2, 2, 2, '2026-08-02', '2026-08-05', 2, 'Completada'),
(3, 3, 3, '2026-08-04', '2026-08-08', 2, 'Completada'),
(4, 4, 4, '2026-08-05', '2026-08-10', 3, 'Completada'),
(5, 5, 5, '2026-08-07', '2026-08-12', 4, 'Completada'),
(6, 1, 2, '2026-08-15', '2026-08-18', 2, 'Completada'),
(7, 2, 3, '2026-08-16', '2026-08-20', 2, 'Confirmada'),
(8, 3, 4, '2026-08-18', '2026-08-23', 3, 'Confirmada'),
(9, 4, 5, '2026-08-20', '2026-08-25', 4, 'Confirmada'),
(10, 5, 1, '2026-08-22', '2026-08-24', 1, 'Pendiente');

-- PAGOS

INSERT INTO pagos (
    id_pago,
    id_reserva,
    fecha_pago,
    monto,
    metodo_pago,
    estado
) VALUES
(1, 1, '2026-08-01', 110.00, 'Efectivo', 'Completado'),
(2, 2, '2026-08-02', 255.00, 'Tarjeta', 'Completado'),
(3, 3, '2026-08-04', 380.00, 'Transferencia', 'Completado'),
(4, 4, '2026-08-05', 900.00, 'Tarjeta', 'Completado'),
(5, 5, '2026-08-07', 1100.00, 'Transferencia', 'Completado'),
(6, 6, '2026-08-15', 255.00, 'Efectivo', 'Completado'),
(7, 7, '2026-08-16', 380.00, 'Tarjeta', 'Completado'),
(8, 8, '2026-08-18', 900.00, 'Transferencia', 'Completado'),
(9, 9, '2026-08-20', 1100.00, 'Tarjeta', 'Completado'),
(10, 10, '2026-08-20', 110.00, 'Efectivo', 'Pendiente');