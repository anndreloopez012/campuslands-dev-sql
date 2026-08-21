PRAGMA foreign_keys = ON;

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    correo,
    telefono
) VALUES
    (1, 'Ana Martinez', 'ana.martinez@example.com', '555-0101'),
    (2, 'Carlos Ramirez', 'carlos.ramirez@example.com', '555-0102'),
    (3, 'Laura Gomez', 'laura.gomez@example.com', '555-0103'),
    (4, 'Diego Hernandez', 'diego.hernandez@example.com', '555-0104'),
    (5, 'Sofia Lopez', 'sofia.lopez@example.com', '555-0105');

INSERT INTO vendedores (
    id_vendedor,
    nombre_completo,
    correo,
    comision_porcentaje
) VALUES
    (1, 'Miguel Castillo', 'miguel.castillo@empresa.com', 5.00),
    (2, 'Valeria Perez', 'valeria.perez@empresa.com', 6.50),
    (3, 'Andres Lopez', 'andres.lopez@empresa.com', 4.50),
    (4, 'Daniela Morales', 'daniela.morales@empresa.com', 7.00),
    (5, 'Jorge Ramirez', 'jorge.ramirez@empresa.com', 5.50);

INSERT INTO ventas (
    id_venta,
    id_cliente,
    id_vendedor,
    total,
    fecha_venta,
    estado
) VALUES
    (1, 1, 1, 850.00, '2026-08-01', 'Completada'),
    (2, 2, 2, 1250.00, '2026-08-02', 'Completada'),
    (3, 3, 3, 450.00, '2026-08-03', 'Pendiente'),
    (4, 4, 4, 980.00, '2026-08-04', 'Completada'),
    (5, 5, 5, 1500.00, '2026-08-05', 'Completada'),
    (6, 1, 2, 720.00, '2026-08-06', 'Completada'),
    (7, 2, 3, 2100.00, '2026-08-07', 'Completada'),
    (8, 3, 4, 650.00, '2026-08-08', 'Pendiente'),
    (9, 4, 5, 1750.00, '2026-08-09', 'Completada'),
    (10, 5, 1, 520.00, '2026-08-10', 'Completada');

INSERT INTO pagos (
    id_pago,
    id_venta,
    monto,
    fecha_pago,
    metodo_pago,
    estado
) VALUES
    (1, 1, 850.00, '2026-08-01', 'Tarjeta', 'Confirmado'),
    (2, 2, 1250.00, '2026-08-02', 'Transferencia', 'Confirmado'),
    (3, 3, 200.00, '2026-08-03', 'Efectivo', 'Confirmado'),
    (4, 4, 980.00, '2026-08-04', 'Tarjeta', 'Confirmado'),
    (5, 5, 1500.00, '2026-08-05', 'Transferencia', 'Confirmado'),
    (6, 6, 720.00, '2026-08-06', 'Tarjeta', 'Confirmado'),
    (7, 7, 2100.00, '2026-08-07', 'Transferencia', 'Confirmado'),
    (8, 8, 300.00, '2026-08-08', 'Efectivo', 'Confirmado'),
    (9, 9, 1750.00, '2026-08-09', 'Tarjeta', 'Confirmado'),
    (10, 10, 520.00, '2026-08-10', 'Efectivo', 'Confirmado');