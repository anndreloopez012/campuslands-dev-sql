PRAGMA foreign_keys = ON;

-- Ejercicio 006: Renta Autos de Lujo
-- Modelo minimo: catalogo de vehiculos (permanente) y registro de
-- reservas (movimientos), separados a proposito segun pidio el cliente.

-- vehiculos: catalogo permanente. placa es UNIQUE porque identifica de
-- forma unica cada auto.
CREATE TABLE vehiculos (
    id_vehiculo INTEGER PRIMARY KEY AUTOINCREMENT,
    marca       TEXT NOT NULL,
    modelo      TEXT NOT NULL,
    placa       TEXT NOT NULL UNIQUE,
    precio_dia  REAL NOT NULL CHECK (precio_dia > 0),
    estado      TEXT NOT NULL DEFAULT 'disponible' CHECK (estado IN ('disponible', 'rentado', 'mantenimiento'))
);

-- reservas: tabla principal (movimiento/transaccional). estado.reservas es
-- independiente de estado.vehiculos: uno describe el avance de un
-- alquiler puntual, el otro la disponibilidad actual del auto.
CREATE TABLE reservas (
    id_reserva     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vehiculo    INTEGER NOT NULL,
    nombre_cliente TEXT NOT NULL,
    fecha_inicio   TEXT NOT NULL,
    fecha_fin      TEXT NOT NULL,
    monto_total    REAL NOT NULL CHECK (monto_total > 0),
    estado         TEXT NOT NULL DEFAULT 'confirmada' CHECK (estado IN ('confirmada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo)
);
