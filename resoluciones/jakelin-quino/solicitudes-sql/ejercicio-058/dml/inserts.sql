PRAGMA foreign_keys = ON;

-- Ejercicio 058: Viajes Paracaidismo
INSERT INTO clientes (nombre, pasaporte) VALUES
	('Andres Castro', 'PASS-101'),
	('Valeria Medina', 'PASS-202'),
	('Hugo Morales', 'PASS-303');

INSERT INTO saltos (modalidad, altura_pies, precio) VALUES
	('Tandem Tradicional', 10000, 200.00),
	('HAHO Extremo', 15000, 350.00);

INSERT INTO reservas (cliente_id, salto_id, fecha) VALUES
	(1, 1, '2026-08-20'),
	(2, 2, '2026-08-21');