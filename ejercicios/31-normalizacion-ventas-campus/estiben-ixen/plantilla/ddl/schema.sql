PRAGMA foreign_keys = ON;

-- Ejercicio 31: Normalizacion Ventas Campus
-- Cree aqui el modelo normalizado final.
-- Debe representar el resultado de 3FN.

CREATE TABLE cliente (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    cliente_email TEXT NOT NULL UNIQUE
);

CREATE TABLE producto (
    id_producto INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto TEXT NOT NULL UNIQUE,
    precio REAL NOT NULL CHECK (precio > 0)
    cantdad INTEGER NOT NULL CHECK (cantidad >= 0),
);

CREATE TABLE vendedor (
    id_vendedor INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_vendedor TEXT NOT NULL UNIQUE,
    sucursal TEXT NOT NULL
);

CREATE TABLE venta (
    id_venta INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    id_vendedor INTEGER NOT NULL,
    fecha_venta TEXT NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
  
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);

-- Requisitos:
-- PRIMARY KEY
-- FOREIGN KEY
-- NOT NULL
-- UNIQUE
-- CHECK
