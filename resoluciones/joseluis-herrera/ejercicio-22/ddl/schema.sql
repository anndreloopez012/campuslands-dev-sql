PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS repartidores;
DROP TABLE IF EXISTS restaurantes;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    direccion TEXT NOT NULL
);

CREATE TABLE restaurantes (
    id_restaurante INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    categoria TEXT NOT NULL,
    direccion TEXT NOT NULL,
    calificacion REAL NOT NULL CHECK (calificacion BETWEEN 1 AND 5)
);

CREATE TABLE repartidores (
    id_repartidor INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    placa TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    estado TEXT NOT NULL CHECK (estado IN ('DISPONIBLE','OCUPADO'))
);

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_restaurante INTEGER NOT NULL,
    id_repartidor INTEGER NOT NULL,
    fecha_pedido TEXT NOT NULL CHECK (datetime(fecha_pedido) IS NOT NULL),
    total REAL NOT NULL CHECK (total > 0),
    estado TEXT NOT NULL CHECK (
        estado IN ('PENDIENTE','PREPARANDO','EN_CAMINO','ENTREGADO','CANCELADO')
    ),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_restaurante) REFERENCES restaurantes(id_restaurante),
    FOREIGN KEY (id_repartidor) REFERENCES repartidores(id_repartidor)
);

CREATE INDEX idx_pedidos_cliente ON pedidos(id_cliente);
CREATE INDEX idx_pedidos_restaurante ON pedidos(id_restaurante);
CREATE INDEX idx_pedidos_repartidor ON pedidos(id_repartidor);
CREATE INDEX idx_pedidos_estado ON pedidos(estado);