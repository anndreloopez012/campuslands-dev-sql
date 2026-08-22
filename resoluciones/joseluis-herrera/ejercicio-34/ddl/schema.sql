PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS detalle_tratamiento;
DROP TABLE IF EXISTS tratamientos;
DROP TABLE IF EXISTS consultas;
DROP TABLE IF EXISTS medicos;
DROP TABLE IF EXISTS especialidades;
DROP TABLE IF EXISTS pacientes;

CREATE TABLE pacientes (
    id_paciente INTEGER PRIMARY KEY,
    dpi TEXT NOT NULL UNIQUE,
    nombre_completo TEXT NOT NULL,
    fecha_nacimiento TEXT NOT NULL,
    telefono TEXT,
    estado TEXT NOT NULL DEFAULT 'activo',
    CHECK (length(dpi) >= 5),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE especialidades (
    id_especialidad INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE medicos (
    id_medico INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    colegiado TEXT NOT NULL UNIQUE,
    id_especialidad INTEGER NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo',
    FOREIGN KEY (id_especialidad) REFERENCES especialidades(id_especialidad),
    CHECK (length(colegiado) >= 4),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE consultas (
    id_consulta INTEGER PRIMARY KEY,
    id_paciente INTEGER NOT NULL,
    id_medico INTEGER NOT NULL,
    fecha_consulta TEXT NOT NULL,
    diagnostico TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'realizada',
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico),
    CHECK (estado IN ('programada', 'realizada', 'cancelada')),
    UNIQUE (id_paciente, id_medico, fecha_consulta)
);

CREATE TABLE tratamientos (
    id_tratamiento INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    costo REAL NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo',
    CHECK (costo > 0),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE detalle_tratamiento (
    id_consulta INTEGER NOT NULL,
    id_tratamiento INTEGER NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 1,
    indicaciones TEXT NOT NULL,
    PRIMARY KEY (id_consulta, id_tratamiento),
    FOREIGN KEY (id_consulta) REFERENCES consultas(id_consulta),
    FOREIGN KEY (id_tratamiento) REFERENCES tratamientos(id_tratamiento),
    CHECK (cantidad > 0)
);

CREATE INDEX idx_pacientes_nombre
ON pacientes(nombre_completo);

CREATE INDEX idx_medicos_especialidad
ON medicos(id_especialidad);

CREATE INDEX idx_consultas_paciente
ON consultas(id_paciente);

CREATE INDEX idx_consultas_medico
ON consultas(id_medico);

CREATE INDEX idx_consultas_fecha
ON consultas(fecha_consulta);

CREATE INDEX idx_detalle_tratamiento
ON detalle_tratamiento(id_tratamiento);