-- CATEGORIAS

INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES
(1, 'Computadores', 'Computadores portatiles y de escritorio'),
(2, 'Perifericos', 'Dispositivos de entrada y salida'),
(3, 'Monitores', 'Pantallas para computadores'),
(4, 'Almacenamiento', 'Discos y unidades de almacenamiento'),
(5, 'Accesorios', 'Accesorios tecnologicos');

-- PRODUCTOS

INSERT INTO productos (
    id_producto,
    id_categoria,
    nombre,
    precio,
    stock,
    fecha_ingreso
) VALUES
(1, 1, 'Laptop Pro 14', 4200.00, 15, '2026-01-10'),
(2, 1, 'Laptop Air 13', 3500.00, 20, '2026-01-15'),
(3, 2, 'Teclado Mecanico RGB', 450.00, 30, '2026-02-01'),
(4, 2, 'Mouse Inalambrico Pro', 280.00, 40, '2026-02-05'),
(5, 3, 'Monitor IPS 24', 1200.00, 18, '2026-02-10'),
(6, 4, 'SSD NVMe 1TB', 850.00, 25, '2026-02-15'),
(7, 5, 'Webcam Full HD', 520.00, 22, '2026-02-20');

-- CLIENTES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    correo,
    telefono,
    fecha_registro
) VALUES
(1, 'Ana Martinez', 'ana.martinez@email.com', '55510001', '2026-01-05'),
(2, 'Carlos Lopez', 'carlos.lopez@email.com', '55510002', '2026-01-08'),
(3, 'Maria Gonzalez', 'maria.gonzalez@email.com', '55510003', '2026-01-12'),
(4, 'Diego Ramirez', 'diego.ramirez@email.com', '55510004', '2026-01-18'),
(5, 'Sofia Hernandez', 'sofia.hernandez@email.com', '55510005', '2026-01-22'),
(6, 'Luis Perez', 'luis.perez@email.com', '55510006', '2026-01-25'),
(7, 'Valeria Castillo', 'valeria.castillo@email.com', '55510007', '2026-01-28');

-- VENTAS

INSERT INTO ventas (
    id_venta,
    id_cliente,
    id_producto,
    cantidad,
    precio_unitario,
    fecha_venta
) VALUES
(1, 1, 1, 1, 4200.00, '2026-03-01'),
(2, 2, 3, 2, 450.00, '2026-03-02'),
(3, 3, 5, 1, 1200.00, '2026-03-03'),
(4, 4, 6, 2, 850.00, '2026-03-04'),
(5, 5, 4, 1, 280.00, '2026-03-05'),
(6, 1, 2, 1, 3500.00, '2026-03-06'),
(7, 2, 7, 2, 520.00, '2026-03-07'),
(8, 3, 3, 1, 450.00, '2026-03-08'),
(9, 4, 5, 2, 1200.00, '2026-03-09'),
(10, 5, 6, 1, 850.00, '2026-03-10');