PRAGMA foreign_keys = ON;

-- Ejercicio 044: Diseno 3D Arquitectura
INSERT INTO clientes (nombre, empresa) VALUES
	('Esteban Quito', 'Constructora Urbana'),
	('Diana Prince', 'Torres del Norte');

INSERT INTO proyectos (cliente_id, nombre, area_m2) VALUES
	(1, 'Edificio Horizonte', 450.0),
	(2, 'Casa de Campo', 180.0);

INSERT INTO renders (proyecto_id, vista, costo) VALUES
	(1, 'Fachada Principal Exterior', 300.00),
	(2, 'Interior Sala de Estar', 200.00);