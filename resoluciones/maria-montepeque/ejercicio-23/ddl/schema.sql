PRAGMA foreign_keys = ON;

-- Ejercicio 23: Facturacion Simple
-- Modelo: clientes, productos, facturas, detalle_factura

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    nit         TEXT NOT NULL UNIQUE,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre            TEXT NOT NULL UNIQUE,
    precio_unitario   REAL NOT NULL CHECK (precio_unitario > 0)
);

CREATE TABLE facturas (
    id_factura  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente  INTEGER NOT NULL,
    fecha       TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    subtotal    REAL NOT NULL CHECK (subtotal >= 0),
    impuesto    REAL NOT NULL CHECK (impuesto >= 0),
    total       REAL NOT NULL CHECK (total >= 0),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE detalle_factura (
    id_detalle        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_factura        INTEGER NOT NULL,
    id_producto       INTEGER NOT NULL,
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario   REAL NOT NULL CHECK (precio_unitario > 0),

    FOREIGN KEY (id_factura) REFERENCES facturas (id_factura),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
