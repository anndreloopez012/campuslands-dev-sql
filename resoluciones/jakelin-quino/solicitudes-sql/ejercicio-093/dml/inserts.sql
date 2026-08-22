PRAGMA foreign_keys = ON;

-- Ejercicio 093: Escuela de Dibujo
INSERT INTO profesores (nombre, especialidad) VALUES
	('Leonardo Vinci', 'Ilustracion Digital'),
	('Rembrandt Roo', 'Retrato a Carboncillo');

INSERT INTO cursos (profesor_id, titulo, costo) VALUES
	(1, 'Dibujo de Manga y Anime', 120.00),
	(2, 'Anatomia Humana basica', 150.00);

INSERT INTO inscripciones (curso_id, alumno, fecha) VALUES
	(1, 'Nora Coto', '2026-08-10'),
	(2, 'Pablo Picasso', '2026-08-12');