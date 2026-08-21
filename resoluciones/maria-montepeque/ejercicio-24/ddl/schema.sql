PRAGMA foreign_keys = ON;

-- Ejercicio 24: Recursos Humanos
-- Modelo: departamentos, cargos, empleados, contratos

CREATE TABLE departamentos (
    id_departamento  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre           TEXT NOT NULL UNIQUE
);

CREATE TABLE cargos (
    id_cargo       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL UNIQUE,
    salario_base   REAL NOT NULL CHECK (salario_base > 0)
);

CREATE TABLE empleados (
    id_empleado       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_departamento   INTEGER NOT NULL,
    id_cargo          INTEGER NOT NULL,
    nombre            TEXT NOT NULL,
    dpi               TEXT NOT NULL UNIQUE,
    fecha_ingreso     TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_departamento) REFERENCES departamentos (id_departamento),
    FOREIGN KEY (id_cargo) REFERENCES cargos (id_cargo)
);

CREATE TABLE contratos (
    id_contrato    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_empleado    INTEGER NOT NULL,
    tipo           TEXT NOT NULL CHECK (tipo IN ('indefinido', 'temporal', 'por_servicios')),
    salario        REAL NOT NULL CHECK (salario > 0),
    fecha_inicio   TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    fecha_fin      TEXT,            -- ISO 'YYYY-MM-DD', puede ser NULL si sigue vigente
    estado         TEXT NOT NULL CHECK (estado IN ('activo', 'finalizado', 'suspendido')),

    FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
);
