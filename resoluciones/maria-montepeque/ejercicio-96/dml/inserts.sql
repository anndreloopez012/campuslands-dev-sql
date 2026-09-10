PRAGMA foreign_keys = ON;

-- Ejercicio 96: JOIN Nivel Intermedio
-- Datos de prueba: 6 campers (uno sin inscripciones), 3 rutas, 5 inscripciones.

INSERT INTO campers (nombre_camper, email) VALUES
    ('Ana Lopez',        'ana.lopez@campuslands.test'),
    ('Byron Ramirez',    'byron.ramirez@campuslands.test'),
    ('Carla Gomez',      'carla.gomez@campuslands.test'),
    ('Diego Torres',     'diego.torres@campuslands.test'),
    ('Elena Ruiz',       'elena.ruiz@campuslands.test'),
    ('Fernando Diaz',    'fernando.diaz@campuslands.test');
    -- 'Elena Ruiz' se deja sin inscripciones a proposito, para demostrar el LEFT JOIN.

INSERT INTO rutas (nombre_ruta) VALUES
    ('Ruta Backend'),
    ('Ruta Frontend'),
    ('Ruta DevOps');

INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion, estado) VALUES
    (1, 1, '2026-08-01', 'activo'),
    (2, 2, '2026-08-02', 'activo'),
    (3, 1, '2026-08-03', 'retirado'),
    (4, 3, '2026-08-04', 'activo'),
    (6, 2, '2026-08-05', 'retirado');

-- Caso comentado que no se debe hacer, dejar comentado: inscribir a
-- un camper con un estado fuera del catalogo permitido. El
-- CHECK (estado IN (...)) lo rechaza.
-- INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion, estado) VALUES (1, 1, '2026-08-06', 'suspendido');
