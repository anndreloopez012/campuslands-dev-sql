PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS boletos;
DROP TABLE IF EXISTS eventos;
DROP TABLE IF EXISTS asistentes;
DROP TABLE IF EXISTS lugares;

CREATE TABLE lugares (
    id_lugar INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    direccion TEXT NOT NULL,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0),
    ciudad TEXT NOT NULL
);

CREATE TABLE eventos (
    id_evento INTEGER PRIMARY KEY,
    id_lugar INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    fecha_evento TEXT NOT NULL CHECK (date(fecha_evento) IS NOT NULL),
    categoria TEXT NOT NULL,
    precio_base REAL NOT NULL CHECK (precio_base >= 0),
    FOREIGN KEY (id_lugar) REFERENCES lugares(id_lugar)
);

CREATE TABLE asistentes (
    id_asistente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    correo TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL
);

CREATE TABLE boletos (
    id_boleto INTEGER PRIMARY KEY,
    id_evento INTEGER NOT NULL,
    id_asistente INTEGER NOT NULL,
    codigo TEXT NOT NULL UNIQUE,
    fecha_compra TEXT NOT NULL CHECK (datetime(fecha_compra) IS NOT NULL),
    precio_pagado REAL NOT NULL CHECK (precio_pagado >= 0),
    estado TEXT NOT NULL CHECK (estado IN ('ACTIVO', 'USADO', 'CANCELADO')),
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento),
    FOREIGN KEY (id_asistente) REFERENCES asistentes(id_asistente)
);

CREATE INDEX idx_eventos_lugar
ON eventos(id_lugar);

CREATE INDEX idx_eventos_fecha
ON eventos(fecha_evento);

CREATE INDEX idx_boletos_evento
ON boletos(id_evento);

CREATE INDEX idx_boletos_asistente
ON boletos(id_asistente);

CREATE INDEX idx_boletos_estado
ON boletos(estado);     