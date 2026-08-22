PRAGMA foreign_keys = ON;

-- Ejercicio 059: Estudio Animacion 3D
DROP TABLE IF EXISTS renders;
DROP TABLE IF EXISTS proyectos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	empresa TEXT NOT NULL UNIQUE,
	contacto TEXT NOT NULL
);

CREATE TABLE proyectos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cliente_id INTEGER NOT NULL,
	nombre TEXT NOT NULL,
	presupuesto REAL NOT NULL CHECK (presupuesto > 0),
	FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE renders (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	proyecto_id INTEGER NOT NULL,
	escena TEXT NOT NULL,
	tiempo_horas REAL NOT NULL CHECK (tiempo_horas > 0),
	estado TEXT NOT NULL DEFAULT 'en_proceso' CHECK (estado IN ('en_proceso', 'finalizado')),
	FOREIGN KEY (proyecto_id) REFERENCES proyectos(id)
);