PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ordenes_servicio;
DROP TABLE IF EXISTS motos;
DROP TABLE IF EXISTS servicios;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    telefono TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE motos (
    id_moto INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    placa TEXT NOT NULL UNIQUE,
    marca TEXT NOT NULL,
    modelo TEXT NOT NULL,
    anio INTEGER NOT NULL CHECK (anio >= 2000),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE servicios (
    id_servicio INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    precio_base REAL NOT NULL CHECK (precio_base > 0)
);

CREATE TABLE ordenes_servicio (
    id_orden INTEGER PRIMARY KEY,
    id_moto INTEGER NOT NULL,
    id_servicio INTEGER NOT NULL,
    fecha TEXT NOT NULL CHECK (
        fecha GLOB '____-__-__' OR fecha GLOB '____-__-__ __:__:__'
    ),
    kilometraje INTEGER NOT NULL CHECK (kilometraje >= 0),
    costo REAL NOT NULL CHECK (costo > 0),
    estado TEXT NOT NULL CHECK (
        estado IN ('recibida', 'en_proceso', 'finalizada', 'cancelada')
    ),
    FOREIGN KEY (id_moto) REFERENCES motos(id_moto),
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);

CREATE INDEX idx_motos_cliente
ON motos(id_cliente);

CREATE INDEX idx_ordenes_moto
ON ordenes_servicio(id_moto);

CREATE INDEX idx_ordenes_servicio
ON ordenes_servicio(id_servicio);

CREATE INDEX idx_ordenes_fecha
ON ordenes_servicio(fecha);