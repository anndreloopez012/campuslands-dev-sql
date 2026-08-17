PRAGMA foreign_keys = ON;

-- Ejercicio 10: Hotel Reservas
-- Modelo: huespedes, habitaciones, reservas, pagos

CREATE TABLE huespedes (
    id_huesped  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    documento   TEXT NOT NULL UNIQUE,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE habitaciones (
    id_habitacion   INTEGER PRIMARY KEY AUTOINCREMENT,
    numero          INTEGER NOT NULL UNIQUE,
    tipo            TEXT NOT NULL CHECK (tipo IN ('sencilla', 'doble', 'suite')),
    precio_noche    REAL NOT NULL CHECK (precio_noche > 0)
);

CREATE TABLE reservas (
    id_reserva        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_huesped        INTEGER NOT NULL,
    id_habitacion     INTEGER NOT NULL,
    fecha_checkin     TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    fecha_checkout    TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    estado            TEXT NOT NULL DEFAULT 'confirmada' CHECK (estado IN ('confirmada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_huesped) REFERENCES huespedes (id_huesped),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones (id_habitacion),
    CHECK (fecha_checkout > fecha_checkin)
);

CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva    INTEGER NOT NULL,
    monto         REAL NOT NULL CHECK (monto > 0),
    fecha_pago    TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    metodo        TEXT NOT NULL CHECK (metodo IN ('efectivo', 'tarjeta', 'transferencia')),

    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva)
);
