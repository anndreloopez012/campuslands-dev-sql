PRAGMA foreign_keys = ON;

-- Ejercicio 014: Mecanica de Autos
INSERT INTO clientes (nombre, telefono) VALUES
	('Gonzalo Ramos', '555-4321'),
	('Patricia Hoyos', '555-8765');

INSERT INTO vehiculos (cliente_id, placa, modelo) VALUES
	(1, 'ABC-123', 'Toyota Corolla'),
	(2, 'XYZ-789', 'Chevrolet Onix');

INSERT INTO ordenes (vehiculo_id, falla, costo_estimado) VALUES
	(1, 'Cambio de embrague', 250.00),
	(2, 'Fuga de refrigerante', 90.00);