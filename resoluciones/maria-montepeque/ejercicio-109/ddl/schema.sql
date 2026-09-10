PRAGMA foreign_keys = ON;

-- Ejercicio 109: Indices Nivel Aplicado
-- Tema central: Indices
-- Contexto: inventario de dispositivos tecnologicos en bodega.

CREATE TABLE categorias (
    id_categoria      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_categoria  TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_categoria      INTEGER NOT NULL,
    nombre_producto   TEXT NOT NULL UNIQUE,
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

-- =====================================================================
-- Caso de negocio: la bodega necesita, con frecuencia, un reporte de
-- SALIDAS recientes por producto (para decidir reabastecimiento);
-- las entradas se consultan mucho menos seguido. En vez de un indice
-- normal sobre toda la tabla "movimientos" (que gastaria espacio
-- indexando tambien las entradas, que casi no se consultan asi), se
-- usa un INDICE PARCIAL: solo incluye las filas de salida.
-- =====================================================================
CREATE INDEX idx_movimientos_salida
ON movimientos (id_producto, fecha_movimiento)
WHERE tipo_movimiento = 'salida';
