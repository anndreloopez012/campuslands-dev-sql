PRAGMA foreign_keys = ON;

-- Ejercicio 001: Cafeteria Campus
-- Modelo minimo: catalogo de productos y registro de ventas.

-- productos: catalogo. nombre_producto es UNIQUE para evitar que la misma
-- persona lo cargue dos veces con nombres identicos (el problema de
-- duplicados que menciona el cliente).
CREATE TABLE productos (
    id_producto     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto TEXT NOT NULL UNIQUE,
    precio          REAL NOT NULL CHECK (precio > 0),
    categoria       TEXT NOT NULL CHECK (categoria IN ('bebida', 'comida', 'snack')),
    stock           INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

-- ventas: tabla principal (transaccional). Cada fila es una venta rapida
-- a un estudiante. estado permite corregir el pago sin borrar el
-- historial (pagada / pendiente / cancelada).
CREATE TABLE ventas (
    id_venta       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto    INTEGER NOT NULL,
    nombre_cliente TEXT NOT NULL,
    cantidad       INTEGER NOT NULL CHECK (cantidad > 0),
    precio_pagado  REAL NOT NULL CHECK (precio_pagado > 0),
    fecha_venta    TEXT NOT NULL DEFAULT (datetime('now')),
    estado         TEXT NOT NULL DEFAULT 'pagada' CHECK (estado IN ('pagada', 'pendiente', 'cancelada')),

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
