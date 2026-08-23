PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS repartidores;
DROP TABLE IF EXISTS restaurantes;
DROP TABLE IF EXISTS clientes;

-- CLIENTES

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    direccion TEXT NOT NULL
);

-- RESTAURANTES

CREATE TABLE restaurantes (
    id_restaurante INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    telefono TEXT NOT NULL UNIQUE,
    categoria TEXT NOT NULL,
    calificacion REAL NOT NULL CHECK (calificacion BETWEEN 1 AND 5)
);

-- REPARTIDORES

CREATE TABLE repartidores (
    id_repartidor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    telefono TEXT NOT NULL UNIQUE,
    vehiculo TEXT NOT NULL CHECK (vehiculo IN ('MOTO', 'BICICLETA', 'AUTOMOVIL')),
    disponible INTEGER NOT NULL DEFAULT 1 CHECK (disponible IN (0, 1))
);

-- PEDIDOS

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_restaurante INTEGER NOT NULL,
    id_repartidor INTEGER NOT NULL,
    fecha_pedido TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'PENDIENTE'
        CHECK (estado IN ('PENDIENTE', 'PREPARANDO', 'EN_CAMINO', 'ENTREGADO', 'CANCELADO')),
    total REAL NOT NULL CHECK (total > 0),
    tiempo_estimado_min INTEGER NOT NULL CHECK (tiempo_estimado_min > 0),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_restaurante) REFERENCES restaurantes(id_restaurante)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_repartidor) REFERENCES repartidores(id_repartidor)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX idx_pedidos_cliente
ON pedidos(id_cliente);

CREATE INDEX idx_pedidos_restaurante
ON pedidos(id_restaurante);

CREATE INDEX idx_pedidos_repartidor
ON pedidos(id_repartidor);

CREATE INDEX idx_pedidos_estado
ON pedidos(estado);