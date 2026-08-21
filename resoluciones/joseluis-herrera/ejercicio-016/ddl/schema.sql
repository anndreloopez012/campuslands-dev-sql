PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS vuelos;
DROP TABLE IF EXISTS aviones;
DROP TABLE IF EXISTS aeropuertos;

CREATE TABLE aeropuertos (
    id_aeropuerto INTEGER PRIMARY KEY,
    codigo TEXT NOT NULL UNIQUE,
    nombre TEXT NOT NULL,
    ciudad TEXT NOT NULL,
    pais TEXT NOT NULL
);

CREATE TABLE aviones (
    id_avion INTEGER PRIMARY KEY,
    matricula TEXT NOT NULL UNIQUE,
    modelo TEXT NOT NULL,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0),
    estado TEXT NOT NULL CHECK (
        estado IN ('activo', 'mantenimiento', 'fuera_de_servicio')
    )
);

CREATE TABLE vuelos (
    id_vuelo INTEGER PRIMARY KEY,
    codigo_vuelo TEXT NOT NULL UNIQUE,
    id_avion INTEGER NOT NULL,
    id_origen INTEGER NOT NULL,
    id_destino INTEGER NOT NULL,
    fecha_salida TEXT NOT NULL CHECK (datetime(fecha_salida) IS NOT NULL),
    fecha_llegada TEXT NOT NULL CHECK (datetime(fecha_llegada) IS NOT NULL),
    precio REAL NOT NULL CHECK (precio > 0),
    estado TEXT NOT NULL CHECK (
        estado IN ('programado', 'abordando', 'en_vuelo', 'finalizado', 'cancelado')
    ),
    FOREIGN KEY (id_avion) REFERENCES aviones(id_avion),
    FOREIGN KEY (id_origen) REFERENCES aeropuertos(id_aeropuerto),
    FOREIGN KEY (id_destino) REFERENCES aeropuertos(id_aeropuerto),
    CHECK (id_origen <> id_destino),
    CHECK (datetime(fecha_llegada) > datetime(fecha_salida))
);

CREATE TABLE reservas (
    id_reserva INTEGER PRIMARY KEY,
    id_vuelo INTEGER NOT NULL,
    nombre_pasajero TEXT NOT NULL,
    documento_pasajero TEXT NOT NULL UNIQUE,
    asiento TEXT NOT NULL,
    fecha_reserva TEXT NOT NULL CHECK (date(fecha_reserva) IS NOT NULL),
    estado TEXT NOT NULL CHECK (
        estado IN ('confirmada', 'pendiente', 'cancelada')
    ),
    FOREIGN KEY (id_vuelo) REFERENCES vuelos(id_vuelo),
    UNIQUE (id_vuelo, asiento)
);

CREATE INDEX idx_vuelos_avion
ON vuelos(id_avion);

CREATE INDEX idx_vuelos_origen
ON vuelos(id_origen);

CREATE INDEX idx_vuelos_destino
ON vuelos(id_destino);

CREATE INDEX idx_vuelos_fecha_salida
ON vuelos(fecha_salida);

CREATE INDEX idx_reservas_vuelo
ON reservas(id_vuelo);