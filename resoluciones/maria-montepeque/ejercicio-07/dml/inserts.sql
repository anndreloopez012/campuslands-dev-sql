-- Ejercicio 07: Academia de Cursos
-- Datos base: 5 instructores, 5 estudiantes, 6 cursos, 10 matriculas

INSERT INTO instructores (nombre, correo) VALUES
    ('Carlos Fuentes', 'carlos.fuentes@academia.com'),
    ('Laura Jimenez', 'laura.jimenez@academia.com'),
    ('Miguel Torres', 'miguel.torres@academia.com'),
    ('Paola Castillo', 'paola.castillo@academia.com'),
    ('Ricardo Vela', 'ricardo.vela@academia.com');

INSERT INTO estudiantes (nombre, correo) VALUES
    ('Fernanda Ortiz', 'fernanda.ortiz@correo.com'),
    ('Sebastian Ruiz', 'sebastian.ruiz@correo.com'),
    ('Camila Herrera', 'camila.herrera@correo.com'),
    ('Andres Molina', 'andres.molina@correo.com'),
    ('Daniela Soto', 'daniela.soto@correo.com');

INSERT INTO cursos (id_instructor, nombre, duracion_horas, modalidad) VALUES
    (1, 'Fundamentos de SQL', 40, 'virtual'),
    (2, 'JavaScript basico', 60, 'presencial'),
    (3, 'Python para datos', 80, 'hibrida'),
    (4, 'Bases de datos avanzadas', 50, 'virtual'),
    (5, 'Introduccion a Git', 20, 'virtual'),
    (1, 'Modelado relacional', 30, 'presencial');

INSERT INTO matriculas (id_estudiante, id_curso, fecha_matricula, nota_final, estado) VALUES
    (1, 1, '2026-06-01', 92, 'aprobada'),
    (2, 1, '2026-06-01', 55, 'reprobada'),
    (3, 2, '2026-06-02', 88, 'aprobada'),
    (4, 2, '2026-06-02', NULL, 'activa'),
    (5, 3, '2026-06-03', 75, 'aprobada'),
    (1, 3, '2026-06-03', NULL, 'activa'),
    (2, 4, '2026-06-04', 60, 'aprobada'),
    (3, 5, '2026-06-05', NULL, 'retirada'),
    (4, 6, '2026-06-06', 95, 'aprobada'),
    (5, 6, '2026-06-06', 40, 'reprobada');
