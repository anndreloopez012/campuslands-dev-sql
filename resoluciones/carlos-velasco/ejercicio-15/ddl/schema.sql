PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ordenes_servicio;
DROP TABLE IF EXISTS motos;
DROP TABLE IF EXISTS servicios;
DROP TABLE IF EXISTS clientes;

-- CLIENTES

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    telefono TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL
        CHECK (date(fecha_registro) IS NOT NULL)
);

-- MOTOS

CREATE TABLE motos (
    id_moto INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    placa TEXT NOT NULL UNIQUE,
    marca TEXT NOT NULL,
    modelo TEXT NOT NULL,
    anio INTEGER NOT NULL
        CHECK (anio BETWEEN 1990 AND 2030),
    kilometraje INTEGER NOT NULL DEFAULT 0
        CHECK (kilometraje >= 0),
    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- SERVICIOS

CREATE TABLE servicios (
    id_servicio INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    precio_base REAL NOT NULL
        CHECK (precio_base > 0),
    duracion_minutos INTEGER NOT NULL
        CHECK (duracion_minutos > 0)
);

-- ORDENES DE SERVICIO

CREATE TABLE ordenes_servicio (
    id_orden INTEGER PRIMARY KEY,
    id_moto INTEGER NOT NULL,
    id_servicio INTEGER NOT NULL,
    fecha_servicio TEXT NOT NULL
        CHECK (datetime(fecha_servicio) IS NOT NULL),
    kilometraje INTEGER NOT NULL
        CHECK (kilometraje >= 0),
    estado TEXT NOT NULL DEFAULT 'Pendiente'
        CHECK (estado IN ('Pendiente', 'En proceso', 'Completado', 'Cancelado')),
    precio_final REAL NOT NULL
        CHECK (precio_final >= 0),
    observaciones TEXT,
    FOREIGN KEY (id_moto)
        REFERENCES motos(id_moto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_servicio)
        REFERENCES servicios(id_servicio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX idx_motos_cliente
    ON motos(id_cliente);

CREATE INDEX idx_ordenes_moto
    ON ordenes_servicio(id_moto);

CREATE INDEX idx_ordenes_servicio
    ON ordenes_servicio(id_servicio);

CREATE INDEX idx_ordenes_fecha
    ON ordenes_servicio(fecha_servicio);