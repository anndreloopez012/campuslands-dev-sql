INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    email,
    telefono,
    fecha_registro
) VALUES
(1, 'Jose Perez', 'jose.perez@email.com', '55510001', '2026-01-10'),
(2, 'Maria Lopez', 'maria.lopez@email.com', '55510002', '2026-01-15'),
(3, 'Carlos Gomez', 'carlos.gomez@email.com', '55510003', '2026-02-05'),
(4, 'Ana Martinez', 'ana.martinez@email.com', '55510004', '2026-02-20'),
(5, 'Luis Ramirez', 'luis.ramirez@email.com', '55510005', '2026-03-01');

INSERT INTO vendedores (
    id_vendedor,
    nombre_completo,
    email,
    comision
) VALUES
(1, 'Laura Torres', 'laura.torres@empresa.com', 0.05),
(2, 'Pedro Castillo', 'pedro.castillo@empresa.com', 0.06),
(3, 'Sofia Morales', 'sofia.morales@empresa.com', 0.05),
(4, 'Diego Herrera', 'diego.herrera@empresa.com', 0.07),
(5, 'Valentina Cruz', 'valentina.cruz@empresa.com', 0.08);

INSERT INTO ventas (
    id_venta,
    id_cliente,
    id_vendedor,
    fecha_venta,
    total,
    estado
) VALUES
(1, 1, 1, '2026-08-01', 450.00, 'completada'),
(2, 2, 2, '2026-08-03', 780.00, 'completada'),
(3, 3, 3, '2026-08-05', 320.00, 'completada'),
(4, 4, 4, '2026-08-07', 1250.00, 'completada'),
(5, 5, 5, '2026-08-09', 640.00, 'pendiente'),
(6, 1, 2, '2026-08-11', 890.00, 'completada'),
(7, 2, 3, '2026-08-13', 275.00, 'cancelada'),
(8, 3, 4, '2026-08-15', 1500.00, 'completada'),
(9, 4, 5, '2026-08-17', 970.00, 'completada'),
(10, 5, 1, '2026-08-19', 530.00, 'completada');

INSERT INTO pagos (
    id_pago,
    id_venta,
    fecha_pago,
    monto,
    metodo_pago,
    estado
) VALUES
(1, 1, '2026-08-01', 450.00, 'tarjeta', 'aprobado'),
(2, 2, '2026-08-03', 500.00, 'transferencia', 'aprobado'),
(3, 3, '2026-08-05', 320.00, 'efectivo', 'aprobado'),
(4, 4, '2026-08-07', 1250.00, 'tarjeta', 'aprobado'),
(5, 5, '2026-08-09', 300.00, 'transferencia', 'aprobado'),
(6, 6, '2026-08-11', 890.00, 'tarjeta', 'aprobado'),
(7, 7, '2026-08-13', 275.00, 'efectivo', 'rechazado'),
(8, 8, '2026-08-15', 1000.00, 'transferencia', 'aprobado'),
(9, 9, '2026-08-17', 970.00, 'tarjeta', 'aprobado'),
(10, 10, '2026-08-19', 530.00, 'efectivo', 'aprobado');