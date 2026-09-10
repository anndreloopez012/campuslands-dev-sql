PRAGMA foreign_keys = ON;

-- Ejercicio 100: Vistas Nivel Aplicado
-- Datos de prueba: 3 autores, 4 libros, 5 prestamos.

INSERT INTO autores (nombre_autor) VALUES
    ('Robert C. Martin'),
    ('Erich Gamma'),
    ('Martin Fowler');

INSERT INTO libros (id_autor, titulo, stock_total) VALUES
    (1, 'Clean Code',                  2),
    (2, 'Design Patterns',             1),
    (1, 'The Pragmatic Programmer',    3),
    (3, 'Refactoring',                 1);
    -- 'Refactoring' se deja sin prestamos a proposito, para probar el LEFT JOIN de la vista.

INSERT INTO prestamos (id_libro, nombre_prestatario, fecha_prestamo, estado) VALUES
    -- Clean Code (stock 2): 2 prestamos activos -> agotado (0 disponibles)
    (1, 'Ana Lopez',      '2026-08-01', 'prestado'),
    (1, 'Byron Ramirez',  '2026-08-02', 'prestado'),
    -- Design Patterns (stock 1): 1 prestamo activo -> agotado (0 disponibles)
    (2, 'Carla Gomez',    '2026-08-03', 'prestado'),
    -- The Pragmatic Programmer (stock 3): 1 activo + 1 devuelto -> 2 disponibles
    (3, 'Diego Torres',   '2026-08-04', 'prestado'),
    (3, 'Elena Ruiz',     '2026-08-05', 'devuelto');

-- Caso comentado que no se debe hacer, dejar comentado: registrar un
-- libro con stock_total 0 o negativo. El CHECK (stock_total > 0) lo rechaza.
-- INSERT INTO libros (id_autor, titulo, stock_total) VALUES (1, 'Libro Fantasma', 0);
