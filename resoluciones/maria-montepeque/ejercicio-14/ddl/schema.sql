PRAGMA foreign_keys = ON;

-- Ejercicio 14: Marketplace Campus
-- Modelo: vendedores, productos, compradores, ordenes

CREATE TABLE vendedores (
    id_vendedor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    correo       TEXT NOT NULL UNIQUE,
    telefono     TEXT NOT NULL
);

CREATE TABLE productos (
    id_producto  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vendedor  INTEGER NOT NULL,
    nombre       TEXT NOT NULL,
    precio       REAL NOT NULL CHECK (precio > 0),
    stock        INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),

    FOREIGN KEY (id_vendedor) REFERENCES vendedores (id_vendedor)
);

CREATE TABLE compradores (
    id_comprador  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL,
    correo        TEXT NOT NULL UNIQUE
);

CREATE TABLE ordenes (
    id_orden      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_comprador  INTEGER NOT NULL,
    id_producto   INTEGER NOT NULL,
    cantidad      INTEGER NOT NULL CHECK (cantidad > 0),
    fecha         TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    estado        TEXT NOT NULL CHECK (estado IN ('pendiente', 'pagada', 'enviada', 'cancelada')),

    FOREIGN KEY (id_comprador) REFERENCES compradores (id_comprador),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
