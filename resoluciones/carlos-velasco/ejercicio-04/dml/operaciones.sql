PRAGMA foreign_keys = ON;

-- =========================================================
-- 1. INSERT adicional
-- =========================================================

INSERT INTO mesas (
    id_mesa,
    numero,
    capacidad,
    ubicacion,
    estado
) VALUES (
    6,
    6,
    4,
    'Interior',
    'LIBRE'
);

-- =========================================================
-- 2. INSERT adicional
-- =========================================================

INSERT INTO platos (
    id_plato,
    nombre,
    categoria,
    precio,
    disponible
) VALUES (
    6,
    'Brownie de Chocolate',
    'Postres',
    10.00,
    1
);

-- =========================================================
-- 3. UPDATE válido
-- =========================================================

UPDATE mesas
SET estado = 'RESERVADA'
WHERE id_mesa = 6;

-- =========================================================
-- 4. UPDATE válido
-- =========================================================

UPDATE platos
SET precio = 11.00
WHERE id_plato = 6;

-- =========================================================
-- 5. DELETE controlado
-- =========================================================

DELETE FROM mesas
WHERE id_mesa = 6;

-- =========================================================
-- 6. DELETE controlado
-- =========================================================

DELETE FROM platos
WHERE id_plato = 6;

-- =========================================================
-- OPERACIONES QUE DEBEN FALLAR
-- Se mantienen comentadas.
-- =========================================================

-- CHECK: la capacidad debe estar entre 1 y 20.
-- INSERT INTO mesas (
--     id_mesa,
--     numero,
--     capacidad,
--     ubicacion,
--     estado
-- ) VALUES (
--     7,
--     7,
--     0,
--     'Interior',
--     'LIBRE'
-- );

-- UNIQUE: el numero de mesa 1 ya existe.
-- INSERT INTO mesas (
--     id_mesa,
--     numero,
--     capacidad,
--     ubicacion,
--     estado
-- ) VALUES (
--     8,
--     1,
--     4,
--     'Terraza',
--     'LIBRE'
-- );

-- FOREIGN KEY: la mesa 999 no existe.
-- INSERT INTO pedidos (
--     id_pedido,
--     id_mesa,
--     fecha_pedido,
--     estado
-- ) VALUES (
--     11,
--     999,
--     '2026-08-10 12:00:00',
--     'ABIERTO'
-- );