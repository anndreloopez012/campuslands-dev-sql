PRAGMA foreign_keys = ON;

-- Ejercicio 083: Viajes y Paracaidismo
-- Modelo: clientes + experiencias + instructores -> reservas (1:N
-- cada una); reservas -> pagos (1:1).

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente  TEXT NOT NULL,
    telefono        TEXT NOT NULL UNIQUE
);

CREATE TABLE experiencias (
    id_experiencia       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_experiencia   TEXT NOT NULL UNIQUE,
    tipo                 TEXT NOT NULL CHECK (tipo IN ('paracaidismo', 'tour', 'buceo')),
    precio               REAL NOT NULL CHECK (precio >= 0)
);

CREATE TABLE instructores (
    id_instructor      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_instructor  TEXT NOT NULL UNIQUE,
    certificacion      TEXT NOT NULL
);

-- reservas: el UNIQUE compuesto impide registrar la misma reserva dos
-- veces (mismo cliente, misma experiencia, misma fecha), que es
-- exactamente el problema de registros incompletos/duplicados que
-- describio el cliente.
CREATE TABLE reservas (
    id_reserva        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente        INTEGER NOT NULL,
    id_experiencia    INTEGER NOT NULL,
    id_instructor     INTEGER NOT NULL,
    fecha_reserva     TEXT NOT NULL,
    estado            TEXT NOT NULL DEFAULT 'programada'
                          CHECK (estado IN ('programada', 'confirmada', 'realizada', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_experiencia) REFERENCES experiencias (id_experiencia),
    FOREIGN KEY (id_instructor) REFERENCES instructores (id_instructor),
    UNIQUE (id_cliente, id_experiencia, fecha_reserva)
);

-- pagos: el UNIQUE sobre id_reserva garantiza como maximo un pago
-- oficial por reserva.
CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva    INTEGER NOT NULL UNIQUE,
    monto         REAL NOT NULL CHECK (monto >= 0),
    metodo_pago   TEXT NOT NULL CHECK (metodo_pago IN ('tarjeta', 'transferencia')),
    fecha_pago    TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva)
);

-- Vista SQL (requerida en nivel 5): resumen legible de cada reserva,
-- con LEFT JOIN a pagos para que una reserva sin pago todavia siga
-- siendo visible (monto_pagado = NULL) en vez de desaparecer del
-- reporte, evitando reportes poco confiables.
CREATE VIEW vista_resumen_reservas AS
    SELECT
        r.id_reserva,
        c.nombre_cliente,
        e.nombre_experiencia,
        e.tipo,
        i.nombre_instructor,
        r.fecha_reserva,
        r.estado,
        p.monto AS monto_pagado
    FROM reservas r
    JOIN clientes c ON c.id_cliente = r.id_cliente
    JOIN experiencias e ON e.id_experiencia = r.id_experiencia
    JOIN instructores i ON i.id_instructor = r.id_instructor
    LEFT JOIN pagos p ON p.id_reserva = r.id_reserva;
