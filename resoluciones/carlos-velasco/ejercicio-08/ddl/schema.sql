PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS citas;
DROP TABLE IF EXISTS consultorios;
DROP TABLE IF EXISTS medicos;
DROP TABLE IF EXISTS pacientes;

-- PACIENTES

CREATE TABLE pacientes (
    id_paciente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    fecha_nacimiento TEXT NOT NULL,
    telefono TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (fecha_nacimiento GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
);

-- MEDICOS

CREATE TABLE medicos (
    id_medico INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    especialidad TEXT NOT NULL,
    registro_profesional TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (length(trim(especialidad)) >= 4)
);

-- CONSULTORIOS

CREATE TABLE consultorios (
    id_consultorio INTEGER PRIMARY KEY,
    numero INTEGER NOT NULL UNIQUE,
    piso INTEGER NOT NULL,
    especialidad TEXT NOT NULL,
    capacidad INTEGER NOT NULL DEFAULT 1,
    CHECK (numero > 0),
    CHECK (piso > 0),
    CHECK (capacidad BETWEEN 1 AND 10)
);

-- CITAS

CREATE TABLE citas (
    id_cita INTEGER PRIMARY KEY,
    id_paciente INTEGER NOT NULL,
    id_medico INTEGER NOT NULL,
    id_consultorio INTEGER NOT NULL,
    fecha_hora TEXT NOT NULL,
    motivo TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Programada',
    CHECK (fecha_hora GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'),
    CHECK (estado IN ('Programada', 'Confirmada', 'Atendida', 'Cancelada')),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico),
    FOREIGN KEY (id_consultorio) REFERENCES consultorios(id_consultorio),
    UNIQUE (id_medico, fecha_hora),
    UNIQUE (id_consultorio, fecha_hora)
);

CREATE INDEX idx_citas_fecha_hora
ON citas(fecha_hora);

CREATE INDEX idx_citas_paciente
ON citas(id_paciente);

CREATE INDEX idx_citas_medico
ON citas(id_medico);