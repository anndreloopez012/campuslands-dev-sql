PRAGMA foreign_keys = ON;

-- Ejercicio 030: Cine Horror Nights
-- Datos de prueba.

INSERT INTO peliculas (titulo, duracion_min) VALUES
    ('El Grito Final', 105),
    ('Medianoche Sangrienta', 98),
    ('La Casa del Silencio', 110),
    ('Posesion 13', 95),
    ('El Legado Maldito', 120);

INSERT INTO salas (nombre_sala, capacidad) VALUES
    ('Sala 1', 80),
    ('Sala 2', 60),
    ('Sala 3', 100),
    ('Sala VIP', 40);

-- La funcion 9 es una entrada de prueba que se cargo por error: se
-- elimina en dml/operaciones.sql.
INSERT INTO funciones (id_pelicula, id_sala, fecha_hora, precio_boleto, estado) VALUES
    (1, 1, '2026-08-15 19:00', 45.00, 'finalizada'),
    (2, 2, '2026-08-15 21:00', 45.00, 'finalizada'),
    (3, 1, '2026-08-16 18:00', 40.00, 'programada'),
    (1, 3, '2026-08-16 20:00', 50.00, 'programada'),
    (4, 2, '2026-08-17 19:00', 42.00, 'en_curso'),
    (5, 4, '2026-08-17 21:00', 60.00, 'programada'),
    (2, 1, '2026-08-18 18:30', 45.00, 'programada'),
    (3, 3, '2026-08-18 20:30', 40.00, 'cancelada'),
    (1, 4, '2026-08-15 19:00', 45.00, 'programada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- la Sala 1 ya tiene una funcion programada el 2026-08-15 19:00 (funcion
-- 1); intentar programar otra funcion en la misma sala y hora viola el
-- UNIQUE(id_sala, fecha_hora) -- esto es exactamente el "registro
-- repetido" que el cliente quiere detectar.
-- INSERT INTO funciones (id_pelicula, id_sala, fecha_hora, precio_boleto) VALUES (2, 1, '2026-08-15 19:00', 45.00);

-- Otro caso comentado que debe fallar: duracion_min fuera de rango,
-- viola el CHECK de peliculas (el "valor fuera de rango" del cliente).
-- INSERT INTO peliculas (titulo, duracion_min) VALUES ('Pelicula Imposible', 10);
