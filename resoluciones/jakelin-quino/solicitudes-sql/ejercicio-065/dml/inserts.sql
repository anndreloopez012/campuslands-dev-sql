PRAGMA foreign_keys = ON;

-- Ejercicio 065: Laboratorio Quimico
INSERT INTO reactivos (nombre, pureza_pct) VALUES
	('Acido Sulfurico', 98.5),
	('Hidroxido de Sodio', 99.0);

INSERT INTO muestras (codigo, origen) VALUES
	('M-001', 'Agua de Rio'),
	('M-002', 'Suelo Agricola');

INSERT INTO ensayos (muestra_id, reactivo_id, resultado) VALUES
	(1, 1, 'pH Acido 2.1'),
	(2, 2, 'Neutralizacion Correcta');