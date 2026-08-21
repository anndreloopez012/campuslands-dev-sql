PRAGMA foreign_keys = ON;

INSERT INTO categorias (id_categoria, nombre) VALUES
    (1, 'Tecnologia'),
    (2, 'Hogar'),
    (3, 'Oficina'),
    (4, 'Deportes'),
    (5, 'Accesorios');

INSERT INTO clientes (id_cliente, nombre_completo, correo, telefono) VALUES
    (1, 'Ana Martinez', 'ana.martinez@example.com', '555-0101'),
    (2, 'Carlos Ramirez', 'carlos.ramirez@example.com', '555-0102'),
    (3, 'Laura Gomez', 'laura.gomez@example.com', '555-0103'),
    (4, 'Diego Hernandez', 'diego.hernandez@example.com', '555-0104'),
    (5, 'Sofia Lopez', 'sofia.lopez@example.com', '555-0105');

INSERT INTO productos (
    id_producto,
    nombre,
    sku,
    precio,
    stock,
    id_categoria
) VALUES
    (1, 'Laptop Pro 14', 'TEC-001', 1250.00, 15, 1),
    (2, 'Monitor 24 Pulgadas', 'TEC-002', 285.50, 22, 1),
    (3, 'Silla Ergonomica', 'HOG-001', 320.00, 10, 2),
    (4, 'Escritorio Modular', 'OFI-001', 450.00, 8, 3),
    (5, 'Balon Profesional', 'DEP-001', 75.00, 30, 4);

INSERT INTO compras (
    id_compra,
    id_cliente,
    id_producto,
    cantidad,
    fecha_compra
) VALUES
    (1, 1, 1, 1, '2026-08-01'),
    (2, 2, 2, 2, '2026-08-02'),
    (3, 3, 3, 1, '2026-08-03'),
    (4, 4, 4, 2, '2026-08-04'),
    (5, 5, 5, 3, '2026-08-05'),
    (6, 1, 2, 1, '2026-08-06'),
    (7, 2, 1, 1, '2026-08-07'),
    (8, 3, 4, 1, '2026-08-08'),
    (9, 4, 5, 2, '2026-08-09'),
    (10, 5, 3, 2, '2026-08-10');