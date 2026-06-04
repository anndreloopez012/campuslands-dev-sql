PRAGMA foreign_keys = ON;

-- Inserte aqui los datos de prueba.
-- Requisitos minimos:
-- 5 peliculas, 5 salas, 8 funciones y 10 boletos.

-- Casos de error sugeridos:
-- Mantenga comentadas las inserciones que deben fallar para que el script principal ejecute correctamente.


-- CineMax - Datos de prueba (DML)

PRAGMA foreign_keys = ON;

-- PELICULAS (5)
INSERT INTO
    peliculas (
        nombre,
        duracion,
        genero,
        clasificacion
    )
VALUES (
        'Dunas del Tiempo',
        155,
        'Ciencia ficcion',
        '+12'
    ),
    (
        'Risas en Familia',
        98,
        'Comedia',
        'TP'
    ),
    (
        'La Ultima Frontera',
        142,
        'Aventura',
        '+12'
    ),
    (
        'Sombras del Pasado',
        118,
        'Suspenso',
        '+15'
    ),
    (
        'El Codigo Oculto',
        201,
        'Drama',
        '+18'
    );

-- SALAS (5)
INSERT INTO
    salas (nombre, capacidad, tipo)
VALUES ('Sala 1', 120, '2D'),
    ('Sala 2', 80, '3D'),
    ('Sala 3', 200, 'IMAX'),
    ('Sala 4', 60, '4DX'),
    ('Sala 5', 150, '2D');

-- FUNCIONES (8)
INSERT INTO
    funciones (
        id_pelicula,
        id_sala,
        fecha,
        hora,
        precio
    )
VALUES (
        1,
        3,
        '2026-06-10',
        '18:00',
        65.00
    ),
    (
        1,
        1,
        '2026-06-10',
        '21:00',
        50.00
    ),
    (
        2,
        2,
        '2026-06-11',
        '16:30',
        45.00
    ),
    (
        3,
        4,
        '2026-06-11',
        '19:00',
        70.00
    ),
    (
        4,
        5,
        '2026-06-12',
        '20:15',
        48.00
    ),
    (
        5,
        3,
        '2026-06-12',
        '22:00',
        65.00
    ),
    (
        2,
        1,
        '2026-06-13',
        '15:00',
        45.00
    ),
    (
        3,
        2,
        '2026-06-13',
        '17:45',
        52.00
    );

-- BOLETOS (10)
INSERT INTO
    boletos (
        id_funcion,
        asiento,
        fecha_compra,
        precio_pagado
    )
VALUES (1, 'A1', '2026-06-09', 65.00),
    (1, 'A2', '2026-06-09', 65.00),
    (1, 'B5', '2026-06-10', 65.00),
    (2, 'C3', '2026-06-10', 50.00),
    (3, 'A1', '2026-06-11', 45.00),
    (4, 'D7', '2026-06-11', 70.00),
    (4, 'D8', '2026-06-11', 70.00),
    (5, 'F2', '2026-06-12', 48.00),
    (6, 'G9', '2026-06-12', 65.00),
    (6, 'G10', '2026-06-12', 65.00);
