PRAGMA foreign_keys = ON;

INSERT INTO autores (
    id_autor,
    nombre_completo,
    nacionalidad,
    fecha_nacimiento
) VALUES
    (1, 'Robert C. Martin', 'Estadounidense', '1952-12-05'),
    (2, 'Martin Fowler', 'Britanica', '1963-12-18'),
    (3, 'Eric Matthes', 'Estadounidense', '1962-01-01'),
    (4, 'Andrew Hunt', 'Estadounidense', '1964-01-01'),
    (5, 'David Thomas', 'Estadounidense', '1956-01-01');

INSERT INTO libros (
    id_libro,
    titulo,
    isbn,
    anio_publicacion,
    paginas,
    id_autor
) VALUES
    (1, 'Clean Code', '9780132350884', 2008, 464, 1),
    (2, 'Refactoring', '9780134757599', 2018, 448, 2),
    (3, 'Python Crash Course', '9781593279288', 2019, 544, 3),
    (4, 'The Pragmatic Programmer', '9780135957059', 2019, 352, 4),
    (5, 'Programming Ruby', '9780974514055', 2004, 864, 5);

INSERT INTO campers (
    id_camper,
    nombre_completo,
    email,
    fecha_ingreso,
    nivel
) VALUES
    (1, 'Carlos Velasco', 'carlos.velasco@example.com', '2026-01-15', 'SENIOR'),
    (2, 'Ana Martinez', 'ana.martinez@example.com', '2026-01-20', 'MID'),
    (3, 'Luis Gomez', 'luis.gomez@example.com', '2026-02-03', 'JUNIOR'),
    (4, 'Maria Lopez', 'maria.lopez@example.com', '2026-02-10', 'MID'),
    (5, 'Daniel Perez', 'daniel.perez@example.com', '2026-03-01', 'SENIOR');

INSERT INTO prestamos (
    id_prestamo,
    id_libro,
    id_camper,
    fecha_prestamo,
    fecha_devolucion,
    estado
) VALUES
    (1, 1, 1, '2026-06-01', '2026-06-08', 'DEVUELTO'),
    (2, 2, 2, '2026-06-03', '2026-06-12', 'DEVUELTO'),
    (3, 3, 3, '2026-06-05', '2026-06-15', 'DEVUELTO'),
    (4, 4, 4, '2026-06-07', '2026-06-14', 'DEVUELTO'),
    (5, 5, 5, '2026-06-10', '2026-06-20', 'DEVUELTO'),
    (6, 1, 2, '2026-07-01', '2026-07-08', 'DEVUELTO'),
    (7, 2, 3, '2026-07-05', NULL, 'PRESTADO'),
    (8, 1, 4, '2026-07-10', NULL, 'PRESTADO'),
    (9, 3, 5, '2026-07-15', '2026-07-25', 'DEVUELTO'),
    (10, 4, 1, '2026-08-01', NULL, 'PRESTADO');