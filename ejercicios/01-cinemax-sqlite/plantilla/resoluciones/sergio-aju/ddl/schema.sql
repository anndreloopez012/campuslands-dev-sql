PRAGMA foreign_keys = ON;

CREATE TABLE peliculas (
    id_pelicula INTEGER PRIMARY KEY,
    titulo TEXT NOT NULL,
    duracion_minutos INTEGER NOT NULL CHECK(duracion_minutos > 0),
    clasificacion TEXT NOT NULL,
    genero TEXT NOT NULL
);

CREATE TABLE salas (
    id_sala INTEGER PRIMARY KEY,
    nombre_sala TEXT NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL CHECK(capacidad > 0),
    tipo_proyeccion TEXT NOT NULL
);

CREATE TABLE funciones (
    id_funcion INTEGER PRIMARY KEY,
    id_pelicula INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    fecha_hora TEXT NOT NULL,
    precio_base DECIMAL NOT NULL CHECK(precio_base > 0),
    FOREIGN KEY(id_pelicula) REFERENCES peliculas(id_pelicula),
    FOREIGN KEY(id_sala) REFERENCES salas(id_sala)
);

CREATE TABLE boletos (
    id_boleto INTEGER PRIMARY KEY,
    id_funcion INTEGER NOT NULL,
    numero_asiento TEXT NOT NULL,
    fecha_compra TEXT NOT NULL,
    total_pagado DECIMAL NOT NULL CHECK(total_pagado >= 0),
    FOREIGN KEY(id_funcion) REFERENCES funciones(id_funcion)
);
