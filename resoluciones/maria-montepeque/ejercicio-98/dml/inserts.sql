PRAGMA foreign_keys = ON;

-- Ejercicio 98: Vistas Nivel Basico
-- Datos de prueba: 5 campers, 7 inscripciones.

INSERT INTO campers (nombre_camper, email) VALUES
    ('Ana Lopez',        'ana.lopez@campuslands.test'),
    ('Byron Ramirez',    'byron.ramirez@campuslands.test'),
    ('Carla Gomez',      'carla.gomez@campuslands.test'),
    ('Diego Torres',     'diego.torres@campuslands.test'),
    ('Elena Ruiz',       'elena.ruiz@campuslands.test');

INSERT INTO inscripciones (id_camper, nombre_ruta, fecha_inscripcion, estado) VALUES
    (1, 'Ruta Backend',  '2026-08-01', 'activo'),
    (2, 'Ruta Frontend', '2026-08-02', 'activo'),
    (3, 'Ruta Backend',  '2026-08-03', 'retirado'),
    (4, 'Ruta DevOps',   '2026-08-04', 'activo'),
    (5, 'Ruta Frontend', '2026-08-05', 'completado'),
    (1, 'Ruta DevOps',   '2026-08-06', 'activo'),
    (2, 'Ruta Backend',  '2026-08-07', 'retirado');

-- Caso comentado que no se debe hacer, dejar comentado: inscribir a
-- un camper con un estado fuera del catalogo permitido. El
-- CHECK (estado IN (...)) lo rechaza.
-- INSERT INTO inscripciones (id_camper, nombre_ruta, fecha_inscripcion, estado) VALUES (1, 'Ruta Backend', '2026-08-08', 'suspendido');
