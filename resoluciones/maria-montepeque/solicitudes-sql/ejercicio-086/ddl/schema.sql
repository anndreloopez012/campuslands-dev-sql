PRAGMA foreign_keys = ON;

-- Ejercicio 086: Delivery de Comida
-- Modelo separado en catalogos (clientes, menus, repartidores),
-- operacion (pedidos) y resultado (pagos), tal como pidio el
-- cliente.

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente  TEXT NOT NULL,
    telefono        TEXT NOT NULL UNIQUE
);

CREATE TABLE menus (
    id_menu           INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_platillo   TEXT NOT NULL UNIQUE,
    precio            REAL NOT NULL CHECK (precio >= 0),
    categoria         TEXT NOT NULL CHECK (categoria IN ('comida', 'bebida', 'postre'))
);

CREATE TABLE repartidores (
    id_repartidor      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_repartidor  TEXT NOT NULL UNIQUE,
    vehiculo           TEXT NOT NULL
);

CREATE TABLE pedidos (
    id_pedido        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente       INTEGER NOT NULL,
    id_menu          INTEGER NOT NULL,
    id_repartidor    INTEGER NOT NULL,
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_pedido     TEXT NOT NULL DEFAULT (datetime('now')),
    estado           TEXT NOT NULL DEFAULT 'recibido'
                         CHECK (estado IN ('recibido', 'en_camino', 'entregado', 'cancelado')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_menu) REFERENCES menus (id_menu),
    FOREIGN KEY (id_repartidor) REFERENCES repartidores (id_repartidor)
);

-- pagos: el UNIQUE sobre id_pedido garantiza como maximo un pago
-- oficial por pedido.
CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido     INTEGER NOT NULL UNIQUE,
    monto         REAL NOT NULL CHECK (monto >= 0),
    metodo_pago   TEXT NOT NULL CHECK (metodo_pago IN ('efectivo', 'tarjeta')),
    fecha_pago    TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido)
);

-- Vista SQL (requerida en nivel 5): separa visualmente catalogos
-- (cliente, menu, repartidor), operacion (pedido) y resultado (pago)
-- en un solo reporte, con LEFT JOIN para que un pedido sin pago
-- todavia siga siendo visible.
CREATE VIEW vista_pedidos_completos AS
    SELECT
        pe.id_pedido,
        cl.nombre_cliente,
        me.nombre_platillo,
        me.categoria,
        re.nombre_repartidor,
        pe.cantidad,
        pe.fecha_pedido,
        pe.estado,
        pa.monto AS monto_pagado
    FROM pedidos pe
    JOIN clientes cl ON cl.id_cliente = pe.id_cliente
    JOIN menus me ON me.id_menu = pe.id_menu
    JOIN repartidores re ON re.id_repartidor = pe.id_repartidor
    LEFT JOIN pagos pa ON pa.id_pedido = pe.id_pedido;
