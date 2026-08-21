PRAGMA foreign_keys = ON;

-- Ejercicio 040: Laboratorio Quimico
-- Modelo: dos catalogos independientes (formulas, reactivos) que
-- alimentan una tabla de movimientos (muestras) con dos FOREIGN KEY.
-- Cada restriccion aqui ataca uno de los tres errores que pidio el
-- cliente detectar: repetidos (UNIQUE), relaciones invalidas
-- (FOREIGN KEY) y valores fuera de rango (CHECK).

CREATE TABLE formulas (
    id_formula     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_formula TEXT NOT NULL UNIQUE,
    tipo           TEXT NOT NULL CHECK (tipo IN ('acida', 'basica', 'neutra'))
);

CREATE TABLE reactivos (
    id_reactivo     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_reactivo TEXT NOT NULL UNIQUE,
    unidad_medida   TEXT NOT NULL CHECK (unidad_medida IN ('ml', 'g', 'mol'))
);

-- muestras: tabla principal. concentracion es un porcentaje (0 a
-- 100); fuera de ese rango la base de datos rechaza el INSERT.
CREATE TABLE muestras (
    id_muestra      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_formula      INTEGER NOT NULL,
    id_reactivo     INTEGER NOT NULL,
    fecha_analisis  TEXT NOT NULL,
    concentracion   REAL NOT NULL CHECK (concentracion > 0 AND concentracion <= 100),
    resultado       TEXT NOT NULL DEFAULT 'pendiente' CHECK (resultado IN ('pendiente', 'valido', 'invalido', 'repetir')),

    FOREIGN KEY (id_formula) REFERENCES formulas (id_formula),
    FOREIGN KEY (id_reactivo) REFERENCES reactivos (id_reactivo)
);
