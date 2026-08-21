PRAGMA foreign_keys = ON;

-- CLIENTES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    documento,
    telefono,
    correo,
    fecha_registro
) VALUES
(1, 'Carlos Mendoza Lopez', 'CLI-1001', '5551-1001', 'carlos.mendoza@email.com', '2026-01-05'),
(2, 'Ana Rodriguez Perez', 'CLI-1002', '5551-1002', 'ana.rodriguez@email.com', '2026-01-08'),
(3, 'Luis Hernandez Garcia', 'CLI-1003', '5551-1003', 'luis.hernandez@email.com', '2026-01-12'),
(4, 'Sofia Martinez Torres', 'CLI-1004', '5551-1004', 'sofia.martinez@email.com', '2026-01-15'),
(5, 'Daniela Castillo Ruiz', 'CLI-1005', '5551-1005', 'daniela.castillo@email.com', '2026-01-20');

-- PLANES

INSERT INTO planes (
    id_plan,
    nombre,
    duracion_meses,
    precio,
    descripcion
) VALUES
(1, 'Basico Mensual', 1, 35.00, 'Acceso general al gimnasio'),
(2, 'Estandar Trimestral', 3, 90.00, 'Acceso general y clases grupales'),
(3, 'Premium Semestral', 6, 165.00, 'Acceso completo y asesorias'),
(4, 'Elite Anual', 12, 300.00, 'Acceso completo y beneficios premium'),
(5, 'Estudiante Mensual', 1, 25.00, 'Plan mensual para estudiantes');

-- MEMBRESIAS

INSERT INTO membresias (
    id_membresia,
    id_cliente,
    id_plan,
    fecha_inicio,
    fecha_fin,
    estado
) VALUES
(1, 1, 1, '2026-01-10', '2026-02-09', 'Vencida'),
(2, 2, 2, '2026-02-01', '2026-04-30', 'Vencida'),
(3, 3, 3, '2026-03-01', '2026-08-31', 'Activa'),
(4, 4, 4, '2026-01-15', '2027-01-14', 'Activa'),
(5, 5, 5, '2026-04-01', '2026-04-30', 'Vencida'),
(6, 1, 2, '2026-05-01', '2026-07-31', 'Vencida'),
(7, 2, 3, '2026-06-01', '2026-11-30', 'Activa'),
(8, 3, 1, '2026-07-01', '2026-07-31', 'Vencida'),
(9, 4, 2, '2026-08-01', '2026-10-31', 'Activa'),
(10, 5, 4, '2026-08-01', '2027-07-31', 'Activa');

-- PAGOS

INSERT INTO pagos (
    id_pago,
    id_membresia,
    fecha_pago,
    monto,
    metodo_pago,
    estado
) VALUES
(1, 1, '2026-01-10', 35.00, 'Efectivo', 'Completado'),
(2, 2, '2026-02-01', 90.00, 'Tarjeta', 'Completado'),
(3, 3, '2026-03-01', 165.00, 'Transferencia', 'Completado'),
(4, 4, '2026-01-15', 300.00, 'Tarjeta', 'Completado'),
(5, 5, '2026-04-01', 25.00, 'Efectivo', 'Completado'),
(6, 6, '2026-05-01', 90.00, 'Transferencia', 'Completado'),
(7, 7, '2026-06-01', 165.00, 'Tarjeta', 'Completado'),
(8, 8, '2026-07-01', 35.00, 'Efectivo', 'Completado'),
(9, 9, '2026-08-01', 90.00, 'Transferencia', 'Completado'),
(10, 10, '2026-08-01', 300.00, 'Tarjeta', 'Completado');