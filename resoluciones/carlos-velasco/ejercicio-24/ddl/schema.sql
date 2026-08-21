PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS contratos;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS cargos;
DROP TABLE IF EXISTS departamentos;

-- DEPARTAMENTOS

CREATE TABLE departamentos (
    id_departamento INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    presupuesto_anual REAL NOT NULL CHECK (presupuesto_anual >= 0)
);

-- CARGOS

CREATE TABLE cargos (
    id_cargo INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    salario_base REAL NOT NULL CHECK (salario_base > 0)
);

-- EMPLEADOS

CREATE TABLE empleados (
    id_empleado INTEGER PRIMARY KEY,
    id_departamento INTEGER NOT NULL,
    id_cargo INTEGER NOT NULL,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    fecha_ingreso TEXT NOT NULL CHECK (date(fecha_ingreso) IS NOT NULL),
    estado TEXT NOT NULL DEFAULT 'ACTIVO'
        CHECK (estado IN ('ACTIVO', 'INACTIVO')),
    FOREIGN KEY (id_departamento)
        REFERENCES departamentos(id_departamento),
    FOREIGN KEY (id_cargo)
        REFERENCES cargos(id_cargo)
);

-- CONTRATOS

CREATE TABLE contratos (
    id_contrato INTEGER PRIMARY KEY,
    id_empleado INTEGER NOT NULL,
    fecha_inicio TEXT NOT NULL
        CHECK (date(fecha_inicio) IS NOT NULL),
    fecha_fin TEXT
        CHECK (fecha_fin IS NULL OR date(fecha_fin) IS NOT NULL),
    tipo_contrato TEXT NOT NULL
        CHECK (tipo_contrato IN ('INDEFINIDO', 'FIJO', 'PRACTICAS')),
    salario REAL NOT NULL CHECK (salario > 0),
    FOREIGN KEY (id_empleado)
        REFERENCES empleados(id_empleado),
    CHECK (
        fecha_fin IS NULL
        OR date(fecha_fin) >= date(fecha_inicio)
    )
);