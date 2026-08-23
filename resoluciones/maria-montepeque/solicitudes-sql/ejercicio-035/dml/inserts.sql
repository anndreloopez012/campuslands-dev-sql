PRAGMA foreign_keys = ON;

-- Ejercicio 035: Biblioteca Sci-Fi
-- Datos de prueba.

INSERT INTO libros (titulo, autor, genero, anio_publicacion) VALUES
    ('Dune', 'Frank Herbert', 'space_opera', 1965),
    ('Fundacion', 'Isaac Asimov', 'space_opera', 1951),
    ('Neuromante', 'William Gibson', 'cyberpunk', 1984),
    ('Snow Crash', 'Neal Stephenson', 'cyberpunk', 1992),
    ('1984', 'George Orwell', 'distopia', 1949),
    ('Un Mundo Feliz', 'Aldous Huxley', 'distopia', 1932),
    ('El Marciano', 'Andy Weir', 'hard_sci_fi', 2011),
    ('Hyperion', 'Dan Simmons', 'space_opera', 1989);

INSERT INTO lectores (nombre_lector, email) VALUES
    ('Karla Rivas', 'karla.rivas@correo.com'),
    ('Bryan Solis', 'bryan.solis@correo.com'),
    ('Fernanda Lopez', 'fernanda.lopez@correo.com'),
    ('Jorge Cifuentes', 'jorge.cifuentes@correo.com'),
    ('Melissa Ortiz', 'melissa.ortiz@correo.com');

-- El prestamo 10 es un duplicado por error de digitacion (mismo
-- libro, lector, fechas y estado que el prestamo 9): se corrige en
-- dml/operaciones.sql.
INSERT INTO prestamos (id_libro, id_lector, fecha_prestamo, fecha_devolucion_esperada, estado) VALUES
    (1, 1, '2026-08-01', '2026-08-15', 'devuelto'),
    (3, 2, '2026-08-03', '2026-08-17', 'prestado'),
    (5, 3, '2026-07-20', '2026-08-03', 'atrasado'),
    (7, 1, '2026-08-05', '2026-08-19', 'prestado'),
    (2, 4, '2026-08-10', '2026-08-24', 'prestado'),
    (6, 5, '2026-07-15', '2026-07-29', 'perdido'),
    (4, 2, '2026-08-08', '2026-08-22', 'prestado'),
    (8, 1, '2026-08-12', '2026-08-26', 'prestado'),
    (1, 3, '2026-08-14', '2026-08-28', 'prestado'),
    (1, 3, '2026-08-14', '2026-08-28', 'prestado');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- fecha_devolucion_esperada antes que fecha_prestamo, viola el CHECK
-- de prestamos.
-- INSERT INTO prestamos (id_libro, id_lector, fecha_prestamo, fecha_devolucion_esperada) VALUES (2, 5, '2026-08-20', '2026-08-10');
