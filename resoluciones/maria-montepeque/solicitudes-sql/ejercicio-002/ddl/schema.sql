PRAGMA foreign_keys = ON;

-- Ejercicio 002: Taller de Motos
-- Modelo minimo: catalogo de motos y registro de ordenes de trabajo.

-- motos: catalogo. placa es UNIQUE porque identifica de forma unica el
-- vehiculo dentro del taller.
CREATE TABLE motos (
    id_moto      INTEGER PRIMARY KEY AUTOINCREMENT,
    placa        TEXT NOT NULL UNIQUE,
    marca        TEXT NOT NULL,
    modelo       TEXT NOT NULL,
    nombre_dueno TEXT NOT NULL
);

-- ordenes_trabajo: tabla principal (transaccional). Responde la pregunta
-- central del cliente: quien (moto/dueno), que (descripcion_servicio),
-- cuando (fecha_orden) y cuanto (costo).
CREATE TABLE ordenes_trabajo (
    id_orden             INTEGER PRIMARY KEY AUTOINCREMENT,
    id_moto              INTEGER NOT NULL,
    descripcion_servicio TEXT NOT NULL,
    mecanico_asignado    TEXT NOT NULL,
    costo                REAL NOT NULL CHECK (costo > 0),
    fecha_orden          TEXT NOT NULL DEFAULT (datetime('now')),
    estado               TEXT NOT NULL DEFAULT 'en_proceso' CHECK (estado IN ('en_proceso', 'completada', 'cancelada')),

    FOREIGN KEY (id_moto) REFERENCES motos (id_moto)
);
