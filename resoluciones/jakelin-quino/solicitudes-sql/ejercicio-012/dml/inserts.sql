PRAGMA foreign_keys = ON;

-- Ejercicio 012: Club Futbol Sala
INSERT INTO equipos (nombre, barrio) VALUES
	('Los Halcones', 'Centro'),
	('Deportivo Sur', 'Sur');

INSERT INTO jugadores (equipo_id, nombre, dorsal) VALUES
	(1, 'Lionel Messi', 10),
	(1, 'Angel Di Maria', 11),
	(2, 'Cristiano Ronaldo', 7);

INSERT INTO partidos (equipo_local_id, equipo_visita_id, goles_local, goles_visita) VALUES
	(1, 2, 4, 3);