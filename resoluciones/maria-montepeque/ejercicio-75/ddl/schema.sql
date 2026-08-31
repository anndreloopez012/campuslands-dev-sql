PRAGMA foreign_keys = ON;

-- Ejercicio 75: UPDATE Nivel Intermedio
-- Tema central: UPDATE
-- Contexto: inventario de dispositivos tecnologicos en bodega.

CREATE TABLE categorias (
    id_categoria     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_categoria TEXT NOT NULL UNIQUE
);

-- productos: aqui si se guarda stock_actual como columna (a
-- diferencia de un modelo basado solo en historial), justo para
-- poder practicar UPDATE sobre ella.
CREATE TABLE productos (
    id_producto      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto  TEXT NOT NULL UNIQUE,
    id_categoria     INTEGER NOT NULL,
    precio_unitario  REAL NOT NULL CHECK (precio_unitario >= 0),
    stock_actual     INTEGER NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

-- movimientos: historial de entradas y salidas de bodega, como
-- respaldo. El stock_actual de productos se corrige con UPDATE cada
-- vez que se registra un movimiento nuevo.
CREATE TABLE movimientos (
    id_movimiento    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto      INTEGER NOT NULL,
    tipo_movimiento  TEXT NOT NULL DEFAULT 'entrada'
                         CHECK (tipo_movimiento IN ('entrada', 'salida')),
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_movimiento TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
