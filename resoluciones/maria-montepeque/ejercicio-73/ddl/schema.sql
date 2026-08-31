PRAGMA foreign_keys = ON;

-- Ejercicio 73: INSERT Nivel Aplicado
-- Tema central: INSERT
-- Contexto: inventario de dispositivos tecnologicos en bodega.

CREATE TABLE categorias (
    id_categoria     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_categoria TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto  TEXT NOT NULL UNIQUE,
    id_categoria     INTEGER NOT NULL,
    precio_unitario  REAL NOT NULL CHECK (precio_unitario >= 0),

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

-- movimientos: el stock de cada producto no se guarda como columna
-- aparte, se calcula a partir de este historial de entradas y
-- salidas (ver consulta 5 en dql/consultas.sql, el caso de negocio
-- con reporte final propio del nivel aplicado).
CREATE TABLE movimientos (
    id_movimiento    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto      INTEGER NOT NULL,
    tipo_movimiento  TEXT NOT NULL DEFAULT 'entrada'
                         CHECK (tipo_movimiento IN ('entrada', 'salida')),
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_movimiento TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
