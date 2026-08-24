PRAGMA foreign_keys = ON;

-- Ejercicio 061: Delivery de Comida
-- Modelo: clientes, menus, repartidores, pedidos, pagos

CREATE TABLE clientes (
    id_cliente   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    telefono     TEXT NOT NULL UNIQUE,
    direccion    TEXT NOT NULL
);

CREATE TABLE menus (
    id_menu           INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_platillo   TEXT NOT NULL,
    restaurante       TEXT NOT NULL,
    precio            REAL NOT NULL CHECK (precio > 0),
    disponible        INTEGER NOT NULL DEFAULT 1 CHECK (disponible IN (0, 1))
);

CREATE TABLE repartidores (
    id_repartidor          INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre                 TEXT NOT NULL,
    placa_vehiculo         TEXT NOT NULL UNIQUE,
    calificacion_promedio  REAL NOT NULL DEFAULT 5.0
                               CHECK (calificacion_promedio BETWEEN 0 AND 5)
);

CREATE TABLE pedidos (
    id_pedido        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente       INTEGER NOT NULL,
    id_menu          INTEGER NOT NULL,
    -- Regla de negocio: puede no haber repartidor asignado todavia
    -- (pedido recien creado, aun 'pendiente').
    id_repartidor    INTEGER,
    cantidad         INTEGER NOT NULL DEFAULT 1 CHECK (cantidad > 0),
    fecha_pedido     TEXT NOT NULL DEFAULT (datetime('now')),
    estado           TEXT NOT NULL DEFAULT 'pendiente'
                         CHECK (estado IN ('pendiente', 'en_camino', 'entregado', 'cancelado')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_menu) REFERENCES menus (id_menu),
    FOREIGN KEY (id_repartidor) REFERENCES repartidores (id_repartidor)
);

CREATE TABLE pagos (
    id_pago         INTEGER PRIMARY KEY AUTOINCREMENT,
    -- UNIQUE: cada pedido tiene como maximo un pago (relacion 1:1).
    id_pedido       INTEGER NOT NULL UNIQUE,
    monto           REAL NOT NULL CHECK (monto > 0),
    metodo_pago     TEXT NOT NULL CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'app')),
    fecha_pago      TEXT NOT NULL DEFAULT (datetime('now')),
    estado_pago     TEXT NOT NULL DEFAULT 'pendiente'
                        CHECK (estado_pago IN ('pendiente', 'pagado', 'reembolsado')),

    FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido)
);
