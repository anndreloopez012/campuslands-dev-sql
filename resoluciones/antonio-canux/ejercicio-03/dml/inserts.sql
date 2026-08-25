INSERT INTO autores (nombre) 
    VALUES ('Robert Martin'),
    ('Martin Fowler'),
    ('Kathy Sierra'),
    ('Erich Gamma'),
    ('Andrew Hunt');

INSERT INTO campers (nombre, correo, ficha) 
    VALUES ('Diego Morales', 'diego.morales@campus.com', 'F-101'),
    ('Valeria Cruz', 'valeria.cruz@campus.com', 'F-101'),
    ('Hector Paz', 'hector.paz@campus.com', 'F-102'),
    ('Monica Reyes', 'monica.reyes@campus.com', 'F-102'),
    ('Bryan Lopez', 'bryan.lopez@campus.com', 'F-103');

INSERT INTO libros (id_autor, titulo, genero, anio_publicacion, stock) 
    VALUES (1, 'Clean Code', 'Programacion', 2008, 4),
    (2, 'Refactoring', 'Programacion', 1999, 3),
    (3, 'Head First Java', 'Programacion', 2005, 5),
    (4, 'Design Patterns', 'Programacion', 1994, 2),
    (5, 'The Pragmatic Programmer', 'Programacion', 1999, 3),
    (1, 'Clean Architecture', 'Programacion', 2017, 4);

INSERT INTO prestamos (id_camper, id_libro, fecha_prestamo, fecha_devolucion, estado) 
    VALUES (1, 1, '2026-07-01', '2026-07-10', 'devuelto'),
    (2, 2, '2026-07-02', '2026-07-12', 'devuelto'),
    (3, 3, '2026-07-05', NULL, 'prestado'),
    (4, 4, '2026-07-06', NULL, 'prestado'),
    (5, 5, '2026-07-07', '2026-07-20', 'devuelto'),
    (1, 6, '2026-07-08', NULL, 'prestado'),
    (2, 1, '2026-07-10', NULL, 'atrasado'),
    (3, 2, '2026-07-11', '2026-07-18', 'devuelto'),
    (4, 3, '2026-07-12', NULL, 'prestado'),
    (5, 6, '2026-07-13', NULL, 'atrasado');
