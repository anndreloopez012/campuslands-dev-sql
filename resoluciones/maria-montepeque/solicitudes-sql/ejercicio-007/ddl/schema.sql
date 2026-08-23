PRAGMA foreign_keys = ON;

-- Ejercicio 007: Academia Kickboxing
-- Modelo minimo: catalogo de planes y registro de alumnos.

CREATE TABLE planes (
    id_plan           INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_plan       TEXT NOT NULL UNIQUE,
    precio_mensual    REAL NOT NULL CHECK (precio_mensual > 0),
    clases_por_semana INTEGER NOT NULL CHECK (clases_por_semana > 0)
);

-- alumnos: tabla principal. estado permite corregir la situacion de un
-- alumno (suspendido, inactivo, graduado) sin borrar su registro, tal
-- como pidio el cliente explicitamente.
CREATE TABLE alumnos (
    id_alumno         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_plan           INTEGER NOT NULL,
    nombre_completo   TEXT NOT NULL,
    fecha_inscripcion TEXT NOT NULL DEFAULT (date('now')),
    estado            TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'suspendido', 'inactivo', 'graduado')),

    FOREIGN KEY (id_plan) REFERENCES planes (id_plan)
);
