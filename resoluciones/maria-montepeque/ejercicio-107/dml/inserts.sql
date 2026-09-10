PRAGMA foreign_keys = ON;

-- Ejercicio 107: Indices Nivel Basico
-- Datos de prueba: 8 citas repartidas en 3 fechas.
-- "Ana Lopez" aparece 2 veces a proposito (un mismo paciente puede
-- tener varias citas), para poder demostrar mas adelante por que un
-- indice UNICO sobre nombre_paciente no seria valido.

INSERT INTO citas (nombre_paciente, nombre_medico, fecha_cita, hora_cita, estado) VALUES
    ('Ana Lopez',       'Dra. Sofia Martinez', '2026-09-01', '09:00', 'programada'),
    ('Byron Ramirez',   'Dra. Sofia Martinez', '2026-09-01', '10:00', 'programada'),
    ('Carla Gomez',     'Dr. Pedro Ramirez',   '2026-09-01', '09:00', 'programada'),
    ('Diego Torres',    'Dr. Pedro Ramirez',   '2026-09-02', '09:00', 'programada'),
    ('Ana Lopez',       'Dr. Pedro Ramirez',   '2026-09-02', '10:00', 'programada'),
    ('Elena Ruiz',      'Dra. Sofia Martinez', '2026-09-03', '09:00', 'programada'),
    ('Fernando Diaz',   'Dra. Sofia Martinez', '2026-09-03', '10:00', 'programada'),
    ('Gabriela Soto',   'Dr. Pedro Ramirez',   '2026-09-03', '11:00', 'cancelada');

-- Caso comentado que no se debe hacer, dejar comentado: registrar una
-- cita con un estado fuera del catalogo permitido. El
-- CHECK (estado IN (...)) lo rechaza.
-- INSERT INTO citas (nombre_paciente, nombre_medico, fecha_cita, hora_cita, estado) VALUES ('Cliente Fantasma', 'Dra. Sofia Martinez', '2026-09-04', '09:00', 'pendiente');
