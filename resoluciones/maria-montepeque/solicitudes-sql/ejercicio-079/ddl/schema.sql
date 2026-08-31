PRAGMA foreign_keys = ON;

-- Ejercicio 079: Tienda Sneakers
-- Modelo: clientes -> pedidos (1:N); pedidos + productos + tallas ->
-- detalle_pedidos (1:N cada una).

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente  TEXT NOT NULL,
    telefono        TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto  TEXT NOT NULL,
    marca            TEXT NOT NULL
);

CREATE TABLE tallas (
    id_talla       INTEGER PRIMARY KEY AUTOINCREMENT,
    numero_talla   TEXT NOT NULL UNIQUE
);

-- pedidos: el estado se corrige siempre con UPDATE. Una vez
-- 'confirmado', el pedido ya es parte del historico de auditoria que
-- pidio el cliente.
CREATE TABLE pedidos (
    id_pedido      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente     INTEGER NOT NULL,
    fecha_pedido   TEXT NOT NULL DEFAULT (datetime('now')),
    estado         TEXT NOT NULL DEFAULT 'pendiente'
                       CHECK (estado IN ('pendiente', 'confirmado', 'enviado', 'entregado', 'cancelado')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- detalle_pedidos: el UNIQUE compuesto impide que el mismo producto
-- en la misma talla quede registrado dos veces como linea separada
-- en el mismo pedido.
CREATE TABLE detalle_pedidos (
    id_detalle        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido         INTEGER NOT NULL,
    id_producto       INTEGER NOT NULL,
    id_talla          INTEGER NOT NULL,
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario   REAL NOT NULL CHECK (precio_unitario >= 0),

    FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
    FOREIGN KEY (id_talla) REFERENCES tallas (id_talla),
    UNIQUE (id_pedido, id_producto, id_talla)
);
