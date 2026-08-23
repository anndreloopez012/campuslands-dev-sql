PRAGMA foreign_keys = ON;

-- Ejercicio 18: Farmacia Inventario
-- Modelo: laboratorios, medicamentos, compras, ventas

CREATE TABLE laboratorios (
    id_laboratorio  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre          TEXT NOT NULL UNIQUE,
    pais            TEXT NOT NULL
);

CREATE TABLE medicamentos (
    id_medicamento  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_laboratorio  INTEGER NOT NULL,
    nombre          TEXT NOT NULL UNIQUE,
    precio_venta    REAL NOT NULL CHECK (precio_venta > 0),
    stock           INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),

    FOREIGN KEY (id_laboratorio) REFERENCES laboratorios (id_laboratorio)
);

CREATE TABLE compras (
    id_compra         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_medicamento    INTEGER NOT NULL,
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario   REAL NOT NULL CHECK (precio_unitario > 0),
    fecha             TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_medicamento) REFERENCES medicamentos (id_medicamento)
);

CREATE TABLE ventas (
    id_venta          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_medicamento    INTEGER NOT NULL,
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario   REAL NOT NULL CHECK (precio_unitario > 0),
    fecha             TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_medicamento) REFERENCES medicamentos (id_medicamento)
);
