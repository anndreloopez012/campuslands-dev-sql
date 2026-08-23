PRAGMA foreign_keys = ON;

-- Ejercicio 036: Delivery de Comida
-- Datos de prueba.

INSERT INTO menus (nombre_platillo, categoria, precio) VALUES
    ('Pupusas Revueltas', 'entrada', 25.00),
    ('Alitas BBQ', 'entrada', 45.00),
    ('Hamburguesa Doble', 'plato_fuerte', 65.00),
    ('Pizza Pepperoni Familiar', 'plato_fuerte', 120.00),
    ('Pasta Alfredo', 'plato_fuerte', 58.00),
    ('Tres Leches', 'postre', 30.00),
    ('Limonada Frozen', 'bebida', 18.00),
    ('Tacos al Pastor x6', 'plato_fuerte', 50.00);

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Mariana Castillo', '5561234'),
    ('Estuardo Perez', '5567890'),
    ('Lucia Ramirez', '5562345'),
    ('Hector Gonzalez', '5563456'),
    ('Paola Enriquez', '5564567');

-- El pedido 10 es un duplicado por error de digitacion (mismo
-- cliente, platillo, repartidor, fecha y monto que el pedido 9): se
-- corrige en dml/operaciones.sql.
INSERT INTO pedidos (id_cliente, id_menu, repartidor, fecha_pedido, monto_pagado, estado, calificacion) VALUES
    (1, 4, 'Kevin Ajpop', '2026-08-10', 120.00, 'entregado', 5),
    (2, 3, 'Kevin Ajpop', '2026-08-11', 65.00, 'entregado', 4),
    (3, 8, 'Sara Tuy', '2026-08-12', 50.00, 'en_camino', NULL),
    (1, 6, 'Kevin Ajpop', '2026-08-12', 30.00, 'pendiente', NULL),
    (4, 2, 'Sara Tuy', '2026-08-13', 45.00, 'entregado', 3),
    (5, 5, 'Rene Xitumul', '2026-08-14', 58.00, 'entregado', 5),
    (2, 7, 'Kevin Ajpop', '2026-08-14', 18.00, 'cancelado', NULL),
    (3, 1, 'Sara Tuy', '2026-08-15', 25.00, 'entregado', 2),
    (1, 3, 'Rene Xitumul', '2026-08-16', 65.00, 'pendiente', NULL),
    (1, 3, 'Rene Xitumul', '2026-08-16', 65.00, 'pendiente', NULL);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- calificacion fuera de rango (mayor a 5), viola el CHECK de pedidos.
-- INSERT INTO pedidos (id_cliente, id_menu, repartidor, fecha_pedido, monto_pagado, estado, calificacion) VALUES (2, 1, 'Sara Tuy', '2026-08-17', 25.00, 'entregado', 6);
