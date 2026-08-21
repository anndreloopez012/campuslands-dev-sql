PRAGMA foreign_keys = ON;

-- Ejercicio 57: CHECK Nivel Intermedio
-- Tema central: CHECK
-- Contexto: inventario de dispositivos tecnologicos en bodega
-- (categorias, productos y movimientos de entrada/salida).

-- tipo_categoria: CHECK de valores permitidos (lista cerrada de dominios).
CREATE TABLE categorias (
    id_categoria     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_categoria TEXT NOT NULL,
    tipo_categoria   TEXT NOT NULL CHECK (tipo_categoria IN ('hardware', 'software', 'accesorio'))
);

-- precio_unitario y stock_minimo: CHECK de rango numerico (no tiene sentido
-- de negocio un precio en cero/negativo ni un stock minimo negativo).
CREATE TABLE productos (
    id_producto     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_categoria    INTEGER NOT NULL,
    sku             TEXT NOT NULL UNIQUE,
    nombre_producto TEXT NOT NULL,
    precio_unitario REAL NOT NULL CHECK (precio_unitario > 0),
    stock_minimo    INTEGER NOT NULL DEFAULT 0 CHECK (stock_minimo >= 0),

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

-- movimientos: tabla principal. tipo_movimiento usa CHECK de valores
-- permitidos y cantidad usa CHECK de rango numerico (una entrada o salida
-- de 0 o negativa no representa un movimiento real).
CREATE TABLE movimientos (
    id_movimiento    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto      INTEGER NOT NULL,
    tipo_movimiento  TEXT NOT NULL CHECK (tipo_movimiento IN ('entrada', 'salida')),
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_movimiento TEXT NOT NULL,

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
