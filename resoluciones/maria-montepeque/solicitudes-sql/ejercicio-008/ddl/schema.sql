PRAGMA foreign_keys = ON;

-- Ejercicio 008: Viajes y Paracaidismo
-- Modelo minimo: catalogo de experiencias y registro de reservas.

CREATE TABLE experiencias (
    id_experiencia    INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_experiencia TEXT NOT NULL UNIQUE,
    tipo              TEXT NOT NULL CHECK (tipo IN ('viaje', 'paracaidismo', 'turismo')),
    precio            REAL NOT NULL CHECK (precio > 0)
);

-- reservas: tabla principal. El estado permite responder directamente la
-- pregunta de "casos pendientes" que pidio el cliente.
CREATE TABLE reservas (
    id_reserva     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_experiencia INTEGER NOT NULL,
    nombre_cliente TEXT NOT NULL,
    fecha_reserva  TEXT NOT NULL DEFAULT (date('now')),
    monto_pagado   REAL NOT NULL CHECK (monto_pagado > 0),
    estado         TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'confirmada', 'completada', 'cancelada')),

    FOREIGN KEY (id_experiencia) REFERENCES experiencias (id_experiencia)
);
