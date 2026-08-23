PRAGMA foreign_keys = ON;

-- Ejercicio 44: PRIMARY KEY Nivel Basico
-- Datos de prueba para validar el tema PRIMARY KEY.

INSERT INTO rutas (nombre) VALUES
    ('Desarrollo Web'),
    ('Ciencia de Datos'),
    ('Infraestructura Cloud'),
    ('Diseno UX/UI'),
    ('Ciberseguridad');

INSERT INTO campers (nombre, documento) VALUES
    ('Manuel Estrada', 'DPI-9001'),
    ('Alejandra Chinchilla', 'DPI-9002'),
    ('Byron Xicay', 'DPI-9003'),
    ('Cristina Barrios', 'DPI-9004'),
    ('Douglas Pineda', 'DPI-9005');

-- Cada fila es unica por la PRIMARY KEY compuesta (id_camper, id_ruta):
-- un mismo camper si puede aparecer varias veces, pero nunca dos veces con
-- la misma ruta (Manuel Estrada aparece en dos rutas distintas, 1 y 2).
INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion) VALUES
    (1, 1, '2026-01-15'),
    (1, 2, '2026-02-01'),
    (2, 2, '2026-01-15'),
    (3, 1, '2026-02-01'),
    (4, 3, '2026-02-01'),
    (5, 5, '2026-03-01'),
    (2, 4, '2026-03-10'),
    (3, 3, '2026-03-15');

-- Caso valido: Byron Xicay ya estaba en la ruta 1 (fila anterior) y ahora se
-- inscribe TAMBIEN en la ruta 3; la PRIMARY KEY (3, 3) es distinta de (3, 1),
-- asi que es un registro nuevo valido, no un duplicado.
-- (Ya incluido arriba como (3, 3, '2026-03-15').)

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- Byron Xicay (id_camper = 3) ya esta inscrito en la ruta 1 (ver arriba).
-- Repetir esa misma combinacion viola la PRIMARY KEY compuesta (3, 1), que
-- es exactamente para lo que sirve: evitar la doble inscripcion del mismo
-- camper en la misma ruta.
-- INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion) VALUES (3, 1, '2026-04-01');

-- Otro caso comentado que debe fallar: insertar un id_camper que ya existe
-- (PRIMARY KEY simple duplicada en campers).
-- INSERT INTO campers (id_camper, nombre, documento) VALUES (1, 'Otro Camper', 'DPI-9099');
