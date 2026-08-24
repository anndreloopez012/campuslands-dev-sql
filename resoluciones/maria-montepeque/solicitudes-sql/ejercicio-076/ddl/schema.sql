PRAGMA foreign_keys = ON;

-- Ejercicio 076: Cafeteria Campus
-- Modelo separado en catalogos (productos, clientes), operacion
-- (ventas, detalle_ventas) y resultado (pagos), tal como pidio el
-- cliente.

CREATE TABLE productos (
    id_producto      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto  TEXT NOT NULL UNIQUE,
    precio           REAL NOT NULL CHECK (precio >= 0),
    categoria        TEXT NOT NULL CHECK (categoria IN ('bebida', 'comida', 'snack'))
);

CREATE TABLE clientes (
    id_cliente          INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente      TEXT NOT NULL,
    carnet_estudiante   TEXT NOT NULL UNIQUE
);

CREATE TABLE ventas (
    id_venta      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    fecha_venta   TEXT NOT NULL DEFAULT (datetime('now')),
    estado        TEXT NOT NULL DEFAULT 'abierta'
                      CHECK (estado IN ('abierta', 'cerrada', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- detalle_ventas: el UNIQUE compuesto impide que un producto quede
-- registrado dos veces como linea separada en la misma venta.
CREATE TABLE detalle_ventas (
    id_detalle        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_venta          INTEGER NOT NULL,
    id_producto       INTEGER NOT NULL,
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario   REAL NOT NULL CHECK (precio_unitario >= 0),

    FOREIGN KEY (id_venta) REFERENCES ventas (id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
    UNIQUE (id_venta, id_producto)
);

-- pagos: el UNIQUE sobre id_venta garantiza como maximo un pago
-- oficial por venta (relacion 1:1).
CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_venta      INTEGER NOT NULL UNIQUE,
    monto         REAL NOT NULL CHECK (monto >= 0),
    metodo_pago   TEXT NOT NULL CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'transferencia')),
    fecha_pago    TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_venta) REFERENCES ventas (id_venta)
);
