PRAGMA foreign_keys = ON;

-- Ejercicio 099: Liga Videojuego Futbol
DROP TABLE IF EXISTS jornadas;
DROP TABLE IF EXISTS clubes;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	psn_id TEXT NOT NULL UNIQUE
);

CREATE TABLE clubes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	usuario_id INTEGER NOT NULL,
	nombre_club TEXT NOT NULL UNIQUE,
	puntos INTEGER NOT NULL DEFAULT 0 CHECK (puntos >= 0),
	FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE jornadas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	club_local_id INTEGER NOT NULL,
	club_visita_id INTEGER NOT NULL,
	goles_local INTEGER NOT NULL CHECK (goles_local >= 0),
	goles_visita INTEGER NOT NULL CHECK (goles_visita >= 0),
	FOREIGN KEY (club_local_id) REFERENCES clubes(id),
	FOREIGN KEY (club_visita_id) REFERENCES clubes(id)
);