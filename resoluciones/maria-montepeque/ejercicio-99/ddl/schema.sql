PRAGMA foreign_keys = ON;

-- Ejercicio 99: Vistas Nivel Intermedio
-- Tema central: Vistas
-- Contexto: ventas diarias de una cafeteria.

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente  TEXT NOT NULL,
    email           TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto   TEXT NOT NULL UNIQUE,
    precio_unitario   REAL NOT NULL CHECK (precio_unitario >= 0)
);

CREATE TABLE ventas (
    id_venta       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente     INTEGER NOT NULL,
    id_producto    INTEGER NOT NULL,
    cantidad       INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_venta    TEXT NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

-- Vista: encapsula el JOIN de las 3 tablas y calcula el total de cada
-- linea de venta, para no repetir esa logica en cada reporte que la
-- necesite.
CREATE VIEW vista_detalle_ventas AS
SELECT v.id_venta,
       cl.nombre_cliente,
       p.nombre_producto,
       v.cantidad,
       p.precio_unitario,
       v.cantidad * p.precio_unitario AS total_linea,
       v.fecha_venta
FROM ventas v
JOIN clientes cl ON cl.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto;
