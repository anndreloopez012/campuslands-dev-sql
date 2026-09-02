PRAGMA foreign_keys = ON;

-- Ejercicio 080: Cine Horror Nights
DROP TABLE IF EXISTS funciones;
DROP TABLE IF EXISTS salas;
DROP TABLE IF EXISTS peliculas;

CREATE TABLE peliculas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	titulo TEXT NOT NULL UNIQUE,
	duracion_min INTEGER NOT NULL CHECK (duracion_min > 0)
);

CREATE TABLE salas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	capacidad INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE funciones (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	pelicula_id INTEGER NOT NULL,
	sala_id INTEGER NOT NULL,
	horario TEXT NOT NULL,
	precio REAL NOT NULL CHECK (precio > 0),
	FOREIGN KEY (pelicula_id) REFERENCES peliculas(id),
	FOREIGN KEY (sala_id) REFERENCES salas(id)
);