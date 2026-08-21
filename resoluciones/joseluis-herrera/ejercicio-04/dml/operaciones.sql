INSERT INTO mesas (
    id_mesa,
    numero_mesa,
    capacidad,
    estado
) VALUES (
    6,
    6,
    4,
    'DISPONIBLE'
);

INSERT INTO platos (
    id_plato,
    nombre,
    categoria,
    precio,
    disponible
) VALUES (
    6,
    'Tacos Campus',
    'Mexicana',
    26.00,
    1
);

UPDATE platos
SET precio = 30.00
WHERE id_plato = 1;

UPDATE mesas
SET estado = 'OCUPADA'
WHERE id_mesa = 1;

DELETE FROM mesas
WHERE id_mesa = 6;

DELETE FROM platos
WHERE id_plato = 6;

-- Operacion invalida: CHECK
-- INSERT INTO mesas (id_mesa, numero_mesa, capacidad, estado)
-- VALUES (7, 7, 0, 'DISPONIBLE');

-- Operacion invalida: FOREIGN KEY
-- INSERT INTO pedidos (id_pedido, id_mesa, fecha_pedido, estado)
-- VALUES (11, 999, '2026-08-10 12:00', 'ABIERTO');