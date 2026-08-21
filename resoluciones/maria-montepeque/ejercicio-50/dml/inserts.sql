PRAGMA foreign_keys = ON;

-- Ejercicio 50: UNIQUE Nivel Basico
-- Datos de prueba para validar el tema UNIQUE.

INSERT INTO autores (nombre) VALUES
    ('Robert Martin'),
    ('Martin Fowler'),
    ('Kathy Sierra'),
    ('Erich Gamma'),
    ('Andrew Hunt');

-- Caso valido que demuestra que UNIQUE permite varios NULL: dos libros
-- ("Manual interno de Java" y "Guia rapida de Git") no tienen isbn, y
-- ambos se insertan sin problema porque NULL nunca choca con otro NULL en
-- una columna UNIQUE (a diferencia de un valor real duplicado).
INSERT INTO libros (isbn, titulo, id_autor) VALUES
    ('978-0132350884', 'Clean Code', 1),
    ('978-0134757599', 'Refactoring', 2),
    (NULL, 'Manual interno de Java', 3),
    (NULL, 'Guia rapida de Git', 3),
    ('978-0201633610', 'Design Patterns', 4),
    ('978-0201616224', 'The Pragmatic Programmer', 5);

INSERT INTO prestamos (id_libro, prestatario, fecha_prestamo, fecha_devolucion) VALUES
    (1, 'Diego Morales', '2026-06-01', '2026-06-10'),
    (1, 'Valeria Cruz', '2026-06-12', '2026-06-20'),
    (2, 'Hector Paz', '2026-06-02', NULL),
    (3, 'Monica Reyes', '2026-06-05', '2026-06-15'),
    (4, 'Bryan Lopez', '2026-06-08', NULL),
    (5, 'Diego Morales', '2026-06-20', '2026-06-30'),
    (6, 'Valeria Cruz', '2026-07-02', NULL);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- '978-0132350884' ya existe en libros (fila de "Clean Code"); repetirlo
-- viola la restriccion UNIQUE sobre isbn.
-- INSERT INTO libros (isbn, titulo, id_autor) VALUES ('978-0132350884', 'Otro titulo', 2);

-- Otro caso comentado que debe fallar: repetir el nombre de un autor que ya
-- existe.
-- INSERT INTO autores (nombre) VALUES ('Robert Martin');
