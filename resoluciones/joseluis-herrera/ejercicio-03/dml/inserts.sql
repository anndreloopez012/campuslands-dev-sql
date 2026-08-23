INSERT INTO autores (
    id_autor,
    nombre_completo,
    nacionalidad,
    fecha_nacimiento
) VALUES
    (1, 'Robert C. Martin', 'Estadounidense', '1952-12-05'),
    (2, 'Martin Fowler', 'Britanico', '1963-12-18'),
    (3, 'Andrew Hunt', 'Estadounidense', '1964-08-21'),
    (4, 'Eric Matthes', 'Estadounidense', '1962-01-01'),
    (5, 'James Clear', 'Estadounidense', '1986-01-01');

INSERT INTO libros (
    id_libro,
    id_autor,
    titulo,
    isbn,
    anio_publicacion,
    ejemplares_disponibles
) VALUES
    (1, 1, 'Clean Code', '9780132350884', 2008, 3),
    (2, 2, 'Refactoring', '9780134757599', 2018, 2),
    (3, 3, 'The Pragmatic Programmer', '9780135957059', 2019, 4),
    (4, 4, 'Python Crash Course', '9781718502703', 2023, 5),
    (5, 5, 'Atomic Habits', '9780735211292', 2018, 6);

INSERT INTO campers (
    id_camper,
    nombre_completo,
    email,
    fecha_ingreso,
    estado
) VALUES
    (1, 'Ana Martinez', 'ana.martinez@campuslands.com', '2026-01-15', 'ACTIVO'),
    (2, 'Carlos Gomez', 'carlos.gomez@campuslands.com', '2026-01-20', 'ACTIVO'),
    (3, 'Laura Rodriguez', 'laura.rodriguez@campuslands.com', '2026-02-01', 'ACTIVO'),
    (4, 'Miguel Torres', 'miguel.torres@campuslands.com', '2026-02-10', 'ACTIVO'),
    (5, 'Sofia Herrera', 'sofia.herrera@campuslands.com', '2026-02-15', 'ACTIVO');

INSERT INTO prestamos (
    id_prestamo,
    id_libro,
    id_camper,
    fecha_prestamo,
    fecha_devolucion,
    estado
) VALUES
    (1, 1, 1, '2026-03-01', '2026-03-08', 'DEVUELTO'),
    (2, 2, 2, '2026-03-03', '2026-03-12', 'DEVUELTO'),
    (3, 3, 3, '2026-03-05', '2026-03-15', 'DEVUELTO'),
    (4, 4, 4, '2026-03-10', '2026-03-20', 'DEVUELTO'),
    (5, 5, 5, '2026-03-12', '2026-03-22', 'DEVUELTO'),
    (6, 1, 2, '2026-04-01', '2026-04-10', 'DEVUELTO'),
    (7, 2, 3, '2026-04-05', '2026-04-18', 'DEVUELTO'),
    (8, 3, 4, '2026-05-01', '2026-05-12', 'DEVUELTO'),
    (9, 1, 5, '2026-06-01', NULL, 'PRESTADO'),
    (10, 4, 1, '2026-06-10', NULL, 'PRESTADO');