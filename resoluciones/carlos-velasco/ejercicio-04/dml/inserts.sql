PRAGMA foreign_keys = ON;

-- =========================================================
-- MESAS
-- =========================================================

INSERT INTO mesas (
    id_mesa,
    numero,
    capacidad,
    ubicacion,
    estado
) VALUES
    (1, 1, 2, 'Interior', 'LIBRE'),
    (2, 2, 4, 'Interior', 'OCUPADA'),
    (3, 3, 4, 'Terraza', 'OCUPADA'),
    (4, 4, 6, 'Terraza', 'RESERVADA'),
    (5, 5, 8, 'Salon principal', 'OCUPADA');

-- =========================================================
-- PLATOS
-- =========================================================

INSERT INTO platos (
    id_plato,
    nombre,
    categoria,
    precio,
    disponible
) VALUES
    (1, 'Hamburguesa Campus', 'Hamburguesas', 18.50, 1),
    (2, 'Pizza Personal', 'Pizza', 22.00, 1),
    (3, 'Pasta Alfredo', 'Pastas', 24.50, 1),
    (4, 'Ensalada Cesar', 'Ensaladas', 15.00, 1),
    (5, 'Limonada Natural', 'Bebidas', 7.50, 1);

-- =========================================================
-- PEDIDOS
-- =========================================================

INSERT INTO pedidos (
    id_pedido,
    id_mesa,
    fecha_pedido,
    estado
) VALUES
    (1, 1, '2026-08-01 12:10:00', 'PAGADO'),
    (2, 2, '2026-08-01 12:35:00', 'PAGADO'),
    (3, 3, '2026-08-02 13:00:00', 'PAGADO'),
    (4, 4, '2026-08-03 18:20:00', 'PAGADO'),
    (5, 5, '2026-08-04 19:10:00', 'PAGADO'),
    (6, 2, '2026-08-05 12:45:00', 'PAGADO'),
    (7, 3, '2026-08-06 13:30:00', 'PAGADO'),
    (8, 5, '2026-08-07 19:00:00', 'PAGADO'),
    (9, 1, '2026-08-08 20:15:00', 'PAGADO'),
    (10, 4, '2026-08-09 14:00:00', 'ABIERTO');

-- =========================================================
-- DETALLES DE PEDIDOS
-- =========================================================

INSERT INTO detalle_pedido (
    id_detalle,
    id_pedido,
    id_plato,
    cantidad,
    precio_unitario
) VALUES
    (1, 1, 1, 2, 18.50),
    (2, 1, 5, 2, 7.50),

    (3, 2, 2, 1, 22.00),
    (4, 2, 5, 2, 7.50),

    (5, 3, 3, 2, 24.50),
    (6, 3, 4, 1, 15.00),

    (7, 4, 2, 2, 22.00),
    (8, 4, 5, 2, 7.50),

    (9, 5, 1, 3, 18.50),
    (10, 5, 4, 2, 15.00),

    (11, 6, 3, 1, 24.50),
    (12, 6, 5, 1, 7.50),

    (13, 7, 1, 2, 18.50),
    (14, 8, 2, 2, 22.00),
    (15, 9, 4, 3, 15.00);