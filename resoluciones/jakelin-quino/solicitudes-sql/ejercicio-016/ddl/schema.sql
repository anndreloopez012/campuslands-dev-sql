PRAGMA foreign_keys = ON;

-- Ejercicio 016: Hotel Gamers
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS habitaciones;
DROP TABLE IF EXISTS huespedes;

CREATE TABLE huespedes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	gamertag TEXT NOT NULL UNIQUE
);

CREATE TABLE habitaciones (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	numero TEXT NOT NULL UNIQUE,
	consola TEXT NOT NULL,
	precio_noche REAL NOT NULL CHECK (precio_noche > 0)
);

CREATE TABLE reservas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	huesped_id INTEGER NOT NULL,
	habitacion_id INTEGER NOT NULL,
	noches INTEGER NOT NULL CHECK (noches > 0),
	FOREIGN KEY (huesped_id) REFERENCES huespedes(id),
	FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id)
);