PRAGMA foreign_keys = ON;

-- Ejercicio 83: WHERE Nivel Basico
-- Tema central: WHERE
-- Contexto: ventas diarias de una cafeteria.

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente  TEXT NOT NULL,
    telefono        TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto  TEXT NOT NULL UNIQUE,
    precio           REAL NOT NULL CHECK (precio >= 0),
    categoria        TEXT NOT NULL CHECK (categoria IN ('bebida', 'comida'))
);

CREATE TABLE ventas (
    id_venta      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    id_producto   INTEGER NOT NULL,
    cantidad      INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_venta   TEXT NOT NULL DEFAULT (date('now')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
