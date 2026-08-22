PRAGMA foreign_keys = ON;

-- Ejercicio 012: Club Futbol Sala
DROP TABLE IF EXISTS partidos;
DROP TABLE IF EXISTS jugadores;
DROP TABLE IF EXISTS equipos;

CREATE TABLE equipos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	barrio TEXT NOT NULL
);

CREATE TABLE jugadores (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	equipo_id INTEGER NOT NULL,
	nombre TEXT NOT NULL,
	dorsal INTEGER NOT NULL CHECK (dorsal > 0),
	FOREIGN KEY (equipo_id) REFERENCES equipos(id)
);

CREATE TABLE partidos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	equipo_local_id INTEGER NOT NULL,
	equipo_visita_id INTEGER NOT NULL,
	goles_local INTEGER NOT NULL DEFAULT 0 CHECK (goles_local >= 0),
	goles_visita INTEGER NOT NULL DEFAULT 0 CHECK (goles_visita >= 0),
	FOREIGN KEY (equipo_local_id) REFERENCES equipos(id),
	FOREIGN KEY (equipo_visita_id) REFERENCES equipos(id)
);