PRAGMA foreign_keys = ON;
-- Ejercicio 32: Normalizacion Pedidos Restaurante

INSERT INTO
    mesero (id_mesero, nombre)
VALUES (1, 'Sofia Mendez'),
    (2, 'Diego Ruiz'),
    (3, 'Carla Lopez');

INSERT INTO
    mesa (id_mesa, numero)
VALUES (1, 4),
    (2, 2),
    (3, 1), 
    (4, 6);

INSERT INTO
    categoria (id_categoria, nombre)
VALUES (1, 'Comida'),
    (2, 'Bebida'),
    (3, 'Acompanamiento'),
    (4, 'Postre');

INSERT INTO
    plato (
        id_plato,
        nombre,
        precio,
        id_categoria
    )
VALUES (1, 'Pizza', 85, 1),
    (2, 'Limonada', 18, 2),
    (3, 'Hamburguesa', 55, 1),
    (4, 'Papas', 22, 3),
    (5, 'Cafe', 15, 2),
    (6, 'Pastel', 30, 4),
    (7, 'Ensalada', 40, 1), 
    (8, 'Agua', 10, 2);

INSERT INTO
    pedido (
        id_pedido,
        id_mesa,
        id_mesero,
        fecha_pedido
    )
VALUES (1, 1, 1, '2026-06-01'), 
    (2, 2, 1, '2026-06-01'), 
    (3, 1, 2, '2026-06-02'), 
    (4, 3, 3, '2026-06-03'), 
    (5, 4, 2, '2026-06-05'), 
    (6, 2, 3, '2026-06-06');

INSERT INTO
    detalle_pedido (id_pedido, id_plato, cantidad)
VALUES (1, 1, 2), 
    (1, 2, 2), 
    (2, 3, 1), 
    (2, 4, 1), 
    (3, 5, 2),
    (3, 6, 1), 
    (4, 7, 3), 
    (4, 8, 2), 
    (4, 2, 1), 
    (5, 1, 1), 
    (5, 3, 2), 
    (5, 6, 4);
