PRAGMA foreign_keys = ON;

-- Ejercicio 027: Taller de Motos
-- Modelo: clientes -> motos (1:N) -> ordenes_servicio (1:N).

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    telefono       TEXT NOT NULL
);

CREATE TABLE motos (
    id_moto     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente  INTEGER NOT NULL,
    placa       TEXT NOT NULL UNIQUE,
    marca       TEXT NOT NULL,
    modelo      TEXT NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- ordenes_servicio: tabla principal. estado permite corregir la
-- situacion de una orden sin borrar su registro, tal como pidio el
-- cliente explicitamente.
CREATE TABLE ordenes_servicio (
    id_orden             INTEGER PRIMARY KEY AUTOINCREMENT,
    id_moto              INTEGER NOT NULL,
    descripcion_servicio TEXT NOT NULL,
    mecanico_asignado    TEXT NOT NULL,
    costo                REAL NOT NULL CHECK (costo > 0),
    fecha_orden          TEXT NOT NULL DEFAULT (datetime('now')),
    estado               TEXT NOT NULL DEFAULT 'en_proceso' CHECK (estado IN ('en_proceso', 'completada', 'cancelada')),

    FOREIGN KEY (id_moto) REFERENCES motos (id_moto)
);
