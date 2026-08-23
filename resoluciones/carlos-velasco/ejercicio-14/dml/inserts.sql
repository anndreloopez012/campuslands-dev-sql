PRAGMA foreign_keys = ON;

-- VENDEDORES

INSERT INTO vendedores (
    id_vendedor,
    nombre_completo,
    correo,
    ciudad,
    fecha_registro,
    estado
) VALUES
(1, 'Carlos Ramirez', 'carlos.ramirez@marketplace.com', 'Ciudad de Guatemala', '2025-01-10', 'Activo'),
(2, 'Ana Martinez', 'ana.martinez@marketplace.com', 'Mixco', '2025-01-18', 'Activo'),
(3, 'Luis Gonzalez', 'luis.gonzalez@marketplace.com', 'Villa Nueva', '2025-02-05', 'Activo'),
(4, 'Sofia Herrera', 'sofia.herrera@marketplace.com', 'Antigua Guatemala', '2025-02-20', 'Activo'),
(5, 'Diego Morales', 'diego.morales@marketplace.com', 'Quetzaltenango', '2025-03-12', 'Activo');

-- PRODUCTOS

INSERT INTO productos (
    id_producto,
    id_vendedor,
    nombre,
    categoria,
    precio,
    stock,
    estado
) VALUES
(1, 1, 'Laptop Pro 14', 'Computadores', 5200.00, 12, 'Disponible'),
(2, 1, 'Mouse Inalambrico', 'Accesorios', 180.00, 35, 'Disponible'),
(3, 2, 'Teclado Mecanico', 'Accesorios', 450.00, 20, 'Disponible'),
(4, 2, 'Monitor 27 Pulgadas', 'Monitores', 1850.00, 8, 'Disponible'),
(5, 3, 'Audifonos Bluetooth', 'Audio', 650.00, 25, 'Disponible'),
(6, 3, 'Webcam HD', 'Accesorios', 390.00, 18, 'Disponible'),
(7, 4, 'Tablet 10 Pulgadas', 'Tablets', 2100.00, 10, 'Disponible'),
(8, 4, 'Smartwatch Active', 'Wearables', 950.00, 15, 'Disponible'),
(9, 5, 'SSD 1TB', 'Almacenamiento', 780.00, 22, 'Disponible'),
(10, 5, 'Memoria RAM 16GB', 'Componentes', 620.00, 30, 'Disponible');

-- COMPRADORES

INSERT INTO compradores (
    id_comprador,
    nombre_completo,
    correo,
    ciudad,
    fecha_registro,
    estado
) VALUES
(1, 'Maria Lopez', 'maria.lopez@email.com', 'Ciudad de Guatemala', '2025-04-01', 'Activo'),
(2, 'Juan Perez', 'juan.perez@email.com', 'Mixco', '2025-04-08', 'Activo'),
(3, 'Laura Castillo', 'laura.castillo@email.com', 'Villa Nueva', '2025-04-15', 'Activo'),
(4, 'Miguel Santos', 'miguel.santos@email.com', 'Antigua Guatemala', '2025-05-02', 'Activo'),
(5, 'Valeria Cruz', 'valeria.cruz@email.com', 'Quetzaltenango', '2025-05-10', 'Activo');

-- ORDENES

INSERT INTO ordenes (
    id_orden,
    id_vendedor,
    id_producto,
    id_comprador,
    cantidad,
    precio_unitario,
    fecha_orden,
    estado
) VALUES
(1, 1, 1, 1, 1, 5200.00, '2026-08-01 09:15', 'Entregada'),
(2, 1, 2, 2, 2, 180.00, '2026-08-02 10:30', 'Entregada'),
(3, 2, 3, 3, 1, 450.00, '2026-08-03 11:00', 'Pagada'),
(4, 2, 4, 4, 2, 1850.00, '2026-08-04 14:20', 'Enviada'),
(5, 3, 5, 5, 1, 650.00, '2026-08-05 15:45', 'Entregada'),
(6, 3, 6, 1, 3, 390.00, '2026-08-06 09:40', 'Pagada'),
(7, 4, 7, 2, 1, 2100.00, '2026-08-07 13:10', 'Entregada'),
(8, 4, 8, 3, 2, 950.00, '2026-08-08 16:30', 'Enviada'),
(9, 5, 9, 4, 2, 780.00, '2026-08-09 10:05', 'Entregada'),
(10, 5, 10, 5, 4, 620.00, '2026-08-10 12:25', 'Pagada'),
(11, 1, 1, 3, 1, 5200.00, '2026-08-11 09:50', 'Entregada'),
(12, 2, 4, 5, 1, 1850.00, '2026-08-12 14:15', 'Pendiente');