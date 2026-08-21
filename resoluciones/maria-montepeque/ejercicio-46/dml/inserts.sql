PRAGMA foreign_keys = ON;

-- Ejercicio 46: PRIMARY KEY Nivel Aplicado
-- Datos de prueba para validar el tema PRIMARY KEY.

INSERT INTO autores (nombre) VALUES
    ('Robert Martin'),
    ('Martin Fowler'),
    ('Kathy Sierra'),
    ('Erich Gamma'),
    ('Andrew Hunt');

INSERT INTO libros (isbn, titulo, id_autor) VALUES
    ('978-0132350884', 'Clean Code', 1),
    ('978-0134757599', 'Refactoring', 2),
    (NULL, 'Manual interno de Java (fotocopiado)', 3),   -- isbn NULL: no es la PRIMARY KEY, se permite
    ('978-0201633610', 'Design Patterns', 4),
    ('978-0201616224', 'The Pragmatic Programmer', 5);

-- El mismo libro (id_libro = 1, "Clean Code") se presta varias veces a lo
-- largo del tiempo, incluso al mismo prestatario dos veces: cada fila es un
-- evento distinto porque id_prestamo (la PRIMARY KEY) es distinto en cada
-- una, sin importar que id_libro y prestatario se repitan.
INSERT INTO prestamos (id_libro, prestatario, fecha_prestamo, fecha_devolucion) VALUES
    (1, 'Diego Morales', '2026-06-01', '2026-06-10'),
    (1, 'Valeria Cruz', '2026-06-12', '2026-06-20'),
    (1, 'Diego Morales', '2026-07-01', NULL),   -- Diego lo vuelve a pedir; prestamo activo (sin devolver)
    (2, 'Hector Paz', '2026-06-02', '2026-06-15'),
    (3, 'Monica Reyes', '2026-06-05', NULL),     -- prestamo activo
    (4, 'Bryan Lopez', '2026-06-08', '2026-06-18'),
    (5, 'Diego Morales', '2026-06-20', '2026-06-30'),
    (2, 'Valeria Cruz', '2026-07-02', NULL),     -- prestamo activo
    (5, 'Monica Reyes', '2026-07-05', '2026-07-15'),
    (4, 'Hector Paz', '2026-07-10', NULL);       -- prestamo activo

-- Caso valido: un nuevo prestamo del mismo libro que YA tiene un prestamo
-- activo sin devolver es una mala practica de negocio, pero NO rompe la
-- PRIMARY KEY (cada prestamo sigue siendo un evento distinto). Un ejercicio
-- de PRIMARY KEY no debe confundirse con reglas de negocio de disponibilidad.
INSERT INTO prestamos (id_libro, prestatario, fecha_prestamo, fecha_devolucion) VALUES
    (3, 'Bryan Lopez', '2026-07-20', NULL);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- reutilizar un id_autor que ya existe viola la PRIMARY KEY.
-- INSERT INTO autores (id_autor, nombre) VALUES (1, 'Otro Autor');

-- Otro caso comentado que debe fallar: eliminar un autor cuya PRIMARY KEY
-- todavia esta referenciada por libros (id_autor = 1 tiene el libro "Clean
-- Code"). La PRIMARY KEY no se puede borrar mientras siga siendo el punto
-- de apoyo de una FOREIGN KEY existente.
-- DELETE FROM autores WHERE id_autor = 1;
