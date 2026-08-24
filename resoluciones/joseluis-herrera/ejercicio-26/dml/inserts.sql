
PRAGMA foreign_keys = ON;

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    correo,
    telefono,
    fecha_registro
) VALUES
    (1, 'Ana Lopez', 'ana.lopez@example.com', '55510001', '2026-01-10'),
    (2, 'Carlos Perez', 'carlos.perez@example.com', '55510002', '2026-01-12'),
    (3, 'Maria Gonzalez', 'maria.gonzalez@example.com', '55510003', '2026-01-15'),
    (4, 'Juan Ramirez', 'juan.ramirez@example.com', '55510004', '2026-01-18'),
    (5, 'Sofia Martinez', 'sofia.martinez@example.com', '55510005', '2026-01-20');

INSERT INTO categorias (
    id_categoria,
    nombre,
    descripcion
) VALUES
    (1, 'Computacion', 'Equipos y accesorios para computacion'),
    (2, 'Telefonia', 'Dispositivos y accesorios moviles'),
    (3, 'Audio', 'Equipos y accesorios de audio'),
    (4, 'Perifericos', 'Perifericos para computadores'),
    (5, 'Almacenamiento', 'Dispositivos para almacenamiento de datos');

INSERT INTO productos (
    id_producto,
    nombre,
    precio,
    stock,
    id_categoria
) VALUES
    (1, 'Laptop Lenovo IdeaPad', 6500.00, 12, 1),
    (2, 'Monitor Samsung 24', 1450.00, 20, 1),
    (3, 'Telefono Xiaomi Redmi', 2800.00, 15, 2),
    (4, 'Audifonos Sony WH', 950.00, 25, 3),
    (5, 'Teclado Logitech K120', 180.00, 40, 4);

INSERT INTO compras (
    id_compra,
    id_cliente,
    id_producto,
    cantidad,
    fecha_compra
) VALUES
    (1, 1, 1, 1, '2026-02-01 09:15'),
    (2, 2, 2, 2, '2026-02-03 10:30'),
    (3, 3, 3, 1, '2026-02-05 14:20'),
    (4, 4, 4, 3, '2026-02-07 16:45'),
    (5, 5, 5, 2, '2026-02-09 11:10'),
    (6, 1, 2, 1, '2026-02-12 13:25'),
    (7, 2, 4, 2, '2026-02-15 15:40'),
    (8, 3, 1, 1, '2026-02-18 09:50'),
    (9, 4, 5, 4, '2026-02-21 12:05'),
    (10, 5, 3, 2, '2026-02-25 17:30');