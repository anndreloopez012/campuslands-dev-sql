PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS vuelos;
DROP TABLE IF EXISTS aviones;
DROP TABLE IF EXISTS aeropuertos;

-- AEROPUERTOS

CREATE TABLE aeropuertos (
    id_aeropuerto INTEGER PRIMARY KEY,
    codigo_iata TEXT NOT NULL UNIQUE,
    nombre TEXT NOT NULL,
    ciudad TEXT NOT NULL,
    pais TEXT NOT NULL
);

-- AVIONES

CREATE TABLE aviones (
    id_avion INTEGER PRIMARY KEY,
    matricula TEXT NOT NULL UNIQUE,
    modelo TEXT NOT NULL,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0),
    estado TEXT NOT NULL DEFAULT 'ACTIVO'
        CHECK (estado IN ('ACTIVO', 'MANTENIMIENTO', 'INACTIVO'))
);

-- VUELOS

CREATE TABLE vuelos (
    id_vuelo INTEGER PRIMARY KEY,
    codigo_vuelo TEXT NOT NULL UNIQUE,
    aeropuerto_origen_id INTEGER NOT NULL,
    aeropuerto_destino_id INTEGER NOT NULL,
    avion_id INTEGER NOT NULL,
    fecha_salida TEXT NOT NULL,
    fecha_llegada TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'PROGRAMADO'
        CHECK (estado IN ('PROGRAMADO', 'ABORDANDO', 'EN_VUELO', 'COMPLETADO', 'CANCELADO')),
    FOREIGN KEY (aeropuerto_origen_id) REFERENCES aeropuertos(id_aeropuerto),
    FOREIGN KEY (aeropuerto_destino_id) REFERENCES aeropuertos(id_aeropuerto),
    FOREIGN KEY (avion_id) REFERENCES aviones(id_avion),
    CHECK (aeropuerto_origen_id <> aeropuerto_destino_id),
    CHECK (fecha_llegada > fecha_salida)
);

-- RESERVAS

CREATE TABLE reservas (
    id_reserva INTEGER PRIMARY KEY,
    vuelo_id INTEGER NOT NULL,
    nombre_pasajero TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    asiento TEXT NOT NULL,
    fecha_reserva TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'CONFIRMADA'
        CHECK (estado IN ('CONFIRMADA', 'PENDIENTE', 'CANCELADA')),
    FOREIGN KEY (vuelo_id) REFERENCES vuelos(id_vuelo),
    UNIQUE (vuelo_id, asiento)
);

CREATE INDEX idx_vuelos_fecha_salida
ON vuelos(fecha_salida);

CREATE INDEX idx_reservas_vuelo
ON reservas(vuelo_id);