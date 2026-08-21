PRAGMA foreign_keys = ON;

-- Ejercicio 005: Cine Horror Nights
-- Modelo minimo: catalogo de peliculas (una funcion cada una) y venta
-- de boletos.

CREATE TABLE peliculas (
    id_pelicula    INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo         TEXT NOT NULL UNIQUE,
    genero         TEXT NOT NULL CHECK (genero IN ('terror', 'suspenso', 'thriller', 'clasico')),
    sala_asignada  TEXT NOT NULL,
    precio_boleto  REAL NOT NULL CHECK (precio_boleto > 0)
);

-- boletos: tabla principal (transaccional). UNIQUE(id_pelicula, asiento)
-- evita vender el mismo asiento dos veces para la misma funcion.
CREATE TABLE boletos (
    id_boleto      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pelicula    INTEGER NOT NULL,
    nombre_cliente TEXT NOT NULL,
    asiento        TEXT NOT NULL,
    precio_pagado  REAL NOT NULL CHECK (precio_pagado > 0),
    fecha_compra   TEXT NOT NULL DEFAULT (datetime('now')),
    estado         TEXT NOT NULL DEFAULT 'vendido' CHECK (estado IN ('vendido', 'usado', 'reembolsado')),

    FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula),
    UNIQUE (id_pelicula, asiento)
);
