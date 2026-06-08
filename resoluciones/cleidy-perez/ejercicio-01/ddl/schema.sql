PRAGMA foreign_keys = ON;

-- Cree aqui las tablas del modelo CineMax.
-- Recuerde usar maximo 4 tablas e incluir:
-- PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.
CREATE TABLE peliculas (
    id_pelicula INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    director TEXT,
    duracion TEXT,
    genero TEXT
);

CREATE TABLE boleto (
    id_boleto INTEGER PRIMARY KEY,
    id_funcion INTEGER UNIQUE,
    id_pelicula INTEGER,
    fecha_compra TEXT,
    asiento TEXT

    FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula)
    FOREIGN KEY (id_funcion) REFERENCES funcion (id_funcion)
)

CREATE TABLE sala (
    id_sala INTEGER PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    capacidad INTEGER
)

CREATE TABLE IF NOT EXISTS funcion (
    id_funcion INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    id_pelicula INTEGER,
    id_sala INTEGER,
    fecha TEXT NOT NULL,
    hora TEXT NOT NULL,
    precio FLOAT NOT NULL CHECK (precio > 0)
)