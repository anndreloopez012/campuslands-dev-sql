PRAGMA foreign_keys = ON;

-- Cree aqui las tablas del modelo CineMax.
-- Recuerde usar maximo 4 tablas e incluir:
-- PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

CREATE TABLE peliculas (
    id_pelicula INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo VARCHAR(150) NOT NULL UNIQUE,
    duracion INTEGER NOT NULL CHECK (duracion > 0),
    director VARCHAR(100),
    genero VARCHAR(50)
);

CREATE TABLE salas (
    id_sala INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo VARCHAR(50) NOT NULL,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE funciones (
    id_funcion INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pelicula INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    horario TEXT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    fecha TEXT NOT NULL,
    FOREIGN KEY (id_pelicula) REFERENCES peliculas(id_pelicula) ON DELETE CASCADE,
    FOREIGN KEY (id_sala) REFERENCES salas(id_sala) ON DELETE CASCADE
);

CREATE TABLE boletos_vendidos (
    id_boletos INTEGER PRIMARY KEY AUTOINCREMENT,
    numero_serie VARCHAR(100) NOT NULL UNIQUE,
    id_funcion INTEGER NOT NULL,
    fecha_compra TEXT NOT NULL,
    numero_asiento VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_funcion) REFERENCES funciones(id_funcion) ON DELETE CASCADE
);
