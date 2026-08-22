PRAGMA foreign_keys = ON;

-- Ejercicio 013: Clinica Tatuajes
DROP TABLE IF EXISTS citas;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS artistas;

CREATE TABLE artistas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	estilo TEXT NOT NULL
);

CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	telefono TEXT NOT NULL UNIQUE
);

CREATE TABLE citas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	artista_id INTEGER NOT NULL,
	cliente_id INTEGER NOT NULL,
	diseno TEXT NOT NULL,
	costo REAL NOT NULL CHECK (costo > 0),
	FOREIGN KEY (artista_id) REFERENCES artistas(id),
	FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);