PRAGMA foreign_keys = ON;

-- Cree aqui las tablas del modelo CineMax.
-- Recuerde usar maximo 4 tablas e incluir:
-- PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

-- ============================================================
-- CineMax - Esquema de base de datos (DDL)
-- Autor: Maria Montepeque
-- Motor: SQLite
-- ============================================================

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS boletos;

DROP TABLE IF EXISTS funciones;

DROP TABLE IF EXISTS salas;

DROP TABLE IF EXISTS peliculas;

-- Tabla: peliculas
CREATE TABLE peliculas (
    id_pelicula INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    duracion INTEGER NOT NULL CHECK (duracion > 0), -- en minutos
    genero TEXT NOT NULL,
    clasificacion TEXT NOT NULL CHECK (
        clasificacion IN ('TP', '+12', '+15', '+18')
    )
);

-- Tabla: salas
CREATE TABLE salas (
    id_sala INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0),
    tipo TEXT NOT NULL CHECK (
        tipo IN ('2D', '3D', 'IMAX', '4DX')
    )
);

-- Tabla: funciones
CREATE TABLE funciones (
    id_funcion INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pelicula INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    fecha TEXT NOT NULL, -- formato YYYY-MM-DD
    hora TEXT NOT NULL, -- formato HH:MM
    precio REAL NOT NULL CHECK (precio > 0),
    FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES salas (id_sala),
    -- Una misma sala no puede tener dos funciones a la misma fecha y hora.
    UNIQUE (id_sala, fecha, hora)
);

-- Tabla: boletos
CREATE TABLE boletos (
    id_boleto INTEGER PRIMARY KEY AUTOINCREMENT,
    id_funcion INTEGER NOT NULL,
    asiento TEXT NOT NULL,
    fecha_compra TEXT NOT NULL, -- formato YYYY-MM-DD
    precio_pagado REAL NOT NULL CHECK (precio_pagado >= 0),
    FOREIGN KEY (id_funcion) REFERENCES funciones (id_funcion),
    -- No se puede vender dos veces el mismo asiento en una misma funcion.
    UNIQUE (id_funcion, asiento)
);