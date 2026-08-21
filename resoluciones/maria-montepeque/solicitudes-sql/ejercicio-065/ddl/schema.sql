PRAGMA foreign_keys = ON;

-- Ejercicio 065: Laboratorio Quimico
-- Modelo: tecnicos, formulas, reactivos, muestras, resultados

CREATE TABLE tecnicos (
    id_tecnico     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL,
    especialidad   TEXT NOT NULL
);

CREATE TABLE formulas (
    id_formula     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL UNIQUE,
    descripcion    TEXT NOT NULL
);

CREATE TABLE reactivos (
    id_reactivo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre           TEXT NOT NULL UNIQUE,
    unidad_medida    TEXT NOT NULL CHECK (unidad_medida IN ('ml', 'g', 'mol'))
);

CREATE TABLE muestras (
    id_muestra       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_formula       INTEGER NOT NULL,
    id_reactivo      INTEGER NOT NULL,
    id_tecnico       INTEGER NOT NULL,
    fecha_muestra    TEXT NOT NULL DEFAULT (date('now')),
    estado           TEXT NOT NULL DEFAULT 'pendiente'
                         CHECK (estado IN ('pendiente', 'en_analisis', 'finalizada')),

    FOREIGN KEY (id_formula) REFERENCES formulas (id_formula),
    FOREIGN KEY (id_reactivo) REFERENCES reactivos (id_reactivo),
    FOREIGN KEY (id_tecnico) REFERENCES tecnicos (id_tecnico)
);

CREATE TABLE resultados (
    id_resultado     INTEGER PRIMARY KEY AUTOINCREMENT,
    -- UNIQUE: cada muestra genera, a lo sumo, un resultado (relacion 1:1).
    id_muestra       INTEGER NOT NULL UNIQUE,
    valor_medido     REAL NOT NULL CHECK (valor_medido >= 0),
    unidad           TEXT NOT NULL,
    aprobado         INTEGER NOT NULL DEFAULT 0 CHECK (aprobado IN (0, 1)),

    FOREIGN KEY (id_muestra) REFERENCES muestras (id_muestra)
);
