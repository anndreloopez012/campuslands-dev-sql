PRAGMA foreign_keys = ON;

-- Ejercicio 086: Delivery de Comida
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS platos;
DROP TABLE IF EXISTS restaurantes;

CREATE TABLE restaurantes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	categoria TEXT NOT NULL
);

CREATE TABLE platos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	restaurante_id INTEGER NOT NULL,
	nombre TEXT NOT NULL,
	precio REAL NOT NULL CHECK (precio > 0),
	FOREIGN KEY (restaurante_id) REFERENCES restaurantes(id)
);

CREATE TABLE pedidos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	plato_id INTEGER NOT NULL,
	cliente TEXT NOT NULL,
	cantidad INTEGER NOT NULL CHECK (cantidad > 0),
	estado TEXT NOT NULL DEFAULT 'en_camino' CHECK (estado IN ('en_camino', 'entregado', 'cancelado')),
	FOREIGN KEY (plato_id) REFERENCES platos(id)
);