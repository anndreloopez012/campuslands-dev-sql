PRAGMA foreign_keys = ON;

-- Ejercicio 02: Campus Shop SQLite
-- Autor: Brandon Estiben Ixen
-- Fecha: 2026-08-22

CREATE TABLE IF NOT EXISTS categorias (
    id_categoria       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_categoria   TEXT    NOT NULL UNIQUE,
    descripcion        TEXT
);

CREATE TABLE IF NOT EXISTS productos (
    id_producto       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto   TEXT    NOT NULL UNIQUE,
    id_categoria      INTEGER NOT NULL,
    cantidad_stock    INTEGER NOT NULL DEFAULT 0 CHECK (cantidad_stock >= 0),
    precio            REAL    NOT NULL CHECK (precio > 0),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE IF NOT EXISTS clientes (
    id_cliente       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente   TEXT    NOT NULL,
    telefono         TEXT    NOT NULL UNIQUE,
    direccion        TEXT,
    email            TEXT
);

CREATE TABLE IF NOT EXISTS ventas (
    id_venta     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente   INTEGER NOT NULL,
    id_producto  INTEGER NOT NULL,
    cantidad     INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_venta  TEXT    NOT NULL DEFAULT (date('now')),
    FOREIGN KEY (id_cliente)  REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
