PRAGMA foreign_keys = ON;

-- Ejercicio 016: Hotel Gamers
-- Modelo minimo: catalogo de habitaciones (permanente) y registro de
-- reservas (movimientos), separados a proposito segun pidio el cliente.

CREATE TABLE habitaciones (
    id_habitacion     INTEGER PRIMARY KEY AUTOINCREMENT,
    numero_habitacion TEXT NOT NULL UNIQUE,
    tipo              TEXT NOT NULL CHECK (tipo IN ('individual', 'doble', 'suite_gamer')),
    precio_noche      REAL NOT NULL CHECK (precio_noche > 0),
    estado            TEXT NOT NULL DEFAULT 'disponible' CHECK (estado IN ('disponible', 'ocupada', 'mantenimiento'))
);

-- reservas: tabla principal (movimiento/transaccional). estado.reservas
-- es independiente de estado.habitaciones: uno describe el avance de una
-- estadia puntual, el otro la disponibilidad fisica actual del cuarto.
CREATE TABLE reservas (
    id_reserva     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_habitacion  INTEGER NOT NULL,
    nombre_huesped TEXT NOT NULL,
    fecha_entrada  TEXT NOT NULL,
    fecha_salida   TEXT NOT NULL,
    monto_total    REAL NOT NULL CHECK (monto_total > 0),
    estado         TEXT NOT NULL DEFAULT 'confirmada' CHECK (estado IN ('confirmada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_habitacion) REFERENCES habitaciones (id_habitacion)
);
