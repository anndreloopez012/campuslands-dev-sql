PRAGMA foreign_keys = ON;

-- Ejercicio 006: Renta Autos de Lujo
INSERT INTO clientes (nombre, licencia) VALUES
	('Fernando Torres', 'LIC-9988'),
	('Gabriela Silva', 'LIC-7766'),
	('Roberto Diaz', 'LIC-5544');

INSERT INTO vehiculos (marca, modelo, precio_dia, estado) VALUES
	('Porsche', '911 Carrera', 350.00, 'disponible'),
	('Ferrari', 'F8 Tributo', 600.00, 'disponible'),
	('Lamborghini', 'Huracan', 550.00, 'disponible');

INSERT INTO reservas (cliente_id, vehiculo_id, dias, total) VALUES
	(1, 1, 3, 1050.00),
	(2, 2, 2, 1200.00);