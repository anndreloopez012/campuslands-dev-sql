PRAGMA foreign_keys = ON;

-- Ejercicio 091: Hotel Gamers
INSERT INTO huespedes (nombre, gamertag) VALUES
	('Kevin Mejia', 'KevGod'),
	('Brenda Soler', 'QueenB');

INSERT INTO habitaciones (numero, consola, precio_noche) VALUES
	('101-PC', 'RTX 4090 PC', 110.00),
	('102-PS5', 'PlayStation 5', 85.00);

INSERT INTO reservas (huesped_id, habitacion_id, noches) VALUES
	(1, 1, 2),
	(2, 2, 3);