PRAGMA foreign_keys = ON;

-- Ejercicio 31: Normalizacion Ventas Campus
-- Cree aqui el modelo normalizado final.
-- Debe representar el resultado de 3FN.

-- Requisitos:
-- PRIMARY KEY
-- FOREIGN KEY
-- NOT NULL
-- UNIQUE
-- CHECK
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS detalle_venta;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS vendedores;
DROP TABLE IF EXISTS sucursales;
DROP TABLE IF EXISTS clientes;

-- CLIENTES

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    CHECK (length(trim(nombre_completo)) >= 3),
    CHECK (instr(email, '@') > 1)
);

-- PRODUCTOS

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre_producto TEXT NOT NULL UNIQUE,
    categoria TEXT NOT NULL,
    precio REAL NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    CHECK (precio > 0),
    CHECK (stock >= 0)
);

-- VENDEDORES

CREATE TABLE vendedores (
    id_vendedor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    CHECK (length(trim(nombre_completo)) >= 3)
);

-- SUCURSALES

CREATE TABLE sucursales (
    id_sucursal INTEGER PRIMARY KEY,
    nombre_sucursal TEXT NOT NULL UNIQUE,
    direccion TEXT NOT NULL,
    telefono TEXT NOT NULL
);

-- VENTAS

CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_vendedor INTEGER NOT NULL,
    id_sucursal INTEGER NOT NULL,
    fecha_venta TEXT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal),
    CHECK (date(fecha_venta) IS NOT NULL)
);

-- DETALLE_VENTA

CREATE TABLE detalle_venta (
    id_venta INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,
    PRIMARY KEY (id_venta, id_producto),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    CHECK (cantidad > 0),
    CHECK (precio_unitario > 0)
);

-- INDICES

CREATE INDEX idx_clientes_nombre
ON clientes(nombre_completo);

CREATE INDEX idx_productos_categoria
ON productos(categoria);

CREATE INDEX idx_ventas_fecha
ON ventas(fecha_venta);

CREATE INDEX idx_ventas_cliente
ON ventas(id_cliente);

CREATE INDEX idx_ventas_vendedor
ON ventas(id_vendedor);

CREATE INDEX idx_ventas_sucursal
ON ventas(id_sucursal);

CREATE INDEX idx_detalle_producto
ON detalle_venta(id_producto);