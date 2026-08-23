PRAGMA foreign_keys = ON;

-- Ejercicio 26: Normalizacion Tienda
-- Modelo: clientes, categorias, productos, compras
-- Normalizado hasta 3FN: cada tabla depende solo de su llave primaria,
-- sin datos repetidos entre clientes, categorias y productos.

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE categorias (
    id_categoria  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_categoria   INTEGER NOT NULL,
    nombre         TEXT NOT NULL,
    precio         REAL NOT NULL CHECK (precio > 0),

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

CREATE TABLE compras (
    id_compra    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente   INTEGER NOT NULL,
    id_producto  INTEGER NOT NULL,
    cantidad     INTEGER NOT NULL CHECK (cantidad > 0),
    fecha        TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
