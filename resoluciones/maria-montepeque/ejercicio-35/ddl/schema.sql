PRAGMA foreign_keys = ON;

-- Ejercicio 35: Normalizacion Inventario Proveedores
-- Modelo normalizado (3FN): categorias, proveedores, productos, bodegas, movimientos

CREATE TABLE categorias (
    id_categoria  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL UNIQUE
);

CREATE TABLE proveedores (
    id_proveedor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL UNIQUE,
    telefono      TEXT NOT NULL UNIQUE
);

CREATE TABLE bodegas (
    id_bodega  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre     TEXT NOT NULL UNIQUE
);

-- Catalogo de productos: categoria y proveedor son atributos fijos del
-- producto (cada producto pertenece siempre a la misma categoria y lo surte
-- el mismo proveedor), no de cada movimiento.
CREATE TABLE productos (
    id_producto    INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL UNIQUE,
    id_categoria   INTEGER NOT NULL,
    id_proveedor   INTEGER NOT NULL,

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedor)
);

-- Detalle transaccional: cada entrada o salida de un producto en una bodega
-- es un movimiento independiente (el CSV original comprimia entradas y
-- salidas de un mismo producto en dos columnas de una sola fila).
CREATE TABLE movimientos (
    id_movimiento     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto       INTEGER NOT NULL,
    id_bodega         INTEGER NOT NULL,
    tipo_movimiento   TEXT NOT NULL CHECK (tipo_movimiento IN ('entrada', 'salida')),
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_movimiento  TEXT NOT NULL CHECK (fecha_movimiento GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),  -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
    FOREIGN KEY (id_bodega) REFERENCES bodegas (id_bodega)
);
