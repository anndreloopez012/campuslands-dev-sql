PRAGMA foreign_keys = ON;

-- Ejercicio 04: Restaurante Campus
INSERT INTO
    mesas (
        numero,
        capacidad,
        ubicacion,
        estado
    )
VALUES (
        1,
        2,
        'interior',
        'disponible'
    ),
    (2, 4, 'interior', 'ocupada'),
    (3, 4, 'terraza', 'disponible'),
    (4, 6, 'terraza', 'reservada'),
    (5, 2, 'barra', 'disponible');

INSERT INTO
    platos (
        nombre,
        categoria,
        precio,
        disponible
    )
VALUES (
        'Sopa de tortilla',
        'entrada',
        35.00,
        1
    ),
    (
        'Ensalada Campus',
        'entrada',
        42.00,
        1
    ),
    (
        'Pechuga a la plancha',
        'fuerte',
        95.00,
        1
    ),
    (
        'Lomo saltado',
        'fuerte',
        120.00,
        1
    ),
    (
        'Pastel de chocolate',
        'postre',
        48.00,
        1
    ),
    (
        'Limonada natural',
        'bebida',
        25.00,
        1
    );

INSERT INTO
    pedidos (id_mesa, fecha_pedido, estado)
VALUES (
        2,
        '2025-06-01 13:05',
        'pagado'
    ),
    (
        2,
        '2025-06-01 14:20',
        'pagado'
    ),
    (
        3,
        '2025-06-02 12:40',
        'pagado'
    ),
    (
        1,
        '2025-06-02 13:15',
        'pagado'
    ),
    (
        5,
        '2025-06-03 19:30',
        'abierto'
    ),
    (
        4,
        '2025-06-03 20:10',
        'cancelado'
    ),
    (
        3,
        '2025-06-04 12:00',
        'pagado'
    );

INSERT INTO
    detalle_pedido (
        id_pedido,
        id_plato,
        cantidad,
        precio_unitario
    )
VALUES (1, 1, 2, 35.00),
    (1, 3, 2, 95.00),
    (1, 6, 2, 25.00),
    (2, 4, 1, 120.00),
    (2, 5, 1, 48.00),
    (3, 2, 1, 42.00),
    (3, 3, 1, 95.00),
    (3, 6, 1, 25.00),
    (4, 1, 1, 35.00),
    (4, 6, 1, 25.00),
    (5, 4, 2, 120.00),
    (7, 5, 3, 48.00);