INSERT INTO categorias (nombre) 
    VALUES ('Laptops'),
    ('Perifericos'),
    ('Almacenamiento'),
    ('Audio'),
    ('Accesorios');

INSERT INTO clientes (nombre, correo, telefono) 
    VALUES ('Ana Ramirez', 'ana.ramirez@correo.com', '5551001'),
    ('Luis Gomez', 'luis.gomez@correo.com', '5551002'),
    ('Karla Diaz', 'karla.diaz@correo.com', '5551003'),
    ('Pedro Suarez', 'pedro.suarez@correo.com', '5551004'),
    ('Sofia Leon', 'sofia.leon@correo.com', '5551005');

INSERT INTO productos (id_categoria, nombre, precio, stock) 
    VALUES (1, 'Laptop 14 pulgadas', 650.00, 12),
    (2, 'Mouse inalambrico', 18.50, 40),
    (2, 'Teclado mecanico', 45.00, 25),
    (3, 'SSD 500GB', 55.00, 30),
    (4, 'Audifonos bluetooth', 32.00, 20),
    (5, 'Mochila para laptop', 28.00, 15);

INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) 
    VALUES (1, 1, 1, 650.00, '2026-08-01'),
    (2, 2, 2, 18.50, '2026-08-01'),
    (3, 3, 1, 45.00, '2026-08-02'),
    (4, 4, 3, 55.00, '2026-08-02'),
    (5, 5, 1, 32.00, '2026-08-03'),
    (1, 6, 1, 28.00, '2026-08-03'),
    (2, 1, 1, 650.00, '2026-08-04'),
    (3, 5, 2, 32.00, '2026-08-04'),
    (4, 2, 3, 18.50, '2026-08-05'),
    (5, 3, 1, 45.00, '2026-08-05');
