PRAGMA foreign_keys = ON;

-- Ejercicio 035: Biblioteca Sci-Fi
INSERT INTO libros (titulo, autor) VALUES
	('Dune', 'Frank Herbert'),
	('Fundacion', 'Isaac Asimov'),
	('Neuromante', 'William Gibson');

INSERT INTO usuarios (nombre, carnet) VALUES
	('Esteban Quito', 'US-100'),
	('Elena Nito', 'US-200');

INSERT INTO prestamos (libro_id, usuario_id, fecha_prestamo, estado) VALUES
	(1, 1, '2026-08-10', 'prestado'),
	(2, 2, '2026-08-12', 'devuelto');