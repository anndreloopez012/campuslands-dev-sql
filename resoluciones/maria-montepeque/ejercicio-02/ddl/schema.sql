PRAGMA foreign_keys = ON;

-- Ejercicio 02: Campus Shop
-- Modelo: categorias, productos, clientes, ventas

CREATE TABLE categorias (
    id_categoria    INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre          TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_categoria    INTEGER NOT NULL,
    nombre          TEXT NOT NULL,
    precio          REAL NOT NULL CHECK (precio > 0),
    stock           INTEGER NOT NULL CHECK (stock >= 0),

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre          TEXT NOT NULL,
    correo          TEXT NOT NULL UNIQUE,
    telefono        TEXT
);

CREATE TABLE ventas (
    id_venta          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente        INTEGER NOT NULL,
    id_producto       INTEGER NOT NULL,
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario   REAL NOT NULL CHECK (precio_unitario > 0),
    fecha_venta       TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
