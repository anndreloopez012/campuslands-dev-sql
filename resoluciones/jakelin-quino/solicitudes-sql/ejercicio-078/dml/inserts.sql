PRAGMA foreign_keys = ON;

-- Ejercicio 078: Torneo Esports
INSERT INTO equipos (nombre, pais) VALUES
	('Alpha Gaming', 'Colombia'),
	('Beta Esports', 'Mexico'),
	('Gamma Squad', 'Argentina');

INSERT INTO jugadores (equipo_id, nickname, rol) VALUES
	(1, 'Slayer99', 'Capitan'),
	(2, 'ShadowX', 'Soporte'),
	(3, 'Phoenix', 'Estratega');

INSERT INTO partidas (equipo_local_id, equipo_visitante_id, puntos_local, puntos_visitante) VALUES
	(1, 2, 2, 1),
	(2, 3, 0, 2),
	(3, 1, 1, 2);