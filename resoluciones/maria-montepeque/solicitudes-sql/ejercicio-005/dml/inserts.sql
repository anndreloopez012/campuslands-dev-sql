PRAGMA foreign_keys = ON;

-- Ejercicio 005: Cine Horror Nights
-- Datos de prueba.

INSERT INTO peliculas (titulo, genero, sala_asignada, precio_boleto) VALUES
    ('El Grito Final', 'terror', 'Sala 1', 45.00),
    ('Medianoche Sangrienta', 'terror', 'Sala 2', 45.00),
    ('La Casa del Silencio', 'suspenso', 'Sala 1', 40.00),
    ('Posesion 13', 'terror', 'Sala 3', 50.00),
    ('El Legado Maldito', 'clasico', 'Sala 2', 35.00);

-- El boleto 9 es una entrada de prueba (asiento Z9, cliente "Cuenta de
-- Prueba") que se cargo por error y nunca correspondio a una venta real:
-- se elimina en dml/operaciones.sql.
INSERT INTO boletos (id_pelicula, nombre_cliente, asiento, precio_pagado, fecha_compra, estado) VALUES
    (1, 'Ana Gomez', 'A1', 45.00, '2026-08-15 19:00', 'vendido'),
    (1, 'Luis Marroquin', 'A2', 45.00, '2026-08-15 19:00', 'vendido'),
    (2, 'Karen Solis', 'B1', 45.00, '2026-08-15 21:00', 'vendido'),
    (3, 'Diego Paz', 'C1', 40.00, '2026-08-16 18:00', 'vendido'),
    (4, 'Rosa Chavez', 'D1', 50.00, '2026-08-16 20:00', 'vendido'),
    (1, 'Ana Gomez', 'A3', 45.00, '2026-08-15 19:00', 'reembolsado'),
    (2, 'Luis Marroquin', 'B2', 45.00, '2026-08-15 21:00', 'vendido'),
    (5, 'Karen Solis', 'E1', 35.00, '2026-08-17 17:00', 'vendido'),
    (1, 'Cuenta de Prueba', 'Z9', 45.00, '2026-08-15 19:00', 'vendido');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- el asiento A1 de la pelicula 1 ya esta vendido (boleto 1); intentar
-- venderlo otra vez viola el UNIQUE(id_pelicula, asiento).
-- INSERT INTO boletos (id_pelicula, nombre_cliente, asiento, precio_pagado) VALUES (1, 'Mario Paz', 'A1', 45.00);
