PRAGMA foreign_keys = ON;

-- Ejercicio 010: Biblioteca Sci-Fi
-- Datos de prueba.

INSERT INTO libros (titulo, autor, anio_publicacion, copias_disponibles) VALUES
    ('Dune', 'Frank Herbert', 1965, 3),
    ('Fundacion', 'Isaac Asimov', 1951, 2),
    ('Neuromante', 'William Gibson', 1984, 2),
    ('El Marciano', 'Andy Weir', 2011, 4),
    ('Un Mundo Feliz', 'Aldous Huxley', 1932, 1),
    ('Snow Crash', 'Neal Stephenson', 1992, 2);

-- fecha_devolucion se deja NULL en los prestamos que todavia no regresan:
-- es opcional, no lleva NOT NULL. El prestamo 9 es una entrada de prueba
-- (cliente "Cuenta de Prueba") que se cargo por error: se elimina en
-- dml/operaciones.sql.
INSERT INTO prestamos (id_libro, nombre_lector, fecha_prestamo, fecha_devolucion, estado) VALUES
    (1, 'Ana Gomez', '2026-07-01', NULL, 'prestado'),
    (2, 'Luis Marroquin', '2026-07-02', '2026-07-16', 'devuelto'),
    (3, 'Karen Solis', '2026-07-05', NULL, 'atrasado'),
    (1, 'Diego Paz', '2026-07-10', NULL, 'prestado'),
    (4, 'Rosa Chavez', '2026-07-12', '2026-07-20', 'devuelto'),
    (5, 'Julio Perez', '2026-07-15', NULL, 'perdido'),
    (6, 'Ana Gomez', '2026-07-18', NULL, 'prestado'),
    (2, 'Karen Solis', '2026-07-20', NULL, 'prestado'),
    (3, 'Ana Gomez', '2026-07-22', NULL, 'prestado'),
    (1, 'Cuenta de Prueba', '2026-07-01', NULL, 'prestado');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- anio_publicacion fuera de rango, viola el CHECK de libros (esto es
-- exactamente el "valor fuera de rango" que el cliente quiere detectar).
-- INSERT INTO libros (titulo, autor, anio_publicacion) VALUES ('Futuro Imposible', 'Autor X', 3050);
