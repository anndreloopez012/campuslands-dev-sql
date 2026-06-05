PRAGMA foreign_keys = ON;
-- sqlite3
-- Cree aqui las tablas del modelo CineMax.
-- Recuerde usar maximo 4 tablas e incluir:
-- PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

CREATE TABLE IF NOT EXISTS peliculas(
    pelicula_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_pelicula TEXT NOT NULL UNIQUE,
    duracion INTEGER NOT NULL CHECK(duracion > 0),
    categoria TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS salas(
    sala_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_sala TEXT NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL CHECK(capacidad > 0)
);

CREATE TABLE IF NOT EXISTS boletos(
    boleto_id INTEGER PRIMARY KEY AUTOINCREMENT,
    precio_boleto REAL NOT NULL CHECK(precio_boleto > 0),
    asiento TEXT NOT NULL,
    fecha DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS funciones(
    funcion_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pelicula_id INTEGER NOT NULL,
    sala_id INTEGER NOT NULL,
    boletos_id INTEGER NOT NULL,
    horario TEXT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(pelicula_id),
    FOREIGN KEY (sala_id) REFERENCES salas(sala_id),
    FOREIGN KEY (boletos_id) REFERENCES boletos(boleto_id)
);

