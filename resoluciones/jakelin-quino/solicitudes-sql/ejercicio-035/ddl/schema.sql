PRAGMA foreign_keys = ON;

-- Ejercicio 035: Biblioteca Sci-Fi
DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS libros;

CREATE TABLE libros (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	titulo TEXT NOT NULL UNIQUE,
	autor TEXT NOT NULL
);

CREATE TABLE usuarios (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	carnet TEXT NOT NULL UNIQUE
);

CREATE TABLE prestamos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	libro_id INTEGER NOT NULL,
	usuario_id INTEGER NOT NULL,
	fecha_prestamo TEXT NOT NULL,
	estado TEXT NOT NULL DEFAULT 'prestado' CHECK (estado IN ('prestado', 'devuelto')),
	FOREIGN KEY (libro_id) REFERENCES libros(id),
	FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);