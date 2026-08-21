PRAGMA foreign_keys = ON;

-- Ejercicio 015: Laboratorio Quimico
-- Modelo minimo: catalogo de reactivos y registro de muestras.

CREATE TABLE reactivos (
    id_reactivo      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_reactivo  TEXT NOT NULL UNIQUE,
    unidad_medida    TEXT NOT NULL CHECK (unidad_medida IN ('ml', 'g', 'mol', 'L')),
    stock_disponible REAL NOT NULL DEFAULT 0 CHECK (stock_disponible >= 0)
);

-- muestras: tabla principal. resultado se deja sin NOT NULL a proposito:
-- una muestra en analisis todavia no tiene resultado.
CREATE TABLE muestras (
    id_muestra     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reactivo    INTEGER NOT NULL,
    codigo_muestra TEXT NOT NULL UNIQUE,
    fecha_analisis TEXT NOT NULL DEFAULT (date('now')),
    resultado      TEXT,
    estado         TEXT NOT NULL DEFAULT 'en_analisis' CHECK (estado IN ('en_analisis', 'completado', 'contaminada')),

    FOREIGN KEY (id_reactivo) REFERENCES reactivos (id_reactivo)
);
