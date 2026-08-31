PRAGMA foreign_keys = ON;

-- Ejercicio 053: Torneo Esports
DROP TABLE IF EXISTS partidas;
DROP TABLE IF EXISTS jugadores;
DROP TABLE IF EXISTS equipos;

CREATE TABLE equipos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	pais TEXT NOT NULL
);

CREATE TABLE jugadores (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	equipo_id INTEGER NOT NULL,
	nickname TEXT NOT NULL UNIQUE,
	rol TEXT NOT NULL,
	FOREIGN KEY (equipo_id) REFERENCES equipos(id)
);

CREATE TABLE partidas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	equipo_local_id INTEGER NOT NULL,
	equipo_visitante_id INTEGER NOT NULL,
	puntos_local INTEGER NOT NULL CHECK (puntos_local >= 0),
	puntos_visitante INTEGER NOT NULL CHECK (puntos_visitante >= 0),
	FOREIGN KEY (equipo_local_id) REFERENCES equipos(id),
	FOREIGN KEY (equipo_visitante_id) REFERENCES equipos(id)
);