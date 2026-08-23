PRAGMA foreign_keys = ON;

-- Ejercicio 004: Tienda Sneakers
-- Modelo minimo: catalogo de productos (modelo+talla) y registro de pedidos.

-- productos: catalogo. Cada combinacion modelo+talla es un producto
-- distinto, con su propio stock; UNIQUE evita cargarla dos veces.
CREATE TABLE productos (
    id_producto   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_modelo TEXT NOT NULL,
    talla         INTEGER NOT NULL CHECK (talla BETWEEN 20 AND 46),
    precio        REAL NOT NULL CHECK (precio > 0),
    stock         INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),

    UNIQUE (nombre_modelo, talla)
);

-- pedidos: tabla principal (transaccional). Aqui vive el reporte semanal
-- que pide el cliente.
CREATE TABLE pedidos (
    id_pedido      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto    INTEGER NOT NULL,
    nombre_cliente TEXT NOT NULL,
    cantidad       INTEGER NOT NULL CHECK (cantidad > 0),
    precio_total   REAL NOT NULL CHECK (precio_total > 0),
    fecha_pedido   TEXT NOT NULL DEFAULT (datetime('now')),
    estado         TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'enviado', 'entregado', 'cancelado')),

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
