PRAGMA foreign_keys = ON;
-- Ejercicio 32: Normalizacion Pedidos Restaurante

DROP TABLE IF EXISTS detalle_pedido;

DROP TABLE IF EXISTS pedido;

DROP TABLE IF EXISTS plato;

DROP TABLE IF EXISTS categoria;

DROP TABLE IF EXISTS mesa;

DROP TABLE IF EXISTS mesero;

CREATE TABLE mesero (
    id_mesero INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    UNIQUE (nombre)
);

CREATE TABLE mesa (
    id_mesa INTEGER PRIMARY KEY,
    numero INTEGER NOT NULL,
    UNIQUE (numero),
    CHECK (numero > 0)
);

CREATE TABLE categoria (
    id_categoria INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    UNIQUE (nombre)
);

CREATE TABLE plato (
    id_plato INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    precio REAL NOT NULL,
    id_categoria INTEGER NOT NULL,
    UNIQUE (nombre),
    CHECK (precio >= 0),
    FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
);

CREATE TABLE pedido (
    id_pedido INTEGER PRIMARY KEY,
    id_mesa INTEGER NOT NULL,
    id_mesero INTEGER NOT NULL,
    fecha_pedido TEXT NOT NULL,
    CHECK (
        date(fecha_pedido) IS NOT NULL
    ),
    FOREIGN KEY (id_mesa) REFERENCES mesa (id_mesa),
    FOREIGN KEY (id_mesero) REFERENCES mesero (id_mesero)
);

CREATE TABLE detalle_pedido (
    id_pedido INTEGER NOT NULL,
    id_plato INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    PRIMARY KEY (id_pedido, id_plato),
    CHECK (cantidad > 0),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
    FOREIGN KEY (id_plato) REFERENCES plato (id_plato)
);