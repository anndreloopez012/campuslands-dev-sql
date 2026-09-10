PRAGMA foreign_keys = ON;

-- Ejercicio 092: Streaming Musica
INSERT INTO artistas (nombre, genero) VALUES
	('Daft Punk', 'Electronic'),
	('Coldplay', 'Rock/Pop');

INSERT INTO canciones (artista_id, titulo, duracion_seg) VALUES
	(1, 'One More Time', 320),
	(1, 'Get Lucky', 248),
	(2, 'Yellow', 269);

INSERT INTO reproducciones (cancion_id, usuario, fecha) VALUES
	(1, 'User_01', '2026-08-20'),
	(2, 'User_02', '2026-08-20'),
	(3, 'User_01', '2026-08-21');