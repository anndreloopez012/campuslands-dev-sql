PRAGMA foreign_keys = ON;

-- Ejercicio 55: NOT NULL Nivel Aplicado
-- Tema central: NOT NULL
-- Contexto: inventario de dispositivos tecnologicos en bodega
-- (categorias, productos y movimientos de entrada/salida).

CREATE TABLE categorias (
    id_categoria     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_categoria TEXT NOT NULL,   -- obligatorio: una categoria no existe sin nombre
    descripcion      TEXT             -- OPCIONAL: detalle adicional, no siempre se redacta
);

CREATE TABLE productos (
    id_producto  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_categoria INTEGER NOT NULL,    -- obligatorio: todo producto se clasifica en una categoria
    sku          TEXT NOT NULL UNIQUE,-- obligatorio: el codigo de bodega identifica el producto
    nombre_producto TEXT NOT NULL,    -- obligatorio: no se puede dar de alta un producto sin nombre
    descripcion  TEXT,                -- OPCIONAL: ficha tecnica ampliada, no siempre se completa

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

-- movimientos: tabla principal. Distingue lo obligatorio (lo necesario para
-- que el movimiento de bodega sea valido y trazable) de lo opcional
-- (observaciones, que solo se anotan en casos particulares).
CREATE TABLE movimientos (
    id_movimiento    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto      INTEGER NOT NULL,  -- obligatorio: todo movimiento pertenece a un producto
    tipo_movimiento  TEXT NOT NULL CHECK (tipo_movimiento IN ('entrada', 'salida')),
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0), -- obligatorio: sin cantidad no hay movimiento que registrar
    fecha_movimiento TEXT NOT NULL,    -- obligatorio: sin fecha no se puede auditar el inventario
    observaciones    TEXT,             -- OPCIONAL: solo se anota en casos que lo ameritan (ej. devolucion, dano)

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
