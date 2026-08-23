PRAGMA foreign_keys = ON;

-- Ejercicio 39: Normalizacion Recursos Humanos
-- Modelo normalizado (3FN): empleados, cargos, departamentos, beneficios,
-- contratos, asignaciones (tabla puente contratos<->beneficios)

CREATE TABLE empleados (
    id_empleado  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL UNIQUE
);

CREATE TABLE cargos (
    id_cargo  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre    TEXT NOT NULL UNIQUE
);

CREATE TABLE departamentos (
    id_departamento  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre           TEXT NOT NULL UNIQUE
);

CREATE TABLE beneficios (
    id_beneficio  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL UNIQUE
);

-- El jefe tambien es un empleado (auto-referencia a empleados). Puede ser
-- NULL para el cargo mas alto de la organizacion, que no reporta a nadie.
CREATE TABLE contratos (
    id_contrato       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_empleado       INTEGER NOT NULL,
    id_cargo          INTEGER NOT NULL,
    id_departamento   INTEGER NOT NULL,
    id_jefe           INTEGER,   -- NULL si no reporta a nadie
    salario           REAL NOT NULL CHECK (salario > 0),
    fecha_contrato    TEXT NOT NULL CHECK (fecha_contrato GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),  -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado),
    FOREIGN KEY (id_cargo) REFERENCES cargos (id_cargo),
    FOREIGN KEY (id_departamento) REFERENCES departamentos (id_departamento),
    FOREIGN KEY (id_jefe) REFERENCES empleados (id_empleado),
    UNIQUE (id_empleado, fecha_contrato)
);

-- Tabla puente: un contrato puede tener varios beneficios y un beneficio
-- puede aplicar a varios contratos (relacion N:M).
CREATE TABLE asignaciones (
    id_asignacion  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_contrato    INTEGER NOT NULL,
    id_beneficio   INTEGER NOT NULL,

    FOREIGN KEY (id_contrato) REFERENCES contratos (id_contrato),
    FOREIGN KEY (id_beneficio) REFERENCES beneficios (id_beneficio),
    UNIQUE (id_contrato, id_beneficio)
);
