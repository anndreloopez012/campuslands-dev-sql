PRAGMA foreign_keys = ON;

-- Ejercicio 95: JOIN Nivel Basico
-- Tema central: JOIN
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
