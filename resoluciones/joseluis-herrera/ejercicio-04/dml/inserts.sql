INSERT INTO mesas (
    id_mesa,
    numero_mesa,
    capacidad,
    estado
) VALUES
    (1, 1, 2, 'DISPONIBLE'),
    (2, 2, 4, 'OCUPADA'),
    (3, 3, 4, 'OCUPADA'),
    (4, 4, 6, 'RESERVADA'),
    (5, 5, 8, 'DISPONIBLE');

INSERT INTO platos (
    id_plato,
    nombre,
    categoria,
    precio,
    disponible
) VALUES
    (1, 'Hamburguesa Campus', 'Hamburguesas', 28.50, 1),
    (2, 'Pizza Familiar', 'Pizzas', 55.00, 1),
    (3, 'Pasta Alfredo', 'Pastas', 32.00, 1),
    (4, 'Ensalada Cesar', 'Ensaladas', 22.00, 1),
    (5, 'Limonada Natural', 'Bebidas', 12.00, 1);

INSERT INTO pedidos (
    id_pedido,
    id_mesa,
    fecha_pedido,
    estado
) VALUES
    (1, 1, '2026-08-01 12:15', 'PAGADO'),
    (2, 2, '2026-08-01 13:00', 'PAGADO'),
    (3, 3, '2026-08-02 13:30', 'PAGADO'),
    (4, 4, '2026-08-02 18:45', 'PAGADO'),
    (5, 5, '2026-08-03 19:00', 'PAGADO'),
    (6, 2, '2026-08-04 12:30', 'PAGADO'),
    (7, 3, '2026-08-05 14:00', 'PAGADO'),
    (8, 1, '2026-08-06 18:30', 'PAGADO'),
    (9, 4, '2026-08-07 19:15', 'SERVIDO'),
    (10, 5, '2026-08-08 20:00', 'ABIERTO');

INSERT INTO detalle_pedido (
    id_detalle,
    id_pedido,
    id_plato,
    cantidad,
    precio_unitario
) VALUES
    (1, 1, 1, 2, 28.50),
    (2, 2, 2, 1, 55.00),
    (3, 3, 3, 2, 32.00),
    (4, 4, 4, 2, 22.00),
    (5, 5, 5, 4, 12.00),
    (6, 6, 1, 3, 28.50),
    (7, 7, 2, 2, 55.00),
    (8, 8, 3, 1, 32.00),
    (9, 9, 1, 2, 28.50),
    (10, 10, 5, 3, 12.00);