PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS detalle_pedido;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS platos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS meseros;
DROP TABLE IF EXISTS mesas;

CREATE TABLE mesas (
    id_mesa INTEGER PRIMARY KEY,
    numero_mesa INTEGER NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL,
    estado TEXT NOT NULL DEFAULT 'disponible',
    CHECK (capacidad > 0),
    CHECK (estado IN ('disponible', 'ocupada', 'mantenimiento'))
);

CREATE TABLE meseros (
    id_mesero INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL UNIQUE,
    turno TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo',
    CHECK (turno IN ('manana', 'tarde', 'noche')),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE categorias (
    id_categoria INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE
);

CREATE TABLE platos (
    id_plato INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    id_categoria INTEGER NOT NULL,
    precio REAL NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo',
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    CHECK (precio > 0),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_mesa INTEGER NOT NULL,
    id_mesero INTEGER NOT NULL,
    fecha_pedido TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'abierto',
    FOREIGN KEY (id_mesa) REFERENCES mesas(id_mesa),
    FOREIGN KEY (id_mesero) REFERENCES meseros(id_mesero),
    CHECK (estado IN ('abierto', 'pagado', 'cancelado'))
);

CREATE TABLE detalle_pedido (
    id_pedido INTEGER NOT NULL,
    id_plato INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,
    PRIMARY KEY (id_pedido, id_plato),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_plato) REFERENCES platos(id_plato),
    CHECK (cantidad > 0),
    CHECK (precio_unitario > 0)
);

CREATE INDEX idx_pedidos_fecha
ON pedidos(fecha_pedido);

CREATE INDEX idx_pedidos_mesa
ON pedidos(id_mesa);

CREATE INDEX idx_pedidos_mesero
ON pedidos(id_mesero);

CREATE INDEX idx_platos_categoria
ON platos(id_categoria);

CREATE INDEX idx_detalle_plato
ON detalle_pedido(id_plato);