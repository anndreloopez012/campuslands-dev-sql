PRAGMA foreign_keys = ON;

-- Ejercicio 20: Eventos Boletos
-- Modelo: lugares, eventos, asistentes, boletos

CREATE TABLE lugares (
    id_lugar    INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE,
    ciudad      TEXT NOT NULL,
    capacidad   INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE eventos (
    id_evento     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_lugar      INTEGER NOT NULL,
    nombre        TEXT NOT NULL,
    fecha         TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'
    precio_base   REAL NOT NULL CHECK (precio_base > 0),

    FOREIGN KEY (id_lugar) REFERENCES lugares (id_lugar)
);

CREATE TABLE asistentes (
    id_asistente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL,
    correo        TEXT NOT NULL UNIQUE
);

CREATE TABLE boletos (
    id_boleto       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_evento       INTEGER NOT NULL,
    id_asistente    INTEGER NOT NULL,
    precio          REAL NOT NULL CHECK (precio > 0),
    estado          TEXT NOT NULL CHECK (estado IN ('vendido', 'reservado', 'cancelado')),
    fecha_compra    TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_evento) REFERENCES eventos (id_evento),
    FOREIGN KEY (id_asistente) REFERENCES asistentes (id_asistente)
);
