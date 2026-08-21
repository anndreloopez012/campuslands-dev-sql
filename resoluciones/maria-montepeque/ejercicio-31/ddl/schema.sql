PRAGMA foreign_keys = ON;

-- Ejercicio 31: Normalizacion Ventas Campus
-- Modelo normalizado (3FN): clientes, productos, vendedores, ventas, detalle_venta

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    email       TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre            TEXT NOT NULL UNIQUE,
    precio_unitario   REAL NOT NULL CHECK (precio_unitario > 0)
);

CREATE TABLE vendedores (
    id_vendedor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    sucursal     TEXT NOT NULL
);

CREATE TABLE ventas (
    id_venta      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    id_vendedor   INTEGER NOT NULL,
    fecha         TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores (id_vendedor)
);

CREATE TABLE detalle_venta (
    id_detalle        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_venta          INTEGER NOT NULL,
    id_producto       INTEGER NOT NULL,
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario   REAL NOT NULL CHECK (precio_unitario > 0),

    FOREIGN KEY (id_venta) REFERENCES ventas (id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
