PRAGMA foreign_keys = ON;

-- Ejercicio 057: Academia Kickboxing
-- Modelo: planes -> alumnos (1:N), y alumnos + entrenadores ->
-- asistencias (doble FOREIGN KEY). 4 tablas en total.

CREATE TABLE planes (
    id_plan             INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_plan         TEXT NOT NULL UNIQUE,
    precio_mensual      REAL NOT NULL CHECK (precio_mensual > 0),
    clases_por_semana   INTEGER NOT NULL CHECK (clases_por_semana > 0)
);

CREATE TABLE entrenadores (
    id_entrenador     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_entrenador TEXT NOT NULL UNIQUE,
    especialidad      TEXT NOT NULL CHECK (especialidad IN ('kickboxing', 'muay_thai', 'boxeo', 'defensa_personal'))
);

CREATE TABLE alumnos (
    id_alumno          INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_alumno      TEXT NOT NULL UNIQUE,
    id_plan            INTEGER NOT NULL,
    fecha_inscripcion  TEXT NOT NULL,
    estado             TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'suspendido', 'inactivo')),

    FOREIGN KEY (id_plan) REFERENCES planes (id_plan)
);

-- asistencias: tabla principal. El estado se corrige con UPDATE
-- (nunca con DELETE), tal como pidio el cliente.
CREATE TABLE asistencias (
    id_asistencia   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_alumno       INTEGER NOT NULL,
    id_entrenador   INTEGER NOT NULL,
    fecha_clase     TEXT NOT NULL,
    estado          TEXT NOT NULL DEFAULT 'presente' CHECK (estado IN ('presente', 'ausente', 'justificada')),

    FOREIGN KEY (id_alumno) REFERENCES alumnos (id_alumno),
    FOREIGN KEY (id_entrenador) REFERENCES entrenadores (id_entrenador)
);
