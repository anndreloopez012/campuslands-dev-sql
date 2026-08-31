PRAGMA foreign_keys = ON;

-- Ejercicio 017: Streaming Musica
DROP TABLE IF EXISTS reproducciones;
DROP TABLE IF EXISTS canciones;
DROP TABLE IF EXISTS artistas;

CREATE TABLE artistas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	genero TEXT NOT NULL
);

CREATE TABLE canciones (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	artista_id INTEGER NOT NULL,
	titulo TEXT NOT NULL,
	duracion_seg INTEGER NOT NULL CHECK (duracion_seg > 0),
	FOREIGN KEY (artista_id) REFERENCES artistas(id)
);

CREATE TABLE reproducciones (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cancion_id INTEGER NOT NULL,
	usuario TEXT NOT NULL,
	fecha TEXT NOT NULL,
	FOREIGN KEY (cancion_id) REFERENCES canciones(id)
);