PRAGMA foreign_keys = ON;

-- Ejercicio 005: Cine Horror Nights
INSERT INTO peliculas (titulo, duracion_min) VALUES
	('La Sombra en la Niebla', 105),
	('El Despertar del Ente', 120),
	('Noche de Pesadillas', 95);

INSERT INTO salas (nombre, capacidad) VALUES
	('Sala Macabra 1', 80),
	('Sala Terror VIP', 40);

INSERT INTO funciones (pelicula_id, sala_id, horario, precio) VALUES
	(1, 1, '18:00', 8.50),
	(2, 2, '20:30', 12.00),
	(3, 1, '21:00', 8.50);