PRAGMA foreign_keys = ON;

-- Ejercicio 032: Academia Kickboxing
-- Modelo: planes -> alumnos (1:N) -> pagos (1:N).

CREATE TABLE planes (
    id_plan        INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_plan    TEXT NOT NULL UNIQUE,
    precio_mensual REAL NOT NULL CHECK (precio_mensual > 0)
);

CREATE TABLE alumnos (
    id_alumno           INTEGER PRIMARY KEY AUTOINCREMENT,
    id_plan             INTEGER NOT NULL,
    nombre_completo     TEXT NOT NULL UNIQUE,
    entrenador_asignado TEXT NOT NULL,

    FOREIGN KEY (id_plan) REFERENCES planes (id_plan)
);

-- pagos: tabla principal. Responde quien (id_alumno), cuando
-- (fecha_pago) y cuanto dinero representa (monto_pagado).
CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_alumno     INTEGER NOT NULL,
    monto_pagado  REAL NOT NULL CHECK (monto_pagado > 0),
    fecha_pago    TEXT NOT NULL DEFAULT (datetime('now')),
    metodo_pago   TEXT NOT NULL CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'transferencia')),
    estado        TEXT NOT NULL DEFAULT 'confirmado' CHECK (estado IN ('confirmado', 'pendiente', 'rechazado')),

    FOREIGN KEY (id_alumno) REFERENCES alumnos (id_alumno)
);
