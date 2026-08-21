PRAGMA foreign_keys = ON;

-- Ejercicio 011: Delivery de Comida
-- Datos de prueba.

INSERT INTO menus (nombre_platillo, categoria, precio) VALUES
    ('Hamburguesa Clasica', 'plato_fuerte', 65.00),
    ('Pizza Familiar', 'plato_fuerte', 120.00),
    ('Ensalada Cesar', 'entrada', 45.00),
    ('Alitas BBQ', 'entrada', 55.00),
    ('Brownie con Helado', 'postre', 35.00),
    ('Limonada Natural', 'bebida', 20.00);

-- calificacion se deja NULL en los pedidos que no estan entregados: solo
-- tiene sentido calificar un pedido que ya llego. El pedido 10 es una
-- entrada de prueba (cliente "Cuenta de Prueba") que se cargo por error:
-- se elimina en dml/operaciones.sql.
INSERT INTO pedidos (id_menu, nombre_cliente, repartidor, cantidad, monto_total, fecha_pedido, estado, calificacion) VALUES
    (1, 'Ana Gomez', 'Carlos Ruiz', 1, 65.00, '2026-08-01 12:00', 'entregado', 5),
    (2, 'Luis Marroquin', 'Pedro Gomez', 1, 120.00, '2026-08-01 13:00', 'entregado', 4),
    (4, 'Karen Solis', 'Carlos Ruiz', 2, 110.00, '2026-08-02 12:30', 'en_camino', NULL),
    (1, 'Ana Gomez', 'Sofia Reyes', 1, 65.00, '2026-08-02 13:00', 'recibido', NULL),
    (5, 'Rosa Chavez', 'Pedro Gomez', 2, 70.00, '2026-08-03 14:00', 'entregado', 5),
    (6, 'Julio Perez', 'Carlos Ruiz', 3, 60.00, '2026-08-03 15:00', 'cancelado', NULL),
    (2, 'Ana Gomez', 'Sofia Reyes', 1, 120.00, '2026-08-04 12:00', 'entregado', 3),
    (3, 'Luis Marroquin', 'Pedro Gomez', 1, 45.00, '2026-08-04 13:00', 'en_camino', NULL),
    (1, 'Diego Paz', 'Carlos Ruiz', 1, 65.00, '2026-08-05 12:00', 'recibido', NULL),
    (1, 'Cuenta de Prueba', 'Test', 1, 65.00, '2026-08-01 12:00', 'recibido', NULL);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- calificacion fuera del rango 1-5, viola el CHECK de pedidos.
-- INSERT INTO pedidos (id_menu, nombre_cliente, repartidor, cantidad, monto_total, estado, calificacion) VALUES (1, 'Mario Paz', 'Sofia Reyes', 1, 65.00, 'entregado', 9);
