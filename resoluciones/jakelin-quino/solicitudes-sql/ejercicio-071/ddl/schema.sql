PRAGMA foreign_keys = ON;

-- Ejercicio 071: Battle Royale Ranking
DROP TABLE IF EXISTS estadisticas;
DROP TABLE IF EXISTS partidas;
DROP TABLE IF EXISTS jugadores;

CREATE TABLE jugadores (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nickname TEXT NOT NULL UNIQUE,
	nivel INTEGER NOT NULL DEFAULT 1 CHECK (nivel >= 1)
);

CREATE TABLE partidas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	mapa TEXT NOT NULL,
	duracion_min INTEGER NOT NULL CHECK (duracion_min > 0)
);

CREATE TABLE estadisticas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	jugador_id INTEGER NOT NULL,
	partida_id INTEGER NOT NULL,
	kills INTEGER NOT NULL DEFAULT 0 CHECK (kills >= 0),
	posicion INTEGER NOT NULL CHECK (posicion >= 1),
	FOREIGN KEY (jugador_id) REFERENCES jugadores(id),
	FOREIGN KEY (partida_id) REFERENCES partidas(id)
);