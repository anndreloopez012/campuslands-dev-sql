PRAGMA foreign_keys = ON;

-- Ejercicio 056: Renta Autos de Lujo
-- Modelo organizado en catalogos (clientes, vehiculos), operacion
-- (reservas) y resultados (pagos), tal como pidio el cliente.

-- Catalogo
CREATE TABLE clientes (
    id_cliente         INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente     TEXT NOT NULL UNIQUE,
    licencia_conducir  TEXT NOT NULL UNIQUE
);

-- Catalogo
CREATE TABLE vehiculos (
    id_vehiculo    INTEGER PRIMARY KEY AUTOINCREMENT,
    placa          TEXT NOT NULL UNIQUE,
    modelo         TEXT NOT NULL,
    tarifa_diaria  REAL NOT NULL CHECK (tarifa_diaria > 0)
);

-- Operacion: un movimiento (una reserva sobre un vehiculo).
CREATE TABLE reservas (
    id_reserva     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente     INTEGER NOT NULL,
    id_vehiculo    INTEGER NOT NULL,
    fecha_inicio   TEXT NOT NULL,
    fecha_fin      TEXT NOT NULL,
    estado         TEXT NOT NULL DEFAULT 'confirmada' CHECK (estado IN ('confirmada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo),
    CHECK (fecha_fin > fecha_inicio)
);

-- Resultado: lo que efectivamente se cobro por una reserva.
CREATE TABLE pagos (
    id_pago      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva   INTEGER NOT NULL,
    monto        REAL NOT NULL CHECK (monto > 0),
    fecha_pago   TEXT NOT NULL,
    metodo       TEXT NOT NULL CHECK (metodo IN ('tarjeta', 'efectivo', 'transferencia')),
    estado       TEXT NOT NULL DEFAULT 'completado' CHECK (estado IN ('completado', 'reembolsado')),

    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva)
);
