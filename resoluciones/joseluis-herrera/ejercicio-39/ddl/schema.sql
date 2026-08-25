PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS asignaciones_beneficios;
DROP TABLE IF EXISTS beneficios;
DROP TABLE IF EXISTS contratos;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS cargos;
DROP TABLE IF EXISTS departamentos;

CREATE TABLE departamentos (
    id_departamento INTEGER PRIMARY KEY,
    nombre_departamento TEXT NOT NULL UNIQUE,
    ubicacion TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activo',
    CHECK (estado IN ('Activo', 'Inactivo'))
);

CREATE TABLE cargos (
    id_cargo INTEGER PRIMARY KEY,
    nombre_cargo TEXT NOT NULL UNIQUE,
    salario_base REAL NOT NULL,
    CHECK (salario_base >= 0)
);

CREATE TABLE empleados (
    id_empleado INTEGER PRIMARY KEY,
    documento TEXT NOT NULL UNIQUE,
    nombre_completo TEXT NOT NULL,
    id_cargo INTEGER NOT NULL,
    id_departamento INTEGER NOT NULL,
    id_jefe INTEGER,
    estado TEXT NOT NULL DEFAULT 'Activo',
    FOREIGN KEY (id_cargo) REFERENCES cargos(id_cargo),
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento),
    FOREIGN KEY (id_jefe) REFERENCES empleados(id_empleado),
    CHECK (estado IN ('Activo', 'Inactivo', 'Vacaciones')),
    CHECK (id_jefe IS NULL OR id_jefe <> id_empleado)
);

CREATE TABLE contratos (
    id_contrato INTEGER PRIMARY KEY,
    id_empleado INTEGER NOT NULL,
    fecha_contrato TEXT NOT NULL,
    salario REAL NOT NULL,
    tipo_contrato TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activo',
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    CHECK (salario > 0),
    CHECK (tipo_contrato IN ('Indefinido', 'Temporal', 'Prestacion de servicios')),
    CHECK (estado IN ('Activo', 'Finalizado', 'Suspendido'))
);

CREATE TABLE beneficios (
    id_beneficio INTEGER PRIMARY KEY,
    nombre_beneficio TEXT NOT NULL UNIQUE,
    valor_mensual REAL NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activo',
    CHECK (valor_mensual >= 0),
    CHECK (estado IN ('Activo', 'Inactivo'))
);

CREATE TABLE asignaciones_beneficios (
    id_empleado INTEGER NOT NULL,
    id_beneficio INTEGER NOT NULL,
    fecha_asignacion TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activo',
    PRIMARY KEY (id_empleado, id_beneficio),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_beneficio) REFERENCES beneficios(id_beneficio),
    CHECK (estado IN ('Activo', 'Inactivo'))
);

CREATE INDEX idx_empleados_departamento
ON empleados(id_departamento);

CREATE INDEX idx_empleados_cargo
ON empleados(id_cargo);

CREATE INDEX idx_empleados_jefe
ON empleados(id_jefe);

CREATE INDEX idx_contratos_empleado
ON contratos(id_empleado);

CREATE INDEX idx_beneficios_empleado
ON asignaciones_beneficios(id_empleado);