PRAGMA foreign_keys = ON;

-- Ejercicio 102: Procedimientos almacenados Nivel Intermedio
-- Datos de prueba: 3 autores, 3 libros, 3 prestamos.
--
-- Cada INSERT en "prestamos" pasa primero por
-- trg_validar_disponibilidad_prestamo (la alternativa ejecutable al
-- procedimiento almacenado). Los 3 prestamos de aqui abajo son
-- validos porque, en el momento de insertarse, el libro todavia tiene
-- copias disponibles.

INSERT INTO autores (nombre_autor) VALUES
    ('Robert C. Martin'),
    ('Kimberly Tripp'),
    ('Martin Fowler');

INSERT INTO libros (id_autor, titulo, stock_total) VALUES
    (1, 'Clean Architecture',          1),
    (2, 'SQL Server Query Tuning',     2),
    (3, 'Refactoring',                 1);
    -- 'Refactoring' se deja sin prestamos por ahora, para poder
    -- demostrar en dql/consultas.sql un prestamo valido sobre un
    -- libro con copias disponibles.

INSERT INTO prestamos (id_libro, nombre_prestatario, fecha_prestamo, estado) VALUES
    -- Clean Architecture (stock 1): 1 prestamo activo -> 0 disponibles (agotado)
    (1, 'Ana Lopez',      '2026-08-01', 'prestado'),
    -- SQL Server Query Tuning (stock 2): 2 prestamos activos -> 0 disponibles (agotado)
    (2, 'Byron Ramirez',  '2026-08-02', 'prestado'),
    (2, 'Carla Gomez',    '2026-08-03', 'prestado');

-- Caso comentado que no se debe hacer, dejar comentado: registrar un
-- libro con stock_total 0 o negativo. El CHECK (stock_total > 0) lo rechaza.
-- INSERT INTO libros (id_autor, titulo, stock_total) VALUES (1, 'Libro Fantasma', 0);
