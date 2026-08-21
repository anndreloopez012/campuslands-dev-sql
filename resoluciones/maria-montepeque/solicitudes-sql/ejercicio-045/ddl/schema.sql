PRAGMA foreign_keys = ON;

-- Ejercicio 045: Soldadura Industrial
-- Modelo: clientes + tecnicos -> ordenes (doble FOREIGN KEY), y
-- ordenes -> materiales (1:N). 4 tablas en total.

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    telefono       TEXT NOT NULL
);

CREATE TABLE tecnicos (
    id_tecnico     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_tecnico TEXT NOT NULL UNIQUE,
    certificacion  TEXT NOT NULL CHECK (certificacion IN ('basica', 'avanzada', 'estructural'))
);

-- ordenes: tabla principal. 'inspeccion' es un estado mas del
-- proceso, no una tabla aparte (ver supuestos).
CREATE TABLE ordenes (
    id_orden      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    id_tecnico    INTEGER NOT NULL,
    descripcion   TEXT NOT NULL,
    fecha_orden   TEXT NOT NULL,
    costo_total   REAL NOT NULL CHECK (costo_total > 0),
    estado        TEXT NOT NULL DEFAULT 'recibida' CHECK (estado IN ('recibida', 'en_proceso', 'inspeccion', 'entregada', 'rechazada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_tecnico) REFERENCES tecnicos (id_tecnico)
);

CREATE TABLE materiales (
    id_material     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_orden        INTEGER NOT NULL,
    nombre_material TEXT NOT NULL,
    cantidad        REAL NOT NULL CHECK (cantidad > 0),
    costo_unitario  REAL NOT NULL CHECK (costo_unitario > 0),

    FOREIGN KEY (id_orden) REFERENCES ordenes (id_orden)
);
