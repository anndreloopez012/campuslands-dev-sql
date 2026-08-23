PRAGMA foreign_keys = ON;

-- Ejercicio 054: Tienda Sneakers
-- Modelo: productos -> tallas (1:N, stock por talla), y clientes +
-- tallas -> pedidos (doble FOREIGN KEY). 4 tablas en total.

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    telefono       TEXT NOT NULL
);

CREATE TABLE productos (
    id_producto     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto TEXT NOT NULL UNIQUE,
    marca           TEXT NOT NULL CHECK (marca IN ('Nike', 'Adidas', 'Puma', 'New Balance', 'Vans')),
    precio          REAL NOT NULL CHECK (precio > 0)
);

-- Un mismo producto no puede repetir la misma talla dos veces
-- (UNIQUE compuesto).
CREATE TABLE tallas (
    id_talla      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto   INTEGER NOT NULL,
    numero_talla  INTEGER NOT NULL CHECK (numero_talla BETWEEN 20 AND 33),
    stock         INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
    UNIQUE (id_producto, numero_talla)
);

-- pedidos: stock_descontado marca si este pedido especifico ya le
-- resto stock a su talla, para decidir con seguridad si se puede
-- borrar (ver dml/operaciones.sql).
CREATE TABLE pedidos (
    id_pedido          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente         INTEGER NOT NULL,
    id_talla           INTEGER NOT NULL,
    fecha_pedido       TEXT NOT NULL,
    cantidad           INTEGER NOT NULL CHECK (cantidad > 0),
    estado             TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'confirmado', 'enviado', 'cancelado')),
    stock_descontado   INTEGER NOT NULL DEFAULT 0 CHECK (stock_descontado IN (0, 1)),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_talla) REFERENCES tallas (id_talla)
);
