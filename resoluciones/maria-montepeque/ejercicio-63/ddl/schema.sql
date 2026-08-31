PRAGMA foreign_keys = ON;

-- Ejercicio 63: AUTO_INCREMENT Nivel Intermedio
-- Tema central: AUTO_INCREMENT
-- Contexto: ventas diarias de una cafeteria (clientes, productos, ventas).

-- clientes: id_cliente generado solo con AUTOINCREMENT.
CREATE TABLE clientes (
    id_cliente   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    telefono     TEXT NOT NULL UNIQUE
);

-- productos: id_producto generado solo con AUTOINCREMENT.
CREATE TABLE productos (
    id_producto   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL UNIQUE,
    precio        REAL NOT NULL CHECK (precio > 0)
);

-- ventas: id_venta generado solo con AUTOINCREMENT; relaciona clientes
-- y productos.
CREATE TABLE ventas (
    id_venta       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente     INTEGER NOT NULL,
    id_producto    INTEGER NOT NULL,
    cantidad       INTEGER NOT NULL DEFAULT 1 CHECK (cantidad > 0),
    fecha_venta    TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
