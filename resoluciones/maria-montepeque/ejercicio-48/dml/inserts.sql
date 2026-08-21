PRAGMA foreign_keys = ON;

-- Ejercicio 48: FOREIGN KEY Nivel Intermedio
-- Datos de prueba para validar el tema FOREIGN KEY.

INSERT INTO autores (nombre) VALUES
    ('Robert Martin'),
    ('Martin Fowler'),
    ('Kathy Sierra'),
    ('Erich Gamma'),
    ('Andrew Hunt');

INSERT INTO libros (titulo, id_autor) VALUES
    ('Clean Code', 1),
    ('Clean Architecture', 1),
    ('Refactoring', 2),
    ('Head First Java', 3),
    ('Design Patterns', 4),
    ('The Pragmatic Programmer', 5);

INSERT INTO prestamos (id_libro, prestatario, fecha_prestamo, fecha_devolucion) VALUES
    (1, 'Diego Morales', '2026-06-01', '2026-06-10'),
    (1, 'Valeria Cruz', '2026-06-12', '2026-06-20'),
    (2, 'Hector Paz', '2026-06-02', NULL),
    (3, 'Monica Reyes', '2026-06-05', '2026-06-15'),
    (4, 'Bryan Lopez', '2026-06-08', NULL),
    (5, 'Diego Morales', '2026-06-20', '2026-06-30'),
    (6, 'Valeria Cruz', '2026-07-02', NULL),
    (5, 'Monica Reyes', '2026-07-05', '2026-07-15'),
    (6, 'Hector Paz', '2026-07-10', NULL),
    (3, 'Bryan Lopez', '2026-07-12', NULL);

-- Caso valido que demuestra ON DELETE CASCADE: "Design Patterns" (id_libro
-- = 5) se da de baja del catalogo. Sus 2 prestamos (a Diego Morales y a
-- Monica Reyes) se eliminan automaticamente junto con el libro, sin
-- necesidad de borrarlos a mano primero. Verificado antes y despues en
-- dql/consultas.sql (punto 5.b).
DELETE FROM libros WHERE id_libro = 5;

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- Robert Martin (id_autor = 1) todavia tiene libros en el catalogo ("Clean
-- Code" y "Clean Architecture"). ON DELETE RESTRICT en libros.id_autor lo
-- impide (a diferencia del CASCADE de arriba, aqui SI se protege el dato).
-- DELETE FROM autores WHERE id_autor = 1;

-- Otro caso comentado que debe fallar: registrar un prestamo de un libro
-- que no existe en el catalogo.
-- INSERT INTO prestamos (id_libro, prestatario, fecha_prestamo) VALUES (999, 'Prueba', '2026-07-20');
