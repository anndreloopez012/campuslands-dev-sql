PRAGMA foreign_keys = ON;

-- Ejercicio 026: Cafeteria Campus
-- Modelo: dos catalogos independientes (clientes, productos) que
-- alimentan una tabla de movimientos (ventas) con dos FOREIGN KEY.

CREATE TABLE clientes (
    id_cliente        INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente    TEXT NOT NULL UNIQUE,
    carne_estudiantil TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto TEXT NOT NULL UNIQUE,
    categoria       TEXT NOT NULL CHECK (categoria IN ('bebida', 'comida', 'snack')),
    precio          REAL NOT NULL CHECK (precio > 0)
);

-- ventas: tabla principal (movimiento). Conecta productos y clientes,
-- los dos catalogos permanentes, sin mezclarse con ellos.
CREATE TABLE ventas (
    id_venta     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto  INTEGER NOT NULL,
    id_cliente   INTEGER NOT NULL,
    cantidad     INTEGER NOT NULL CHECK (cantidad > 0),
    monto_total  REAL NOT NULL CHECK (monto_total > 0),
    fecha_venta  TEXT NOT NULL DEFAULT (datetime('now')),
    estado       TEXT NOT NULL DEFAULT 'pagada' CHECK (estado IN ('pagada', 'pendiente', 'cancelada')),

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);
