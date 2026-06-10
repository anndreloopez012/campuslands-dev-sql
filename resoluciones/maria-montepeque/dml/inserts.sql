PRAGMA foreign_keys = ON;

-- Ejercicio 31: Normalizacion Ventas Campus

-- SUCURSALES
INSERT INTO
    sucursales (id_sucursal, nombre)
VALUES (1, 'Sede Norte'),
    (2, 'Sede Centro'),
    (3, 'Sede Sur');
    
-- VENDEDORES 
INSERT INTO
    vendedores (
        id_vendedor,
        nombre,
        id_sucursal
    )
VALUES (1, 'Luis Rojas', 1),
    (2, 'Marta Lopez', 2),
    (3, 'Pedro Gomez', 3);
    
-- CLIENTES
INSERT INTO
    clientes (id_cliente, nombre, email)
VALUES (
        1,
        'Ana Perez',
        'ana@mail.com'
    ),
    (
        2,
        'Carlos Diaz',
        'carlos@mail.com'
    ),
    (
        3,
        'Sofia Mejia',
        'sofia@mail.com'
    );

-- PRODUCTOS
INSERT INTO
    productos (id_producto, nombre, precio)
VALUES (1, 'Mouse Gamer', 125),
    (2, 'Teclado RGB', 260),
    (3, 'Monitor 24', 1450),
    (4, 'USB 64GB', 75),
    (5, 'Base Laptop', 180),
    (6, 'Webcam HD', 320);

-- VENTAS
INSERT INTO
    ventas (
        id_venta,
        id_cliente,
        id_vendedor,
        fecha
    )
VALUES (1, 1, 1, '2025-01-10'), 
    (2, 2, 2, '2025-01-11'), 
    (3, 1, 1, '2025-01-15'),
    (4, 3, 3, '2025-02-01');

-- DETALLE_VENTA
INSERT INTO
    detalle_venta (
        id_venta,
        id_producto,
        cantidad,
        precio_unitario
    )
VALUES
    (1, 1, 1, 125),
    (1, 2, 2, 260),
    (2, 3, 1, 1450),
    (2, 1, 1, 125),
    (3, 4, 3, 75),
    (3, 5, 1, 180),
    (4, 6, 2, 320),
    (4, 1, 1, 125);

