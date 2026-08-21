PRAGMA foreign_keys = ON;

-- Ejercicio 066: Hotel Gamers
-- Modelo: huespedes, habitaciones, eventos (catalogos permanentes) y
-- reservas, consumos (operaciones y movimientos).

CREATE TABLE huespedes (
    id_huesped   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    telefono     TEXT NOT NULL UNIQUE
);

CREATE TABLE habitaciones (
    id_habitacion   INTEGER PRIMARY KEY AUTOINCREMENT,
    numero          TEXT NOT NULL UNIQUE,
    tipo            TEXT NOT NULL CHECK (tipo IN ('individual', 'doble', 'suite_gamer')),
    precio_noche    REAL NOT NULL CHECK (precio_noche > 0)
);

CREATE TABLE eventos (
    id_evento            INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre               TEXT NOT NULL UNIQUE,
    fecha_evento         TEXT NOT NULL,
    costo_inscripcion    REAL NOT NULL CHECK (costo_inscripcion >= 0)
);

-- reservas: operacion (no catalogo), por eso lleva fechas y estado.
CREATE TABLE reservas (
    id_reserva        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_huesped        INTEGER NOT NULL,
    id_habitacion     INTEGER NOT NULL,
    fecha_entrada     TEXT NOT NULL DEFAULT (date('now')),
    fecha_salida      TEXT NOT NULL,
    estado            TEXT NOT NULL DEFAULT 'activa'
                          CHECK (estado IN ('activa', 'finalizada', 'cancelada')),

    CHECK (fecha_salida > fecha_entrada),
    FOREIGN KEY (id_huesped) REFERENCES huespedes (id_huesped),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones (id_habitacion)
);

-- consumos: movimiento asociado a una reserva. id_evento es opcional:
-- solo se llena cuando el consumo es una inscripcion a un torneo.
CREATE TABLE consumos (
    id_consumo        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva        INTEGER NOT NULL,
    id_evento         INTEGER,
    descripcion       TEXT NOT NULL,
    monto             REAL NOT NULL CHECK (monto > 0),
    fecha_consumo     TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva),
    FOREIGN KEY (id_evento) REFERENCES eventos (id_evento)
);
