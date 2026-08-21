PRAGMA foreign_keys = ON;

-- Ejercicio 32: Normalizacion Pedidos Restaurante
-- Modelo normalizado (3FN): mesas, meseros, platos, pedidos, detalle_pedido

CREATE TABLE mesas (
    id_mesa  INTEGER PRIMARY KEY AUTOINCREMENT,
    numero   TEXT NOT NULL UNIQUE
);

CREATE TABLE meseros (
    id_mesero  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre     TEXT NOT NULL UNIQUE
);

CREATE TABLE platos (
    id_plato    INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE,
    categoria   TEXT NOT NULL CHECK (categoria IN ('Comida', 'Bebida', 'Postre', 'Acompanamiento')),
    precio      REAL NOT NULL CHECK (precio > 0)
);

CREATE TABLE pedidos (
    id_pedido      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_mesa        INTEGER NOT NULL,
    id_mesero      INTEGER NOT NULL,
    fecha_pedido   TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_mesa) REFERENCES mesas (id_mesa),
    FOREIGN KEY (id_mesero) REFERENCES meseros (id_mesero)
);

CREATE TABLE detalle_pedido (
    id_detalle        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido         INTEGER NOT NULL,
    id_plato          INTEGER NOT NULL,
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario   REAL NOT NULL CHECK (precio_unitario > 0),

    FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido),
    FOREIGN KEY (id_plato) REFERENCES platos (id_plato)
);
