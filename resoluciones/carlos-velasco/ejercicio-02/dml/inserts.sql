PRAGMA foreign_keys = ON;

INSERT INTO categorias (nombre, descripcion)
VALUES
    ('Laptops', 'Equipos portátiles'),
    ('Monitores', 'Pantallas para trabajo'),
    ('Perifericos', 'Accesorios de entrada'),
    ('Almacenamiento', 'Dispositivos de almacenamiento'),
    ('Audio', 'Dispositivos de audio');

INSERT INTO productos (
    categoria_id,
    nombre,
    precio,
    stock,
    fecha_ingreso,
    sku
)
VALUES
    (1, 'Acer Aspire 5', 2850.00, 12, '2026-08-01', 'CS-LAP-001'),
    (1, 'Lenovo IdeaPad 3', 3100.00, 8, '2026-08-02', 'CS-LAP-002'),
    (2, 'LG UltraGear 24', 1450.00, 15, '2026-08-03', 'CS-MON-001'),
    (2, 'Samsung T350 24', 1100.00, 10, '2026-08-04', 'CS-MON-002'),
    (3, 'Logitech K380', 280.00, 20, '2026-08-05', 'CS-PER-001'),
    (3, 'Logitech G203', 220.00, 25, '2026-08-06', 'CS-PER-002'),
    (4, 'Kingston NV2 1TB', 620.00, 18, '2026-08-07', 'CS-ALM-001'),
    (4, 'Crucial BX500 1TB', 590.00, 14, '2026-08-08', 'CS-ALM-002'),
    (5, 'JBL Quantum 100', 450.00, 11, '2026-08-09', 'CS-AUD-001'),
    (5, 'HyperX Cloud Stinger 2', 520.00, 9, '2026-08-10', 'CS-AUD-002');

INSERT INTO clientes (
    nombre_completo,
    correo,
    telefono,
    fecha_registro
)
VALUES
    ('Ana Lopez', 'ana.lopez@example.com', '555-0101', '2026-08-01'),
    ('Bruno Castillo', 'bruno.castillo@example.com', '555-0102', '2026-08-02'),
    ('Carla Mendez', 'carla.mendez@example.com', '555-0103', '2026-08-03'),
    ('Diego Perez', 'diego.perez@example.com', '555-0104', '2026-08-04'),
    ('Elena Garcia', 'elena.garcia@example.com', '555-0105', '2026-08-05');

INSERT INTO ventas (
    producto_id,
    cliente_id,
    cantidad,
    fecha_venta,
    total
)
VALUES
    (1, 1, 1, '2026-08-11', 2850.00),
    (2, 2, 1, '2026-08-11', 3100.00),
    (3, 3, 2, '2026-08-12', 2900.00),
    (4, 4, 1, '2026-08-12', 2200.00),
    (5, 5, 2, '2026-08-13', 560.00),
    (6, 3, 2, '2026-08-13', 440.00),
    (7, 4, 3, '2026-08-14', 1240.00),
    (8, 5, 3, '2026-08-14', 590.00),
    (9, 1, 2, '2026-08-15', 900.00),
    (10, 2, 2, '2026-08-16', 1040.00);