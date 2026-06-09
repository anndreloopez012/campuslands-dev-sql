PRAGMA foreign_keys = ON;

-- Cree aqui las tablas del modelo CineMax.
-- Recuerde usar maximo 4 tablas e incluir:
-- PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

CREATE TABLE Peliculas (
    pelicula_id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    duracion INTEGER NOT NULL,
    genero TEXT NOT NULL,
    clasificacion TEXT NOT NULL,
    director TEXT NOT NULL,
    fecha_estreno DATE NOT NULL
);

CREATE TABLE Salas (
    sala_id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL
        CHECK (capacidad > 0),
    formato TEXT NOT NULL,
    estado TEXT NOT NULL CHECK (estado IN ('Activa','Mantenimiento','Inactiva'))
);

CREATE TABLE Funciones (
    funcion_id INTEGER PRIMARY KEY,
    pelicula_id INTEGER NOT NULL,
    sala_id INTEGER NOT NULL,
    fecha_funcion DATE NOT NULL,
    hora_inicio DATETIME NOT NULL,
    hora_fin DATETIME NOT NULL,
    formato TEXT NOT NULL,
    FOREIGN KEY (pelicula_id) REFERENCES Peliculas(pelicula_id),
    FOREIGN KEY (sala_id) REFERENCES Salas(sala_id)
);

CREATE TABLE Boletos (
    boleto_id INTEGER PRIMARY KEY,
    funcion_id INTEGER NOT NULL,
    asiento INTEGER NOT NULL,
    precio REAL NOT NULL CHECK (precio >= 0),
    estado TEXT NOT NULL CHECK (estado IN ('Disponible','Reservado','Vendido')),
    FOREIGN KEY (funcion_id) REFERENCES Funciones(funcion_id),
    UNIQUE(funcion_id, asiento)
);

