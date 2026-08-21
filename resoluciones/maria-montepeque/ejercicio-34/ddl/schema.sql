PRAGMA foreign_keys = ON;

-- Ejercicio 34: Normalizacion Clinica Tratamientos
-- Modelo normalizado (3FN): pacientes, especialidades, medicos, consultas, tratamientos

CREATE TABLE pacientes (
    id_paciente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    dpi          TEXT NOT NULL UNIQUE
);

CREATE TABLE especialidades (
    id_especialidad  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre           TEXT NOT NULL UNIQUE
);

-- La especialidad es un atributo del medico (cada medico atiende siempre la
-- misma especialidad), no de la consulta: se referencia por FK para eliminar
-- la dependencia transitiva especialidad -> medico -> id_consulta.
CREATE TABLE medicos (
    id_medico        INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre           TEXT NOT NULL UNIQUE,
    id_especialidad  INTEGER NOT NULL,

    FOREIGN KEY (id_especialidad) REFERENCES especialidades (id_especialidad)
);

-- Encabezado de consulta: un paciente atendido por un medico en una fecha.
CREATE TABLE consultas (
    id_consulta      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente      INTEGER NOT NULL,
    id_medico        INTEGER NOT NULL,
    fecha_consulta   TEXT NOT NULL CHECK (fecha_consulta GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),  -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico),
    UNIQUE (id_paciente, id_medico, fecha_consulta)
);

-- Detalle transaccional: cada tratamiento aplicado dentro de una consulta,
-- con el costo cobrado por ese tratamiento en esa consulta.
CREATE TABLE tratamientos (
    id_tratamiento  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_consulta     INTEGER NOT NULL,
    nombre          TEXT NOT NULL CHECK (length(nombre) > 0),
    costo           REAL NOT NULL CHECK (costo > 0),

    FOREIGN KEY (id_consulta) REFERENCES consultas (id_consulta),
    UNIQUE (id_consulta, nombre)
);
