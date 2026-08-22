PRAGMA foreign_keys = ON;

-- Ejercicio 02: Campus Shop SQLite
-- Datos base

-- Categorias (5 registros)
INSERT INTO categorias (nombre_categoria, descripcion) VALUES
    ('Computadoras',  'Laptops, desktops y componentes de computo'),
    ('Accesorios',    'Perifericos y accesorios para computadoras'),
    ('Pantallas',     'Monitores y pantallas de diferentes tamanos'),
    ('Audio',         'Audifonos, bocinas y equipos de sonido'),
    ('Redes',         'Routers, switches y cables de red');

-- Productos (5 registros)
INSERT INTO productos (nombre_producto, id_categoria, cantidad_stock, precio) VALUES
    ('Laptop Lenovo IdeaPad', 1, 10, 5500.00),
    ('Mouse Logitech MX',     2, 50, 350.00),
    ('Teclado Mecanico K200', 2, 30, 480.00),
    ('Monitor Samsung 24"',   3, 20, 1800.00),
    ('Audifonos Sony WH',     4, 25, 950.00);

-- Clientes (5 registros)
INSERT INTO clientes (nombre_cliente, telefono, direccion, email) VALUES
    ('Juan Perez',     '5551234', 'Zona 1, Guatemala',        'juan@mail.com'),
    ('Maria Lopez',    '5555678', 'Zona 10, Guatemala',       'maria@mail.com'),
    ('Carlos Gomez',   '5559012', 'Mixco, Guatemala',         'carlos@mail.com'),
    ('Ana Martinez',   '5553456', 'Villa Nueva, Guatemala',   'ana@mail.com'),
    ('Roberto Diaz',   '5557890', 'Zona 15, Guatemala',       'roberto@mail.com');

-- Ventas (10 registros)
INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
    (1, 1, 1, '2026-08-01'),
    (2, 2, 2, '2026-08-02'),
    (3, 3, 1, '2026-08-05'),
    (4, 4, 1, '2026-08-08'),
    (1, 2, 1, '2026-08-10'),
    (5, 5, 2, '2026-08-12'),
    (2, 1, 1, '2026-08-13'),
    (3, 2, 3, '2026-08-15'),
    (4, 3, 2, '2026-08-18'),
    (5, 4, 1, '2026-08-20');
