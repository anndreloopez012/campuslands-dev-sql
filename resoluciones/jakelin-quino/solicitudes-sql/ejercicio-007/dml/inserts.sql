PRAGMA foreign_keys = ON;

-- Ejercicio 007: Academia Kickboxing
INSERT INTO planes (nombre, precio) VALUES
	('Mensual Basico', 50.00),
	('Mensual Pro', 80.00),
	('Anual Elite', 700.00);

INSERT INTO alumnos (nombre, telefono) VALUES
	('Mateo Perez', '555-1122'),
	('Camila Ortiz', '555-3344'),
	('Jorge Lara', '555-5566');

INSERT INTO inscripciones (alumno_id, plan_id, fecha, estado) VALUES
	(1, 1, '2026-08-01', 'activo'),
	(2, 2, '2026-08-02', 'activo'),
	(3, 1, '2026-08-05', 'inactivo');