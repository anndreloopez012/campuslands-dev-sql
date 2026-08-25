PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS contratos;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS cargos;
DROP TABLE IF EXISTS departamentos;

CREATE TABLE departamentos (
    id_departamento INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    ubicacion TEXT NOT NULL
);

CREATE TABLE cargos (
    id_cargo INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    salario_base REAL NOT NULL CHECK (salario_base > 0)
);

CREATE TABLE empleados (
    id_empleado INTEGER PRIMARY KEY,
    id_departamento INTEGER NOT NULL,
    id_cargo INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    dpi TEXT NOT NULL UNIQUE,
    correo TEXT NOT NULL UNIQUE,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento),
    FOREIGN KEY (id_cargo) REFERENCES cargos(id_cargo)
);

CREATE TABLE contratos (
    id_contrato INTEGER PRIMARY KEY,
    id_empleado INTEGER NOT NULL,
    fecha_inicio TEXT NOT NULL CHECK (date(fecha_inicio) IS NOT NULL),
    fecha_fin TEXT,
    tipo TEXT NOT NULL CHECK (tipo IN ('FIJO','INDEFINIDO','TEMPORAL')),
    salario REAL NOT NULL CHECK (salario > 0),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

CREATE INDEX idx_empleados_departamento
ON empleados(id_departamento);

CREATE INDEX idx_empleados_cargo
ON empleados(id_cargo);

CREATE INDEX idx_contratos_empleado
ON contratos(id_empleado);