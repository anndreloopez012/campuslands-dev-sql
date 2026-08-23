PRAGMA foreign_keys = ON;

-- Ejercicio 16: Aerolinea Vuelos
-- Modelo: aeropuertos, aviones, vuelos, reservas

CREATE TABLE aeropuertos (
    id_aeropuerto  INTEGER PRIMARY KEY AUTOINCREMENT,
    codigo         TEXT NOT NULL UNIQUE,
    nombre         TEXT NOT NULL,
    ciudad         TEXT NOT NULL
);

CREATE TABLE aviones (
    id_avion    INTEGER PRIMARY KEY AUTOINCREMENT,
    matricula   TEXT NOT NULL UNIQUE,
    modelo      TEXT NOT NULL,
    capacidad   INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE vuelos (
    id_vuelo               INTEGER PRIMARY KEY AUTOINCREMENT,
    id_avion               INTEGER NOT NULL,
    id_aeropuerto_origen   INTEGER NOT NULL,
    id_aeropuerto_destino  INTEGER NOT NULL,
    fecha_salida           TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'
    precio_base            REAL NOT NULL CHECK (precio_base > 0),

    CHECK (id_aeropuerto_origen <> id_aeropuerto_destino),
    FOREIGN KEY (id_avion) REFERENCES aviones (id_avion),
    FOREIGN KEY (id_aeropuerto_origen) REFERENCES aeropuertos (id_aeropuerto),
    FOREIGN KEY (id_aeropuerto_destino) REFERENCES aeropuertos (id_aeropuerto)
);

CREATE TABLE reservas (
    id_reserva       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vuelo         INTEGER NOT NULL,
    pasajero         TEXT NOT NULL,
    asiento          TEXT NOT NULL,
    precio_pagado    REAL NOT NULL CHECK (precio_pagado > 0),
    estado           TEXT NOT NULL CHECK (estado IN ('confirmada', 'pendiente', 'cancelada')),

    UNIQUE (id_vuelo, asiento),
    FOREIGN KEY (id_vuelo) REFERENCES vuelos (id_vuelo)
);
