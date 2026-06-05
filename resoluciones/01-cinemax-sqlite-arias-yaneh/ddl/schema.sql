PRAGMA foreign_keys = ON;

CREATE TABLE Peliculas (
    id_pelicula INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL UNIQUE,
    duracion_minutos INTEGER NOT NULL
);

CREATE TABLE Salas (
    id_sala INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_sala TEXT NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL
);

CREATE TABLE Funciones (
    id_funcion INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pelicula INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    fecha_hora DATETIME NOT NULL,
    FOREIGN KEY (id_pelicula) REFERENCES Peliculas(id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES Salas(id_sala)
);