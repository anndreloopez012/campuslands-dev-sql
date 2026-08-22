PRAGMA foreign_keys = ON;

-- Ejercicio 002: Taller de Motos
DROP TABLE IF EXISTS servicios;
DROP TABLE IF EXISTS motos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	telefono TEXT NOT NULL UNIQUE
);

CREATE TABLE motos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cliente_id INTEGER NOT NULL,
	placa TEXT NOT NULL UNIQUE,
	marca TEXT NOT NULL,
	FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE servicios (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	moto_id INTEGER NOT NULL,
	descripcion TEXT NOT NULL,
	costo REAL NOT NULL CHECK (costo > 0),
	estado TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'completado', 'cancelado')),
	FOREIGN KEY (moto_id) REFERENCES motos(id)
);