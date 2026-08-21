PRAGMA foreign_keys = ON;

-- Ejercicio 020: Soldadura Industrial
-- Modelo minimo: catalogo de tecnicos y registro de ordenes de trabajo.

-- tecnicos: catalogo. nombre_tecnico es UNIQUE (evita registros
-- repetidos) y anios_experiencia tiene un CHECK de rango (detecta
-- valores fuera de rango), tal como pidio el cliente.
CREATE TABLE tecnicos (
    id_tecnico        INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_tecnico    TEXT NOT NULL UNIQUE,
    certificacion     TEXT NOT NULL CHECK (certificacion IN ('basica', 'intermedia', 'avanzada')),
    anios_experiencia INTEGER NOT NULL CHECK (anios_experiencia BETWEEN 0 AND 50)
);

-- ordenes: tabla principal. La FOREIGN KEY evita relaciones invalidas, y
-- codigo_orden UNIQUE evita cargar la misma orden dos veces.
CREATE TABLE ordenes (
    id_orden      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_tecnico    INTEGER NOT NULL,
    codigo_orden  TEXT NOT NULL UNIQUE,
    descripcion   TEXT NOT NULL,
    costo         REAL NOT NULL CHECK (costo > 0),
    fecha_orden   TEXT NOT NULL DEFAULT (date('now')),
    estado        TEXT NOT NULL DEFAULT 'en_proceso' CHECK (estado IN ('en_proceso', 'inspeccionada', 'aprobada', 'rechazada')),

    FOREIGN KEY (id_tecnico) REFERENCES tecnicos (id_tecnico)
);
