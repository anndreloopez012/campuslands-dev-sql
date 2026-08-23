PRAGMA foreign_keys = ON;

-- Ejercicio 004: Tienda Sneakers
-- Datos de prueba (una semana: 2026-08-10 a 2026-08-16).

INSERT INTO productos (nombre_modelo, talla, precio, stock) VALUES
    ('Air Max 90', 38, 450.00, 10),
    ('Air Max 90', 40, 450.00, 8),
    ('Ultraboost 22', 39, 520.00, 5),
    ('Jordan Retro 1', 41, 680.00, 6),
    ('Chuck Taylor All Star', 37, 320.00, 15),
    ('Yeezy Boost 350', 42, 750.00, 3);

-- El pedido 8 es una duplicada por error de digitacion (mismo producto,
-- cliente, cantidad, precio y fecha que el pedido 2): se corrige en
-- dml/operaciones.sql.
INSERT INTO pedidos (id_producto, nombre_cliente, cantidad, precio_total, fecha_pedido, estado) VALUES
    (1, 'Ana Gomez', 1, 450.00, '2026-08-10 10:00', 'entregado'),
    (3, 'Luis Marroquin', 1, 520.00, '2026-08-11 11:00', 'entregado'),
    (4, 'Karen Solis', 1, 680.00, '2026-08-11 15:00', 'enviado'),
    (2, 'Ana Gomez', 2, 900.00, '2026-08-12 09:00', 'pendiente'),
    (5, 'Diego Paz', 1, 320.00, '2026-08-13 14:00', 'entregado'),
    (6, 'Rosa Chavez', 1, 750.00, '2026-08-14 10:30', 'cancelado'),
    (1, 'Luis Marroquin', 1, 450.00, '2026-08-15 12:00', 'entregado'),
    (3, 'Luis Marroquin', 1, 520.00, '2026-08-11 11:00', 'entregado'),
    (2, 'Luis Marroquin', 1, 450.00, '2026-08-16 09:00', 'pendiente');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- talla fuera del rango permitido por el CHECK de productos.
-- INSERT INTO productos (nombre_modelo, talla, precio) VALUES ('Air Max 90', 60, 450.00);
