PRAGMA foreign_keys = ON;

-- Ejercicio 22: Pedidos Delivery
-- Modelo: clientes, restaurantes, repartidores, pedidos

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    telefono    TEXT NOT NULL UNIQUE,
    direccion   TEXT NOT NULL
);

CREATE TABLE restaurantes (
    id_restaurante  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre          TEXT NOT NULL UNIQUE,
    categoria       TEXT NOT NULL
);

CREATE TABLE repartidores (
    id_repartidor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL,
    telefono       TEXT NOT NULL UNIQUE,
    vehiculo       TEXT NOT NULL CHECK (vehiculo IN ('moto', 'bicicleta', 'carro'))
);

CREATE TABLE pedidos (
    id_pedido       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente      INTEGER NOT NULL,
    id_restaurante  INTEGER NOT NULL,
    id_repartidor   INTEGER NOT NULL,
    total           REAL NOT NULL CHECK (total > 0),
    estado          TEXT NOT NULL CHECK (estado IN ('pendiente', 'en_camino', 'entregado', 'cancelado')),
    fecha           TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_restaurante) REFERENCES restaurantes (id_restaurante),
    FOREIGN KEY (id_repartidor) REFERENCES repartidores (id_repartidor)
);
