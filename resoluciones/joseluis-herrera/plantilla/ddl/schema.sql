PRAGMA foreign_keys = ON;

-- Cree aqui las tablas del modelo CineMax.
-- Recuerde usar maximo 4 tablas e incluir:
-- PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

CREATE TABLE Peliculas (
    id_pelicula INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL UNIQUE,
    genero TEXT NOT NULL,
    descripcion TEXT NOT NULL,
    duracion INTEGER NOT NULL CHECK (duracion > 0),
    idioma TEXT NOT NULL
)

CREATE TABLE Salas (
    id_sala INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    cantidad_asientos INTEGER NOT NULL CHECK (cantidad_asientos > 0)
)

CREATE TABLE Funciones (
    id_funcion INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pelicula INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    hora DATE NOT NULL,

    FOREIGN KEY (id_pelicula) REFERENCES Peliculas(id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES Salas(id_sala)
)

CREATE TABLE Boletos (
    id_boleto INTEGER PRIMARY KEY AUTOINCREMENT,
    id_funcion INTEGER NOT NULL,
    asiento TEXT NOT NULL,
    precio REAL NOT NULL CHECK (precio > 0),
    
    FOREIGN KEY (id_funcion) REFERENCES Funciones(id_funcion)
)

