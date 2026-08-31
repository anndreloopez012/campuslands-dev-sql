PRAGMA foreign_keys = ON;

-- Ejercicio 77: DELETE Nivel Basico
-- Tema central: DELETE
-- Contexto: inventario de dispositivos tecnologicos en bodega.

CREATE TABLE categorias (
    id_categoria     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_categoria TEXT NOT NULL UNIQUE
);

-- productos: "activo" es la bandera de baja logica. Un producto
-- descontinuado no se borra (movimientos todavia lo referencia por
-- FOREIGN KEY), se marca como inactivo.
CREATE TABLE productos (
    id_producto      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto  TEXT NOT NULL UNIQUE,
    id_categoria     INTEGER NOT NULL,
    precio_unitario  REAL NOT NULL CHECK (precio_unitario >= 0),
    activo           INTEGER NOT NULL DEFAULT 1 CHECK (activo IN (0, 1)),

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

-- movimientos: historial de entradas y salidas. A diferencia de
-- productos, un movimiento sin dependientes si puede eliminarse de
-- verdad cuando es un error de captura (ver dml/inserts.sql).
CREATE TABLE movimientos (
    id_movimiento    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto      INTEGER NOT NULL,
    tipo_movimiento  TEXT NOT NULL DEFAULT 'entrada'
                         CHECK (tipo_movimiento IN ('entrada', 'salida')),
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_movimiento TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
