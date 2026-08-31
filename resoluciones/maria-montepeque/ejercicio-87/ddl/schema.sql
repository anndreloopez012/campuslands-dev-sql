PRAGMA foreign_keys = ON;

-- Ejercicio 87: ORDER BY Nivel Intermedio
-- Tema central: ORDER BY
-- Contexto: agenda de citas medicas por fecha.

CREATE TABLE medicos (
    id_medico      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_medico  TEXT NOT NULL UNIQUE,
    especialidad   TEXT NOT NULL
);

CREATE TABLE pacientes (
    id_paciente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_paciente TEXT NOT NULL,
    telefono        TEXT NOT NULL UNIQUE
);

CREATE TABLE citas (
    id_cita       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente   INTEGER NOT NULL,
    id_medico     INTEGER NOT NULL,
    fecha_cita    TEXT NOT NULL,
    hora_cita     TEXT NOT NULL,
    estado        TEXT NOT NULL DEFAULT 'programada'
                      CHECK (estado IN ('programada', 'atendida', 'cancelada')),

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
);
