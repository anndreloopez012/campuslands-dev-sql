PRAGMA foreign_keys = ON;

-- Ejercicio 011: Delivery de Comida
-- Modelo minimo: catalogo de menu y registro de pedidos.

CREATE TABLE menus (
    id_menu         INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_platillo TEXT NOT NULL UNIQUE,
    categoria       TEXT NOT NULL CHECK (categoria IN ('entrada', 'plato_fuerte', 'postre', 'bebida')),
    precio          REAL NOT NULL CHECK (precio > 0)
);

-- pedidos: tabla principal. calificacion se deja sin NOT NULL a proposito:
-- solo tiene sentido cuando el pedido ya se entrego.
CREATE TABLE pedidos (
    id_pedido      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_menu        INTEGER NOT NULL,
    nombre_cliente TEXT NOT NULL,
    repartidor     TEXT NOT NULL,
    cantidad       INTEGER NOT NULL CHECK (cantidad > 0),
    monto_total    REAL NOT NULL CHECK (monto_total > 0),
    fecha_pedido   TEXT NOT NULL DEFAULT (datetime('now')),
    estado         TEXT NOT NULL DEFAULT 'recibido' CHECK (estado IN ('recibido', 'en_camino', 'entregado', 'cancelado')),
    calificacion   INTEGER CHECK (calificacion BETWEEN 1 AND 5),

    FOREIGN KEY (id_menu) REFERENCES menus (id_menu)
);
