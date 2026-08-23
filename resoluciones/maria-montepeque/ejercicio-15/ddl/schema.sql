PRAGMA foreign_keys = ON;

-- Ejercicio 15: Taller de Motos
-- Modelo: clientes, motos, servicios, ordenes_servicio

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    telefono    TEXT NOT NULL UNIQUE,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE motos (
    id_moto     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente  INTEGER NOT NULL,
    placa       TEXT NOT NULL UNIQUE,
    marca       TEXT NOT NULL,
    anio        INTEGER NOT NULL CHECK (anio >= 1980),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE servicios (
    id_servicio  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL UNIQUE,
    precio       REAL NOT NULL CHECK (precio > 0)
);

CREATE TABLE ordenes_servicio (
    id_orden     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_moto      INTEGER NOT NULL,
    id_servicio  INTEGER NOT NULL,
    fecha        TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    estado       TEXT NOT NULL CHECK (estado IN ('pendiente', 'en_proceso', 'completado', 'cancelado')),
    costo        REAL NOT NULL CHECK (costo > 0),

    FOREIGN KEY (id_moto) REFERENCES motos (id_moto),
    FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio)
);
