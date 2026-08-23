PRAGMA foreign_keys = ON;

-- Ejercicio 01: CineMax SQLite
-- Modelo: peliculas, salas, funciones, boletos

CREATE TABLE peliculas (
    id_pelicula     INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo          TEXT NOT NULL,
    genero          TEXT NOT NULL,
    duracion_min    INTEGER NOT NULL CHECK (duracion_min > 0),
    clasificacion   TEXT NOT NULL CHECK (clasificacion IN ('A', 'B', 'B15', 'C'))
);

CREATE TABLE salas (
    id_sala     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE,
    capacidad   INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE funciones (
    id_funcion   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pelicula  INTEGER NOT NULL,
    id_sala      INTEGER NOT NULL,
    fecha_hora   TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'
    precio_base  REAL NOT NULL CHECK (precio_base > 0),

    FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES salas (id_sala),
    UNIQUE (id_sala, fecha_hora)
);

CREATE TABLE boletos (
    id_boleto      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_funcion     INTEGER NOT NULL,
    asiento        TEXT NOT NULL,
    precio_pagado  REAL NOT NULL CHECK (precio_pagado > 0),
    estado         TEXT NOT NULL DEFAULT 'reservado' CHECK (estado IN ('reservado', 'pagado', 'cancelado')),
    fecha_compra   TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_funcion) REFERENCES funciones (id_funcion),
    UNIQUE (id_funcion, asiento)
);
