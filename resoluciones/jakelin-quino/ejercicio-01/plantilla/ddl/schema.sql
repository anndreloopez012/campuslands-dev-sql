PRAGMA foreign_keys = ON;

-- Cree aqui las tablas del modelo CineMax.
-- Recuerde usar maximo 4 tablas e incluir:
-- PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

CREATE TABLE peliculas (
    pelicula_id INTEGER PRIMARY KEY,
    pelicula_nombre TEXT NOT NULL,
    duracion INTEGER NOT NULL CHECK(duracion > 0),
    clasificacion TEXT NOT NULL CHECK(clasificacion IN ('AA', 'A', 'B', 'B15', 'C'))
);

CREATE TABLE sala (
    sala_id INTEGER PRIMARY KEY,
    sala_nombre TEXT NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL CHECK(capacidad > 0)
);



CREATE TABLE funciones (
    funcion_id INTEGER PRIMARY KEY,
    pelicula_id INTEGER NOT NULL,
    sala_id INTEGER NOT NULL,
    fecha_hora TEXT NOT NULL,
    precio REAL NOT NULL CHECK(precio >= 0),
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(pelicula_id),
    FOREIGN KEY (sala_id) REFERENCES sala(sala_id),
    UNIQUE(sala_id, fecha_hora)
);

CREATE TABLE boletos (
    boletos_id INTEGER PRIMARY KEY AUTOINCREMENT,
    funcion_id INTEGER NOT NULL,
    numero_asiento TEXT NOT NULL,
    fecha_compra TEXT NOT NULL,
    FOREIGN KEY (funcion_id) REFERENCES funciones(funcion_id),
    UNIQUE(funcion_id, numero_asiento)
);