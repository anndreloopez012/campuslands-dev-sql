INSERT INTO mesas (id_mesa, numero_mesa, capacidad, estado) VALUES
(1, 1, 2, 'disponible'),
(2, 2, 4, 'ocupada'),
(3, 3, 4, 'disponible'),
(4, 4, 6, 'ocupada'),
(5, 5, 8, 'disponible'),
(6, 6, 2, 'disponible');

INSERT INTO meseros (id_mesero, nombre_completo, turno, estado) VALUES
(1, 'Ana López', 'manana', 'activo'),
(2, 'Carlos Méndez', 'tarde', 'activo'),
(3, 'María García', 'tarde', 'activo'),
(4, 'Luis Ramírez', 'noche', 'activo'),
(5, 'Sofía Hernández', 'noche', 'activo');

INSERT INTO categorias (id_categoria, nombre) VALUES
(1, 'Entradas'),
(2, 'Platos fuertes'),
(3, 'Hamburguesas'),
(4, 'Bebidas'),
(5, 'Postres'),
(6, 'Ensaladas');

INSERT INTO platos (id_plato, nombre, id_categoria, precio, estado) VALUES
(1, 'Nachos con queso', 1, 18000, 'activo'),
(2, 'Sopa de tomate', 1, 12000, 'activo'),
(3, 'Pollo a la plancha', 2, 28000, 'activo'),
(4, 'Pasta Alfredo', 2, 26000, 'activo'),
(5, 'Hamburguesa clásica', 3, 24000, 'activo'),
(6, 'Hamburguesa BBQ', 3, 29000, 'activo'),
(7, 'Limonada natural', 4, 8000, 'activo'),
(8, 'Gaseosa', 4, 6000, 'activo'),
(9, 'Torta de chocolate', 5, 14000, 'activo'),
(10, 'Ensalada César', 6, 18000, 'activo');

INSERT INTO pedidos (id_pedido, id_mesa, id_mesero, fecha_pedido, estado) VALUES
(1, 1, 1, '2026-08-01 12:30:00', 'pagado'),
(2, 2, 2, '2026-08-01 13:15:00', 'pagado'),
(3, 3, 3, '2026-08-02 14:00:00', 'pagado'),
(4, 4, 4, '2026-08-02 19:30:00', 'pagado'),
(5, 5, 5, '2026-08-03 20:15:00', 'pagado'),
(6, 1, 1, '2026-08-04 12:45:00', 'pagado'),
(7, 2, 2, '2026-08-04 18:20:00', 'pagado'),
(8, 3, 3, '2026-08-05 19:10:00', 'pagado'),
(9, 4, 4, '2026-08-06 20:00:00', 'abierto'),
(10, 5, 5, '2026-08-07 13:40:00', 'pagado'),
(11, 6, 1, '2026-08-08 12:20:00', 'pagado'),
(12, 2, 3, '2026-08-09 18:45:00', 'pagado');

INSERT INTO detalle_pedido (id_pedido, id_plato, cantidad, precio_unitario) VALUES
(1, 3, 2, 28000),
(1, 7, 2, 8000),
(2, 5, 2, 24000),
(2, 8, 2, 6000),
(3, 4, 1, 26000),
(3, 10, 1, 18000),
(4, 6, 2, 29000),
(4, 7, 2, 8000),
(5, 3, 3, 28000),
(5, 9, 1, 14000),
(6, 1, 1, 18000),
(6, 7, 1, 8000),
(7, 5, 3, 24000),
(7, 8, 3, 6000),
(8, 2, 2, 12000),
(8, 4, 2, 26000),
(9, 6, 1, 29000),
(9, 10, 1, 18000),
(10, 3, 2, 28000),
(10, 9, 2, 14000),
(11, 1, 2, 18000),
(11, 8, 2, 6000),
(12, 4, 1, 26000),
(12, 7, 2, 8000);

-- CASOS INVALIDOS

-- INSERT INTO mesas (id_mesa, numero_mesa, capacidad, estado)
-- VALUES (7, 1, 4, 'disponible');

-- INSERT INTO detalle_pedido (id_pedido, id_plato, cantidad, precio_unitario)
-- VALUES (1, 3, 0, 28000);