PRAGMA foreign_keys = ON;

-- Ejercicio 033: Viajes y Paracaidismo
-- Modelo: dos catalogos independientes (experiencias, clientes) que
-- alimentan una tabla de movimientos (reservas) con dos FOREIGN KEY.

CREATE TABLE experiencias (
    id_experiencia      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_experiencia  TEXT NOT NULL UNIQUE,
    tipo                TEXT NOT NULL CHECK (tipo IN ('viaje', 'paracaidismo', 'turismo')),
    precio              REAL NOT NULL CHECK (precio > 0)
);

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    telefono       TEXT NOT NULL
);

-- reservas: tabla principal. NOT NULL en los campos que, si faltaran,
-- romperian un reporte confiable (la queja central del cliente).
CREATE TABLE reservas (
    id_reserva      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_experiencia  INTEGER NOT NULL,
    id_cliente      INTEGER NOT NULL,
    fecha_reserva   TEXT NOT NULL DEFAULT (date('now')),
    monto_pagado    REAL NOT NULL CHECK (monto_pagado > 0),
    estado          TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'confirmada', 'completada', 'cancelada')),

    FOREIGN KEY (id_experiencia) REFERENCES experiencias (id_experiencia),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);
