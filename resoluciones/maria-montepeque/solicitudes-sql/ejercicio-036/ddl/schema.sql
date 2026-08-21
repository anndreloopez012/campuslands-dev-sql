PRAGMA foreign_keys = ON;

-- Ejercicio 036: Delivery de Comida
-- Modelo: dos catalogos independientes (clientes, menus) que
-- alimentan una tabla de movimientos (pedidos) con dos FOREIGN KEY.

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    telefono       TEXT NOT NULL
);

CREATE TABLE menus (
    id_menu         INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_platillo TEXT NOT NULL UNIQUE,
    categoria       TEXT NOT NULL CHECK (categoria IN ('entrada', 'plato_fuerte', 'postre', 'bebida')),
    precio          REAL NOT NULL CHECK (precio > 0)
);

-- pedidos: tabla principal. NOT NULL en los campos que, si faltaran,
-- romperian la trazabilidad del pedido (la queja central del cliente
-- sobre no mezclar catalogos con movimientos).
CREATE TABLE pedidos (
    id_pedido     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    id_menu       INTEGER NOT NULL,
    repartidor    TEXT NOT NULL,
    fecha_pedido  TEXT NOT NULL,
    monto_pagado  REAL NOT NULL CHECK (monto_pagado > 0),
    estado        TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'en_camino', 'entregado', 'cancelado')),
    calificacion  INTEGER CHECK (calificacion IS NULL OR (calificacion BETWEEN 1 AND 5)),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_menu) REFERENCES menus (id_menu)
);
