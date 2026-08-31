PRAGMA foreign_keys = ON;

-- Ejercicio 088: Clinica de Tatuajes
-- Modelo: clientes + artistas + estilos -> sesiones (1:N cada una);
-- sesiones -> pagos (1:1).

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente  TEXT NOT NULL,
    telefono        TEXT NOT NULL UNIQUE
);

CREATE TABLE artistas (
    id_artista      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_artista  TEXT NOT NULL UNIQUE,
    especialidad    TEXT NOT NULL
);

CREATE TABLE estilos (
    id_estilo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_estilo  TEXT NOT NULL UNIQUE,
    dificultad     TEXT NOT NULL CHECK (dificultad IN ('baja', 'media', 'alta'))
);

CREATE TABLE sesiones (
    id_sesion         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente        INTEGER NOT NULL,
    id_artista        INTEGER NOT NULL,
    id_estilo         INTEGER NOT NULL,
    fecha_sesion      TEXT NOT NULL,
    duracion_horas    REAL NOT NULL CHECK (duracion_horas > 0),
    estado            TEXT NOT NULL DEFAULT 'programada'
                          CHECK (estado IN ('programada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista),
    FOREIGN KEY (id_estilo) REFERENCES estilos (id_estilo)
);

-- pagos: el UNIQUE sobre id_sesion garantiza como maximo un pago
-- oficial por sesion.
CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_sesion     INTEGER NOT NULL UNIQUE,
    monto         REAL NOT NULL CHECK (monto >= 0),
    metodo_pago   TEXT NOT NULL CHECK (metodo_pago IN ('efectivo', 'tarjeta')),
    fecha_pago    TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion)
);

-- Vista SQL (requerida en nivel 5): base comun para los rankings,
-- totales y casos pendientes que pidio el cliente, sin repetir el
-- JOIN de 4 tablas cada vez.
CREATE VIEW vista_resumen_sesiones AS
    SELECT
        s.id_sesion,
        cl.nombre_cliente,
        ar.nombre_artista,
        es.nombre_estilo,
        s.fecha_sesion,
        s.duracion_horas,
        s.estado,
        pa.monto AS monto_pagado
    FROM sesiones s
    JOIN clientes cl ON cl.id_cliente = s.id_cliente
    JOIN artistas ar ON ar.id_artista = s.id_artista
    JOIN estilos es ON es.id_estilo = s.id_estilo
    LEFT JOIN pagos pa ON pa.id_sesion = s.id_sesion;
