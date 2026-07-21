PRAGMA foreign_keys = ON;

-- Ejercicio 02: Campus Shop
-- Cree aqui las tablas necesarias para el modelo.
-- Debe incluir PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

-- Ejemplo de estructura esperada:
-- CREATE TABLE nombre_tabla (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL UNIQUE,
--   estado TEXT NOT NULL CHECK (estado IN ('activo', 'inactivo'))
-- );
CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto TEXT NOT NULL,
    precio NUMBER NOT NULL
);

CREATE TABLE categoria (
    id_categoria INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_categoria TEXT NOT NULL UNIQUE
);

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    telefono TEXT NOT NULL,
    email TEXT UNIQUE,
    dpi TEXT UNIQUE NOT NULL
);

ALTER TABLE ventas ADD COLUMN cantidad INTEGER NOT NULL DEFAULT 1; (
    id_ventas INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto INTEGER,
    id_categoria INTEGER,
    fecha TEXT NOT NULL,
    precio_total FLOAT NOT NULL CHECK (precio_total > 0),

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
    FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
);
