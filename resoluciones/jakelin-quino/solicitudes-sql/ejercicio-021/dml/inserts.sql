PRAGMA foreign_keys = ON;

-- Ejercicio 021: Battle Royale Ranking
INSERT INTO jugadores (nickname, nivel) VALUES
	('NinjaPro', 50),
	('ShroudKW', 65),
	('MythX', 40);

INSERT INTO partidas (mapa, duracion_min) VALUES
	('Erangel', 30),
	('Miramar', 35);

INSERT INTO estadisticas (jugador_id, partida_id, kills, posicion) VALUES
	(1, 1, 8, 1),
	(2, 1, 5, 2),
	(3, 2, 10, 1);