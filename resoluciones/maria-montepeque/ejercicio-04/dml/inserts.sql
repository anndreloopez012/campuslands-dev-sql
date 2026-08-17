-- Ejercicio 04: Restaurante Campus
-- Datos base: 5 mesas, 5 platos, 6 pedidos, 10 detalle_pedido

INSERT INTO mesas (numero, capacidad) VALUES
    (1, 4),
    (2, 2),
    (3, 6),
    (4, 4),
    (5, 8);

INSERT INTO platos (nombre, categoria, precio) VALUES
    ('Hamburguesa clasica', 'Plato fuerte', 45.00),
    ('Ensalada campus', 'Entrada', 25.00),
    ('Pasta alfredo', 'Plato fuerte', 50.00),
    ('Limonada', 'Bebida', 12.00),
    ('Brownie con helado', 'Postre', 20.00);

INSERT INTO pedidos (id_mesa, fecha_hora, estado) VALUES
    (1, '2026-08-01 12:30', 'cerrado'),
    (2, '2026-08-01 13:00', 'cerrado'),
    (3, '2026-08-02 19:15', 'cerrado'),
    (4, '2026-08-02 20:00', 'abierto'),
    (5, '2026-08-03 13:30', 'abierto'),
    (1, '2026-08-03 20:30', 'cancelado');

INSERT INTO detalle_pedido (id_pedido, id_plato, cantidad, precio_unitario) VALUES
    (1, 1, 2, 45.00),
    (1, 4, 2, 12.00),
    (2, 2, 1, 25.00),
    (2, 4, 1, 12.00),
    (3, 3, 3, 50.00),
    (3, 5, 2, 20.00),
    (4, 1, 1, 45.00),
    (4, 3, 1, 50.00),
    (5, 2, 2, 25.00),
    (5, 4, 2, 12.00);
