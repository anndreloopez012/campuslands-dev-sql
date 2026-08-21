PRAGMA foreign_keys = ON;

-- Ejercicio 36: Normalizacion Hotel Reservas
-- Modelo normalizado (3FN): huespedes, habitaciones, servicios, reservas, detalle_servicio

CREATE TABLE huespedes (
    id_huesped  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    documento   TEXT NOT NULL UNIQUE
);

CREATE TABLE habitaciones (
    id_habitacion  INTEGER PRIMARY KEY AUTOINCREMENT,
    numero         TEXT NOT NULL UNIQUE
);

-- Catalogo de servicios con su costo estandar (Desayuno siempre 60, Parqueo
-- siempre 45, etc. en los datos originales).
CREATE TABLE servicios (
    id_servicio  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL UNIQUE,
    costo        REAL NOT NULL CHECK (costo > 0)
);

-- Encabezado de reserva: un huesped ocupando una habitacion. Elena Soto
-- aparece dos veces en el CSV con la misma habitacion pero en fechas de
-- servicio distintas: son dos estadias reales, no una fila duplicada, asi
-- que se mantienen como dos reservas independientes.
CREATE TABLE reservas (
    id_reserva     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_huesped     INTEGER NOT NULL,
    id_habitacion  INTEGER NOT NULL,

    FOREIGN KEY (id_huesped) REFERENCES huespedes (id_huesped),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones (id_habitacion)
);

-- Detalle transaccional: cada servicio consumido dentro de una reserva, con
-- la fecha en que se consumio y el costo cobrado.
CREATE TABLE detalle_servicio (
    id_detalle   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva   INTEGER NOT NULL,
    id_servicio  INTEGER NOT NULL,
    fecha        TEXT NOT NULL CHECK (fecha GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),  -- ISO 'YYYY-MM-DD'
    costo        REAL NOT NULL CHECK (costo > 0),

    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva),
    FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio),
    UNIQUE (id_reserva, id_servicio, fecha)
);
