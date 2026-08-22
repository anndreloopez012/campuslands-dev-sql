PRAGMA foreign_keys = ON;

-- Ejercicio 088: Clinica Tatuajes
INSERT INTO artistas (nombre, estilo) VALUES
	('Alex Ink', 'Blackwork'),
	('Sora Tattoo', 'Neotradicional');

INSERT INTO clientes (nombre, telefono) VALUES
	('Laura Restrepo', '555-8899'),
	('Daniel Vargas', '555-6677');

INSERT INTO citas (artista_id, cliente_id, diseno, costo) VALUES
	(1, 1, 'Dragon en antebrazo', 150.00),
	(2, 2, 'Rosa Neotradicional', 120.00);