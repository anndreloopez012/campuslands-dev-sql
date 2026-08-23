PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS citas;
DROP TABLE IF EXISTS pacientes;
DROP TABLE IF EXISTS medicos;
DROP TABLE IF EXISTS consultorios;

CREATE TABLE pacientes (
    id_paciente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    fecha_nacimiento TEXT NOT NULL,
    telefono TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'ACTIVO',
    CHECK (estado IN ('ACTIVO', 'INACTIVO')),
    CHECK (length(telefono) >= 8)
);

CREATE TABLE medicos (
    id_medico INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    licencia TEXT NOT NULL UNIQUE,
    especialidad TEXT NOT NULL,
    telefono TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'ACTIVO',
    CHECK (estado IN ('ACTIVO', 'INACTIVO')),
    CHECK (length(telefono) >= 8)
);

CREATE TABLE consultorios (
    id_consultorio INTEGER PRIMARY KEY,
    numero INTEGER NOT NULL UNIQUE,
    piso INTEGER NOT NULL,
    especialidad TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'DISPONIBLE',
    CHECK (numero > 0),
    CHECK (piso > 0),
    CHECK (estado IN ('DISPONIBLE', 'OCUPADO', 'MANTENIMIENTO'))
);

CREATE TABLE citas (
    id_cita INTEGER PRIMARY KEY,
    id_paciente INTEGER NOT NULL,
    id_medico INTEGER NOT NULL,
    id_consultorio INTEGER NOT NULL,
    fecha_hora TEXT NOT NULL,
    motivo TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'PROGRAMADA',
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico),
    FOREIGN KEY (id_consultorio) REFERENCES consultorios(id_consultorio),
    UNIQUE (id_medico, fecha_hora),
    UNIQUE (id_consultorio, fecha_hora),
    CHECK (estado IN ('PROGRAMADA', 'ATENDIDA', 'CANCELADA')),
    CHECK (length(motivo) >= 5)
);