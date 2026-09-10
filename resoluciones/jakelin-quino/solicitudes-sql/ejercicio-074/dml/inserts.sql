PRAGMA foreign_keys = ON;

-- Ejercicio 074: Liga Videojuego Futbol
INSERT INTO usuarios (nombre, psn_id) VALUES
	('Gabriel Paz', 'GabyFifa'),
	('Ignacio Perez', 'NachoFC');

INSERT INTO clubes (usuario_id, nombre_club, puntos) VALUES
	(1, 'Real Madrid FUT', 15),
	(2, 'Barca eSports', 12);

INSERT INTO jornadas (club_local_id, club_visita_id, goles_local, goles_visita) VALUES
	(1, 2, 3, 1);