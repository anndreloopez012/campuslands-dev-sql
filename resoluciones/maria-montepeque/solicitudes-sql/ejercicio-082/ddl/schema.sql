PRAGMA foreign_keys = ON;

-- Ejercicio 082: Academia Kickboxing
-- Modelo: alumnos + entrenadores -> asistencias (1:N cada una);
-- alumnos + planes -> pagos (1:N cada una).

CREATE TABLE alumnos (
    id_alumno      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_alumno  TEXT NOT NULL,
    telefono       TEXT NOT NULL UNIQUE
);

CREATE TABLE planes (
    id_plan              INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_plan          TEXT NOT NULL UNIQUE,
    precio_mensual       REAL NOT NULL CHECK (precio_mensual >= 0),
    clases_por_semana    INTEGER NOT NULL CHECK (clases_por_semana > 0)
);

CREATE TABLE entrenadores (
    id_entrenador       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_entrenador   TEXT NOT NULL UNIQUE,
    especialidad        TEXT NOT NULL
);

-- asistencias: el UNIQUE compuesto impide registrar la misma
-- asistencia dos veces (mismo alumno, mismo entrenador, misma fecha).
CREATE TABLE asistencias (
    id_asistencia    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_alumno        INTEGER NOT NULL,
    id_entrenador    INTEGER NOT NULL,
    fecha_clase      TEXT NOT NULL,

    FOREIGN KEY (id_alumno) REFERENCES alumnos (id_alumno),
    FOREIGN KEY (id_entrenador) REFERENCES entrenadores (id_entrenador),
    UNIQUE (id_alumno, id_entrenador, fecha_clase)
);

-- pagos: responde directamente la solicitud del cliente (quien pago,
-- que plan, cuando y cuanto).
CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_alumno     INTEGER NOT NULL,
    id_plan       INTEGER NOT NULL,
    monto         REAL NOT NULL CHECK (monto >= 0),
    fecha_pago    TEXT NOT NULL DEFAULT (date('now')),
    estado        TEXT NOT NULL DEFAULT 'pendiente'
                      CHECK (estado IN ('pendiente', 'pagado', 'vencido')),

    FOREIGN KEY (id_alumno) REFERENCES alumnos (id_alumno),
    FOREIGN KEY (id_plan) REFERENCES planes (id_plan)
);

-- Vista SQL (requerida en nivel 5): responde literalmente la
-- pregunta del cliente en una sola consulta legible, sin repetir el
-- JOIN de 3 tablas cada vez.
CREATE VIEW vista_pagos_alumnos AS
    SELECT
        pg.id_pago,
        al.nombre_alumno,
        pl.nombre_plan,
        pg.monto,
        pg.fecha_pago,
        pg.estado
    FROM pagos pg
    JOIN alumnos al ON al.id_alumno = pg.id_alumno
    JOIN planes pl ON pl.id_plan = pg.id_plan;
