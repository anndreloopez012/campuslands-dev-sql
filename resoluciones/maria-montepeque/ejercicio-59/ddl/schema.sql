PRAGMA foreign_keys = ON;

-- Ejercicio 59: DEFAULT Nivel Basico
-- Tema central: DEFAULT
-- Contexto: inventario de dispositivos tecnologicos en bodega.

CREATE TABLE categorias (
    id_categoria     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_categoria TEXT NOT NULL
);

-- productos: tabla principal. Reune los cuatro tipos de DEFAULT que pide
-- el objetivo del ejercicio: estado, fecha, cantidad y bandera.
CREATE TABLE productos (
    id_producto     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_categoria    INTEGER NOT NULL,
    sku             TEXT NOT NULL UNIQUE,
    nombre_producto TEXT NOT NULL,

    -- DEFAULT para estado: si no se indica, un producto nuevo entra como
    -- 'disponible'.
    estado          TEXT NOT NULL DEFAULT 'disponible' CHECK (estado IN ('disponible', 'agotado', 'descontinuado')),

    -- DEFAULT para cantidad: si no se indica stock inicial, se asume 0
    -- (todavia no ha llegado mercancia).
    stock           INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),

    -- DEFAULT para bandera: si no se indica, se asume que el producto NO
    -- es fragil (0 = falso, 1 = verdadero).
    es_fragil       INTEGER NOT NULL DEFAULT 0 CHECK (es_fragil IN (0, 1)),

    -- DEFAULT para fecha: si no se indica, se usa la fecha/hora actual del
    -- momento en que se registra el producto.
    fecha_registro  TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);
