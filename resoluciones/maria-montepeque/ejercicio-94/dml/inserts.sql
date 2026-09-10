PRAGMA foreign_keys = ON;

-- Ejercicio 94: HAVING Nivel Aplicado
-- Datos de prueba: 7 campers, 3 rutas, 11 inscripciones.

INSERT INTO campers (nombre_camper, email) VALUES
    ('Ana Lopez',        'ana.lopez@campuslands.test'),
    ('Byron Ramirez',    'byron.ramirez@campuslands.test'),
    ('Carla Gomez',      'carla.gomez@campuslands.test'),
    ('Diego Torres',     'diego.torres@campuslands.test'),
    ('Elena Ruiz',       'elena.ruiz@campuslands.test'),
    ('Fernando Diaz',    'fernando.diaz@campuslands.test'),
    ('Gabriela Soto',    'gabriela.soto@campuslands.test');

INSERT INTO rutas (nombre_ruta, cupo_maximo) VALUES
    ('Ruta Backend Nivel 1',  3),
    ('Ruta Frontend Nivel 1', 3),
    ('Ruta DevOps Nivel 2',   2);

INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion, estado) VALUES
    -- Ruta Backend Nivel 1 (cupo 3): 4 inscripciones activas -> sobrecupo real
    (1, 1, '2026-08-01', 'activo'),
    (2, 1, '2026-08-01', 'activo'),
    (3, 1, '2026-08-02', 'activo'),
    (4, 1, '2026-08-02', 'activo'),
    -- Ruta Frontend Nivel 1 (cupo 3): 4 inscripciones totales, pero solo 2 activas -> sin sobrecupo real
    (5, 2, '2026-08-03', 'activo'),
    (6, 2, '2026-08-03', 'activo'),
    (3, 2, '2026-08-04', 'retirado'),
    (4, 2, '2026-08-04', 'completado'),
    -- Ruta DevOps Nivel 2 (cupo 2): 3 inscripciones activas -> sobrecupo real
    (1, 3, '2026-08-05', 'activo'),
    (7, 3, '2026-08-05', 'activo'),
    (2, 3, '2026-08-06', 'activo');

-- Caso comentado que no se debe hacer, dejar comentado: inscribir a
-- un camper con un estado fuera del catalogo permitido. El
-- CHECK (estado IN (...)) lo rechaza.
-- INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion, estado) VALUES (1, 1, '2026-08-07', 'suspendido');
