PRAGMA foreign_keys = ON;

-- Ejercicio 93: HAVING Nivel Intermedio
-- Tema central: HAVING
-- Contexto: inventario de dispositivos tecnologicos en bodega.

CREATE TABLE categorias (
    id_categoria      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_categoria  TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_categoria      INTEGER NOT NULL,
    nombre_producto   TEXT NOT NULL,
    precio_unitario   REAL NOT NULL CHECK (precio_unitario >= 0),

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

CREATE TABLE movimientos (
    id_movimiento      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto        INTEGER NOT NULL,
    tipo_movimiento    TEXT NOT NULL DEFAULT 'entrada'
                            CHECK (tipo_movimiento IN ('entrada', 'salida')),
    cantidad           INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_movimiento   TEXT NOT NULL,

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
