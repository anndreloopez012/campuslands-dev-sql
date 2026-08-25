PRAGMA foreign_keys = ON;

-- Ejercicio 081: Renta Autos de Lujo
-- Modelo: clientes -> reservas (1:N); vehiculos -> reservas (1:N);
-- reservas -> pagos (1:1); reservas -> inspecciones (1:N, maximo 2:
-- entrega y devolucion).

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente  TEXT NOT NULL,
    licencia        TEXT NOT NULL UNIQUE,
    telefono        TEXT NOT NULL UNIQUE
);

CREATE TABLE vehiculos (
    id_vehiculo      INTEGER PRIMARY KEY AUTOINCREMENT,
    modelo           TEXT NOT NULL,
    placa            TEXT NOT NULL UNIQUE,
    categoria        TEXT NOT NULL CHECK (categoria IN ('deportivo', 'lujo', 'convertible')),
    tarifa_diaria    REAL NOT NULL CHECK (tarifa_diaria >= 0)
);

CREATE TABLE reservas (
    id_reserva      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente      INTEGER NOT NULL,
    id_vehiculo     INTEGER NOT NULL,
    fecha_inicio    TEXT NOT NULL,
    fecha_fin       TEXT NOT NULL,
    estado          TEXT NOT NULL DEFAULT 'reservada'
                        CHECK (estado IN ('reservada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo),
    CHECK (fecha_fin > fecha_inicio)
);

-- pagos: el UNIQUE sobre id_reserva ataca directamente el problema
-- que describio el cliente (pagos duplicados en la hoja de calculo).
CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva    INTEGER NOT NULL UNIQUE,
    monto         REAL NOT NULL CHECK (monto >= 0),
    metodo_pago   TEXT NOT NULL CHECK (metodo_pago IN ('tarjeta', 'transferencia')),
    fecha_pago    TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva)
);

-- inspecciones: el UNIQUE compuesto impide cargar dos veces la misma
-- inspeccion (entrega o devolucion) para la misma reserva.
CREATE TABLE inspecciones (
    id_inspeccion       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva          INTEGER NOT NULL,
    tipo_inspeccion      TEXT NOT NULL CHECK (tipo_inspeccion IN ('entrega', 'devolucion')),
    estado_vehiculo      TEXT NOT NULL,
    fecha_inspeccion     TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva),
    UNIQUE (id_reserva, tipo_inspeccion)
);

-- Vista SQL (requerida en nivel 5): resumen legible de cada reserva
-- con su cliente, su vehiculo y su pago (si ya existe). Evita repetir
-- el mismo JOIN de 4 tablas cada vez que se necesita este reporte.
CREATE VIEW vista_resumen_reservas AS
    SELECT
        r.id_reserva,
        c.nombre_cliente,
        v.modelo,
        v.categoria,
        r.fecha_inicio,
        r.fecha_fin,
        r.estado,
        p.monto AS monto_pagado
    FROM reservas r
    JOIN clientes c ON c.id_cliente = r.id_cliente
    JOIN vehiculos v ON v.id_vehiculo = r.id_vehiculo
    LEFT JOIN pagos p ON p.id_reserva = r.id_reserva;
