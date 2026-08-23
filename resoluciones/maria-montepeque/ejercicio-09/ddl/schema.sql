PRAGMA foreign_keys = ON;

-- Ejercicio 09: Gimnasio Membresias
-- Modelo: clientes, planes, membresias, pagos

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE planes (
    id_plan           INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre            TEXT NOT NULL UNIQUE,
    duracion_meses    INTEGER NOT NULL CHECK (duracion_meses > 0),
    precio            REAL NOT NULL CHECK (precio > 0)
);

CREATE TABLE membresias (
    id_membresia    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente      INTEGER NOT NULL,
    id_plan         INTEGER NOT NULL,
    fecha_inicio    TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    fecha_fin       TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    estado          TEXT NOT NULL DEFAULT 'activa' CHECK (estado IN ('activa', 'vencida', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_plan) REFERENCES planes (id_plan)
);

CREATE TABLE pagos (
    id_pago         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_membresia    INTEGER NOT NULL,
    monto           REAL NOT NULL CHECK (monto > 0),
    fecha_pago      TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    metodo          TEXT NOT NULL CHECK (metodo IN ('efectivo', 'tarjeta', 'transferencia')),

    FOREIGN KEY (id_membresia) REFERENCES membresias (id_membresia)
);
