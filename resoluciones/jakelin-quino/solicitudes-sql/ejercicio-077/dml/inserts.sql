PRAGMA foreign_keys = ON;

-- Ejercicio 077: Taller de Motos
INSERT INTO clientes (nombre, telefono) VALUES
	('Carlos Gomez', '555-1010'),
	('Maria Lopez', '555-2020'),
	('Juan Perez', '555-3030');

INSERT INTO motos (cliente_id, placa, marca) VALUES
	(1, 'MTO-101', 'Yamaha'),
	(2, 'MTO-202', 'Honda'),
	(3, 'MTO-303', 'Kawasaki');

INSERT INTO servicios (moto_id, descripcion, costo, estado) VALUES
	(1, 'Cambio de aceite', 45.00, 'completado'),
	(2, 'Revision de frenos', 60.00, 'pendiente'),
	(3, 'Mantenimiento general', 120.00, 'completado');