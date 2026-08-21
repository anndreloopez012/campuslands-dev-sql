PRAGMA foreign_keys = ON;

-- Ejercicio 014: Mecanica de Autos
-- Modelo minimo: catalogo de vehiculos y registro de reparaciones.

CREATE TABLE vehiculos (
    id_vehiculo  INTEGER PRIMARY KEY AUTOINCREMENT,
    placa        TEXT NOT NULL UNIQUE,
    marca        TEXT NOT NULL,
    modelo       TEXT NOT NULL,
    nombre_dueno TEXT NOT NULL
);

-- reparaciones: tabla principal. Aqui vive el reporte semanal que pide
-- el cliente.
CREATE TABLE reparaciones (
    id_reparacion    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vehiculo      INTEGER NOT NULL,
    diagnostico      TEXT NOT NULL,
    costo            REAL NOT NULL CHECK (costo > 0),
    fecha_reparacion TEXT NOT NULL DEFAULT (datetime('now')),
    garantia_dias    INTEGER NOT NULL DEFAULT 30 CHECK (garantia_dias >= 0),
    estado           TEXT NOT NULL DEFAULT 'en_proceso' CHECK (estado IN ('en_proceso', 'completada', 'cancelada')),

    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo)
);
