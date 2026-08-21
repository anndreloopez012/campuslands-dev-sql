PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS membresias;
DROP TABLE IF EXISTS planes;
DROP TABLE IF EXISTS clientes;

-- CLIENTES

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL,
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (fecha_registro GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
);

-- PLANES

CREATE TABLE planes (
    id_plan INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    duracion_meses INTEGER NOT NULL,
    precio REAL NOT NULL,
    descripcion TEXT,
    CHECK (duracion_meses BETWEEN 1 AND 36),
    CHECK (precio > 0)
);

-- MEMBRESIAS

CREATE TABLE membresias (
    id_membresia INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_plan INTEGER NOT NULL,
    fecha_inicio TEXT NOT NULL,
    fecha_fin TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activa',
    CHECK (fecha_inicio GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    CHECK (fecha_fin GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    CHECK (fecha_fin >= fecha_inicio),
    CHECK (estado IN ('Activa', 'Vencida', 'Cancelada', 'Suspendida')),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_plan) REFERENCES planes(id_plan),
    UNIQUE (id_cliente, fecha_inicio)
);

-- PAGOS

CREATE TABLE pagos (
    id_pago INTEGER PRIMARY KEY,
    id_membresia INTEGER NOT NULL,
    fecha_pago TEXT NOT NULL,
    monto REAL NOT NULL,
    metodo_pago TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Completado',
    CHECK (fecha_pago GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    CHECK (monto > 0),
    CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia')),
    CHECK (estado IN ('Completado', 'Pendiente', 'Anulado')),
    FOREIGN KEY (id_membresia) REFERENCES membresias(id_membresia)
);

CREATE INDEX idx_membresias_cliente
ON membresias(id_cliente);

CREATE INDEX idx_membresias_estado
ON membresias(estado);

CREATE INDEX idx_pagos_membresia
ON pagos(id_membresia);

CREATE INDEX idx_pagos_fecha
ON pagos(fecha_pago);