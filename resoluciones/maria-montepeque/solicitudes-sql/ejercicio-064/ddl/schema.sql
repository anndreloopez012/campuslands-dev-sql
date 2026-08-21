PRAGMA foreign_keys = ON;

-- Ejercicio 064: Mecanica de Autos
-- Modelo: clientes, vehiculos, diagnosticos, reparaciones, repuestos

CREATE TABLE clientes (
    id_cliente   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    telefono     TEXT NOT NULL UNIQUE
);

CREATE TABLE vehiculos (
    id_vehiculo   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    placa         TEXT NOT NULL UNIQUE,
    marca         TEXT NOT NULL,
    modelo        TEXT NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE diagnosticos (
    id_diagnostico       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vehiculo          INTEGER NOT NULL,
    fecha_diagnostico    TEXT NOT NULL DEFAULT (date('now')),
    descripcion          TEXT NOT NULL,
    estado               TEXT NOT NULL DEFAULT 'pendiente'
                             CHECK (estado IN ('pendiente', 'en_reparacion', 'finalizado')),

    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo)
);

CREATE TABLE reparaciones (
    id_reparacion          INTEGER PRIMARY KEY AUTOINCREMENT,
    -- UNIQUE: cada diagnostico deriva en, a lo sumo, una reparacion.
    id_diagnostico         INTEGER NOT NULL UNIQUE,
    descripcion_trabajo    TEXT NOT NULL,
    costo_mano_obra        REAL NOT NULL CHECK (costo_mano_obra > 0),
    fecha_reparacion       TEXT NOT NULL DEFAULT (date('now')),

    FOREIGN KEY (id_diagnostico) REFERENCES diagnosticos (id_diagnostico)
);

CREATE TABLE repuestos (
    id_repuesto        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reparacion      INTEGER NOT NULL,
    nombre             TEXT NOT NULL,
    cantidad           INTEGER NOT NULL DEFAULT 1 CHECK (cantidad > 0),
    precio_unitario    REAL NOT NULL CHECK (precio_unitario > 0),

    FOREIGN KEY (id_reparacion) REFERENCES reparaciones (id_reparacion)
);
