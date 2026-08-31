PRAGMA foreign_keys = ON;

-- Ejercicio 86: ORDER BY Nivel Basico
-- Datos de prueba.

INSERT INTO autores (nombre_autor, especialidad) VALUES
    ('Robert C. Martin', 'Ingenieria de Software'),
    ('Donald Knuth', 'Algoritmos'),
    ('Martin Fowler', 'Arquitectura de Software');

INSERT INTO libros (titulo, id_autor, categoria, ejemplares_totales) VALUES
    ('Clean Code', 1, 'Ingenieria', 2),
    ('Clean Architecture', 1, 'Arquitectura', 1),
    ('The Art of Computer Programming Vol. 1', 2, 'Algoritmos', 1),
    ('Refactoring', 3, 'Arquitectura', 3),
    ('Patterns of Enterprise Application Architecture', 3, 'Arquitectura', 2);

INSERT INTO prestamos (id_libro, nombre_prestatario, fecha_prestamo, fecha_devolucion) VALUES
    (1, 'Karla Rivas', '2026-08-01', '2026-08-10'),
    (4, 'Karla Rivas', '2026-08-04', '2026-08-12');

INSERT INTO prestamos (id_libro, nombre_prestatario, fecha_prestamo) VALUES
    (1, 'Bryan Solis', '2026-08-05'),
    (2, 'Fernanda Lopez', '2026-08-02'),
    (3, 'Jorge Cifuentes', '2026-08-03'),
    (4, 'Priscila Ajanel', '2026-08-06'),
    (5, 'Bryan Solis', '2026-08-07');
