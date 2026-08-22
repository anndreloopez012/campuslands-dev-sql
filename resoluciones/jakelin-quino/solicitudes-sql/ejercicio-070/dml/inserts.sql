PRAGMA foreign_keys = ON;

-- Ejercicio 070: Soldadura Industrial
INSERT INTO clientes (empresa, contacto) VALUES
	('Metalicas del Norte', 'Marcos Paz'),
	('Estructuras Metalicas', 'Lucia Ferro');

INSERT INTO materiales (tipo, precio_kg) VALUES
	('Acero Inoxidable', 5.50),
	('Aluminio Industrial', 8.00);

INSERT INTO ordenes (cliente_id, material_id, peso_kg) VALUES
	(1, 1, 150.0),
	(2, 2, 80.0);