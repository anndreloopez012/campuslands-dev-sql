PRAGMA foreign_keys = ON;

INSERT INTO
    categorias (id, nombre, estado)
VALUES (1, 'Tecnología', 'activo'),
    (2, 'Papelería', 'activo'),
    (3, 'Ropa', 'activo'),
    (4, 'Alimentos', 'activo'),
    (5, 'Accesorios', 'inactivo');

INSERT INTO
    productos (
        id,
        nombre,
        precio,
        stock,
        categoria_id
    )
VALUES (
        1,
        'Audífonos USB',
        45000,
        30,
        1
    ),
    (
        2,
        'Mouse inalámbrico',
        38000,
        12,
        1
    ),
    (
        3,
        'Teclado mecánico',
        120000,
        8,
        1
    ),
    (
        4,
        'Cuaderno argollado',
        8000,
        100,
        2
    ),
    (
        5,
        'Bolígrafo gel x3',
        6500,
        200,
        2
    ),
    (
        6,
        'Camiseta Campus',
        35000,
        50,
        3
    ),
    (
        7,
        'Hoodie Campus',
        89000,
        20,
        3
    ),
    (8, 'Café 250g', 18000, 40, 4),
    (
        9,
        'Galletas avena',
        4500,
        150,
        4
    ),
    (
        10,
        'Termo metálico',
        55000,
        5,
        5
    );

INSERT INTO
    clientes (
        id,
        nombre,
        email,
        fecha_registro
    )
VALUES (
        1,
        'Laura Gómez',
        'laura@campus.edu',
        '2025-01-10'
    ),
    (
        2,
        'Andrés Ruiz',
        'andres@campus.edu',
        '2025-02-15'
    ),
    (
        3,
        'María Pérez',
        'maria@campus.edu',
        '2025-03-01'
    ),
    (
        4,
        'Carlos Díaz',
        'carlos@campus.edu',
        '2025-03-20'
    ),
    (
        5,
        'Sofía Llanos',
        'sofia@campus.edu',
        '2025-04-05'
    ),
    (
        6,
        'Diego Mora',
        'diego@campus.edu',
        '2025-05-12'
    );

INSERT INTO
    pedidos (id, cliente_id, fecha, estado)
VALUES (1, 1, '2025-04-01', 'pagado'),
    (2, 2, '2025-04-03', 'enviado'),
    (
        3,
        1,
        '2025-04-10',
        'pendiente'
    ),
    (4, 3, '2025-04-15', 'pagado'),
    (
        5,
        4,
        '2025-04-20',
        'cancelado'
    ),
    (6, 5, '2025-05-01', 'pagado'),
    (7, 2, '2025-05-05', 'enviado'),
    (8, 6, '2025-05-10', 'pagado');

INSERT INTO
    detalle_pedidos (
        pedido_id,
        producto_id,
        cantidad,
        precio_unitario
    )
VALUES (1, 1, 2, 45000),
    (1, 4, 3, 8000),
    (2, 3, 1, 120000),
    (3, 6, 2, 35000),
    (3, 9, 5, 4500),
    (4, 2, 1, 38000),
    (4, 5, 4, 6500),
    (5, 7, 1, 89000),
    (6, 1, 1, 45000),
    (6, 8, 2, 18000),
    (7, 10, 1, 55000),
    (7, 6, 3, 35000),
    (8, 4, 10, 8000),
    (8, 9, 10, 4500);