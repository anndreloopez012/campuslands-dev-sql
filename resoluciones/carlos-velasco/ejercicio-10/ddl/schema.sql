PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS habitaciones;
DROP TABLE IF EXISTS huespedes;

-- HUESPEDES

CREATE TABLE huespedes (
    id_huesped INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL,
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (fecha_registro GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
);

-- HABITACIONES

CREATE TABLE habitaciones (
    id_habitacion INTEGER PRIMARY KEY,
    numero INTEGER NOT NULL UNIQUE,
    tipo TEXT NOT NULL,
    capacidad INTEGER NOT NULL,
    precio_noche REAL NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Disponible',
    CHECK (numero > 0),
    CHECK (capacidad BETWEEN 1 AND 10),
    CHECK (precio_noche > 0),
    CHECK (tipo IN ('Individual', 'Doble', 'Suite', 'Familiar')),
    CHECK (estado IN ('Disponible', 'Mantenimiento', 'Fuera de Servicio'))
);

-- RESERVAS

CREATE TABLE reservas (
    id_reserva INTEGER PRIMARY KEY,
    id_huesped INTEGER NOT NULL,
    id_habitacion INTEGER NOT NULL,
    fecha_entrada TEXT NOT NULL,
    fecha_salida TEXT NOT NULL,
    cantidad_huespedes INTEGER NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Confirmada',
    CHECK (fecha_entrada GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    CHECK (fecha_salida GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    CHECK (fecha_salida > fecha_entrada),
    CHECK (cantidad_huespedes > 0),
    CHECK (estado IN ('Pendiente', 'Confirmada', 'Completada', 'Cancelada')),
    FOREIGN KEY (id_huesped) REFERENCES huespedes(id_huesped),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion),
    UNIQUE (id_habitacion, fecha_entrada)
);

-- PAGOS

CREATE TABLE pagos (
    id_pago INTEGER PRIMARY KEY,
    id_reserva INTEGER NOT NULL,
    fecha_pago TEXT NOT NULL,
    monto REAL NOT NULL,
    metodo_pago TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Completado',
    CHECK (fecha_pago GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    CHECK (monto > 0),
    CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia')),
    CHECK (estado IN ('Pendiente', 'Completado', 'Anulado')),
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva)
);

CREATE INDEX idx_reservas_huesped
ON reservas(id_huesped);

CREATE INDEX idx_reservas_habitacion
ON reservas(id_habitacion);

CREATE INDEX idx_reservas_fecha_entrada
ON reservas(fecha_entrada);

CREATE INDEX idx_pagos_reserva
ON pagos(id_reserva);

CREATE INDEX idx_pagos_fecha
ON pagos(fecha_pago);