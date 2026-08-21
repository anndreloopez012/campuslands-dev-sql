PRAGMA foreign_keys = ON;

-- Ejercicio 043: Escuela de Dibujo
-- Datos de prueba.

INSERT INTO profesores (nombre_profesor, especialidad) VALUES
    ('Andrea Solval', 'dibujo_realista'),
    ('Kevin Morataya', 'manga'),
    ('Lucia Barrera', 'pintura_digital'),
    ('Oscar Xoc', 'ilustracion_infantil');

INSERT INTO cursos (nombre_curso, id_profesor, cupo_maximo) VALUES
    ('Retrato a Lapiz', 1, 15),
    ('Manga Basico', 2, 20),
    ('Pintura Digital Avanzada', 3, 12),
    ('Ilustracion para Ninos', 4, 18),
    ('Manga Intermedio', 2, 15);

INSERT INTO alumnos (nombre_alumno, email) VALUES
    ('Fernanda Ixcoy', 'fernanda.ixcoy@correo.com'),
    ('Brandon Us', 'brandon.us@correo.com'),
    ('Wendy Choc', 'wendy.choc@correo.com'),
    ('Alan Ramirez', 'alan.ramirez@correo.com'),
    ('Michelle Poou', 'michelle.poou@correo.com'),
    ('Diego Sacbaja', 'diego.sacbaja@correo.com');

-- La entrega 11 es un duplicado por error de digitacion (mismo
-- alumno, curso, fecha, calificacion y estado que la entrega 1): se
-- corrige en dml/operaciones.sql. La entrega 10 es una inscripcion
-- equivocada de Wendy Choc (quedo registrada tambien en Retrato a
-- Lapiz por un formulario duplicado, curso que nunca curso): se
-- borra de forma controlada.
INSERT INTO entregas (id_alumno, id_curso, fecha_entrega, calificacion, estado) VALUES
    (1, 1, '2026-08-01', 85.0, 'evaluada'),
    (2, 2, '2026-08-02', 92.0, 'evaluada'),
    (3, 3, '2026-08-03', NULL, 'entregada'),
    (1, 2, '2026-08-04', 78.0, 'evaluada'),
    (4, 4, '2026-08-05', 88.0, 'evaluada'),
    (2, 5, '2026-08-06', NULL, 'entregada'),
    (5, 1, '2026-08-07', 95.0, 'evaluada'),
    (1, 4, '2026-08-08', NULL, 'rechazada'),
    (6, 3, '2026-08-09', NULL, 'pendiente'),
    (3, 1, '2026-08-10', NULL, 'pendiente'),
    (1, 1, '2026-08-01', 85.0, 'evaluada');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_curso ya existe, viola el UNIQUE.
-- INSERT INTO cursos (nombre_curso, id_profesor, cupo_maximo) VALUES ('Manga Basico', 3, 10);

-- 2) Valor fuera de rango: calificacion = 150 no es una nota valida, viola el CHECK.
-- INSERT INTO entregas (id_alumno, id_curso, fecha_entrega, calificacion, estado) VALUES (4, 1, '2026-08-11', 150, 'evaluada');
