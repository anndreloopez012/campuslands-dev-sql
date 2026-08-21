PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS detalle_pedido;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS platos;
DROP TABLE IF EXISTS mesas;

CREATE TABLE mesas (
    id_mesa INTEGER PRIMARY KEY,
    numero INTEGER NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL,
    ubicacion TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'LIBRE',

    CONSTRAINT chk_mesa_capacidad
        CHECK (capacidad BETWEEN 1 AND 20),

    CONSTRAINT chk_mesa_estado
        CHECK (estado IN ('LIBRE', 'OCUPADA', 'RESERVADA'))
);

CREATE TABLE platos (
    id_plato INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    categoria TEXT NOT NULL,
    precio REAL NOT NULL,
    disponible INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT chk_plato_precio
        CHECK (precio > 0),

    CONSTRAINT chk_plato_disponible
        CHECK (disponible IN (0, 1))
);

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_mesa INTEGER NOT NULL,
    fecha_pedido TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'ABIERTO',

    FOREIGN KEY (id_mesa)
        REFERENCES mesas(id_mesa),

    CONSTRAINT chk_pedido_estado
        CHECK (estado IN ('ABIERTO', 'PAGADO', 'CANCELADO')),

    CONSTRAINT chk_pedido_fecha
        CHECK (
            fecha_pedido GLOB
            '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] *'
        )
);

CREATE TABLE detalle_pedido (
    id_detalle INTEGER PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_plato INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,

    FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido),

    FOREIGN KEY (id_plato)
        REFERENCES platos(id_plato),

    CONSTRAINT chk_detalle_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_detalle_precio
        CHECK (precio_unitario > 0),

    CONSTRAINT uq_detalle_pedido_plato
        UNIQUE (id_pedido, id_plato)
);