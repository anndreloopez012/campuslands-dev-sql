PRAGMA foreign_keys = ON;

-- Ejercicio 022: Liga MOBA
INSERT INTO equipos (nombre, region) VALUES
	('T1', 'LCK Korea'),
	('G2 Esports', 'LEC Europe');

INSERT INTO jugadores (equipo_id, nickname, rol) VALUES
	(1, 'Faker', 'Mid'),
	(1, 'Zeus', 'Top'),
	(2, 'Caps', 'Mid');

INSERT INTO partidas (jugador_id, heroe, kda_ratio) VALUES
	(1, 'Ahri', 8.5),
	(2, 'Jayce', 4.2),
	(3, 'Sylas', 6.0);