PRAGMA foreign_keys = ON;

-- Ejercicio 051: Cafeteria Campus
-- Modelo clasico de encabezado + detalle: clientes -> ventas (1:N),
-- y ventas + productos -> detalle_ventas (doble FOREIGN KEY).

CREATE TABLE productos (
    id_producto     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto TEXT NOT NULL UNIQUE,
    categoria       TEXT NOT NULL CHECK (categoria IN ('bebida', 'snack', 'panaderia', 'comida')),
    precio          REAL NOT NULL CHECK (precio > 0)
);

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    carnet         TEXT NOT NULL UNIQUE
);

CREATE TABLE ventas (
    id_venta     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente   INTEGER NOT NULL,
    fecha_venta  TEXT NOT NULL,
    estado       TEXT NOT NULL DEFAULT 'pagada' CHECK (estado IN ('pagada', 'pendiente_pago', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- detalle_ventas: precio_unitario se copia del producto al momento
-- de la venta (ver supuestos), no se recalcula despues.
CREATE TABLE detalle_ventas (
    id_detalle       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_venta         INTEGER NOT NULL,
    id_producto      INTEGER NOT NULL,
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario  REAL NOT NULL CHECK (precio_unitario > 0),

    FOREIGN KEY (id_venta) REFERENCES ventas (id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
