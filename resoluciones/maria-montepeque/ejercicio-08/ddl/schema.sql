PRAGMA foreign_keys = ON;

-- Ejercicio 08: Clinica de Citas
-- Modelo: pacientes, medicos, consultorios, citas

CREATE TABLE pacientes (
    id_paciente   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL,
    correo        TEXT NOT NULL UNIQUE,
    telefono      TEXT
);

CREATE TABLE medicos (
    id_medico       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre          TEXT NOT NULL,
    especialidad    TEXT NOT NULL,
    colegiado       TEXT NOT NULL UNIQUE
);

CREATE TABLE consultorios (
    id_consultorio    INTEGER PRIMARY KEY AUTOINCREMENT,
    numero            INTEGER NOT NULL UNIQUE,
    piso              INTEGER NOT NULL CHECK (piso > 0)
);

CREATE TABLE citas (
    id_cita           INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente       INTEGER NOT NULL,
    id_medico         INTEGER NOT NULL,
    id_consultorio    INTEGER NOT NULL,
    fecha_hora        TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'
    estado            TEXT NOT NULL DEFAULT 'programada' CHECK (estado IN ('programada', 'atendida', 'cancelada')),

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico),
    FOREIGN KEY (id_consultorio) REFERENCES consultorios (id_consultorio),
    UNIQUE (id_medico, fecha_hora)
);
