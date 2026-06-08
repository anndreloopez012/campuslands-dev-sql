PRAGMA foreign_keys = ON;

PRAGMA foreign_keys = ON;

CREATE DATABASE CineMax;
USE CineMax;

CREATE TABLE peliculas(
id_pelicula INT PRIMARY KEY,
titulo VARCHAR(100) NOT NULL UNIQUE,
genero VARCHAR(100) NOT NULL,
duracion_minutos INT NOT NULL
	CHECK (duracion_minutos > 0),
clasificacion VARCHAR(100) NOT NULL
);

CREATE TABLE salas(
id_sala INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL UNIQUE,
capacidad INT NOT NULL
	CHECK (capacidad > 0)
);

CREATE TABLE funciones(
id_funcion INT PRIMARY KEY,
id_pelicula INT NOT NULL,
id_sala INT NOT NULL,
fecha_hora VARCHAR(20) NOT NULL,
precio VARCHAR(5) NOT NULL
	CHECK (precio > 0),

FOREIGN KEY (id_pelicula) REFERENCES salas(id_pelicula),
FOREIGN KEY (id_sala) REFERENCES salas(id_sala)
);

CREATE TABLE boletos(
id_boleto INT PRIMARY KEY,
id_funcion INT NOT NULL,
asiento VARCHAR(5) NOT NULL,
fecha_compra VARCHAR(10) NOT NULL,

FOREIGN KEY (id_funcion) REFERENCES funciones(id_funcion),

UNIQUE(id_funcion, asiento)
);

