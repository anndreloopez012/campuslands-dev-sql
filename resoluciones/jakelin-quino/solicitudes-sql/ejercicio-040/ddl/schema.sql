PRAGMA foreign_keys = ON;

-- Ejercicio 040: Laboratorio Quimico
DROP TABLE IF EXISTS ensayos;
DROP TABLE IF EXISTS muestras;
DROP TABLE IF EXISTS reactivos;

CREATE TABLE reactivos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	pureza_pct REAL NOT NULL CHECK (pureza_pct > 0 AND pureza_pct <= 100)
);

CREATE TABLE muestras (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	codigo TEXT NOT NULL UNIQUE,
	origen TEXT NOT NULL
);

CREATE TABLE ensayos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	muestra_id INTEGER NOT NULL,
	reactivo_id INTEGER NOT NULL,
	resultado TEXT NOT NULL,
	FOREIGN KEY (muestra_id) REFERENCES muestras(id),
	FOREIGN KEY (reactivo_id) REFERENCES reactivos(id)
);