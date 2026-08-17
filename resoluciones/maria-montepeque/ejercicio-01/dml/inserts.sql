-- Ejercicio 01: CineMax SQLite
-- Datos base: 5 peliculas, 5 salas, 6 funciones, 10 boletos

INSERT INTO peliculas (titulo, genero, duracion_min, clasificacion) VALUES
    ('El viaje del tiempo', 'Ciencia ficcion', 128, 'B'),
    ('Risas en la oficina', 'Comedia', 95, 'A'),
    ('Sombras del pasado', 'Terror', 102, 'C'),
    ('Carrera final', 'Accion', 115, 'B15'),
    ('Amor de verano', 'Romance', 108, 'A');

INSERT INTO salas (nombre, capacidad) VALUES
    ('Sala 1', 80),
    ('Sala 2', 60),
    ('Sala 3', 120),
    ('Sala VIP', 30),
    ('Sala 4D', 45);

INSERT INTO funciones (id_pelicula, id_sala, fecha_hora, precio_base) VALUES
    (1, 1, '2026-08-10 18:00', 35.00),
    (2, 2, '2026-08-10 20:00', 30.00),
    (3, 3, '2026-08-11 19:30', 32.50),
    (4, 4, '2026-08-11 21:00', 45.00),
    (5, 5, '2026-08-12 17:00', 40.00),
    (1, 3, '2026-08-12 20:30', 35.00);

INSERT INTO boletos (id_funcion, asiento, precio_pagado, estado, fecha_compra) VALUES
    (1, 'A1', 35.00, 'pagado', '2026-08-05'),
    (1, 'A2', 35.00, 'pagado', '2026-08-05'),
    (2, 'B1', 30.00, 'pagado', '2026-08-06'),
    (2, 'B2', 30.00, 'reservado', '2026-08-06'),
    (3, 'C1', 32.50, 'pagado', '2026-08-07'),
    (4, 'D1', 45.00, 'pagado', '2026-08-07'),
    (4, 'D2', 45.00, 'cancelado', '2026-08-07'),
    (5, 'E1', 40.00, 'pagado', '2026-08-08'),
    (6, 'F1', 35.00, 'reservado', '2026-08-08'),
    (6, 'F2', 35.00, 'pagado', '2026-08-09');
