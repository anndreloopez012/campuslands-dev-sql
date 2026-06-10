PRAGMA foreign_keys = ON;

-- Ejercicio 31: Normalizacion Ventas Campus

-- 1. SUCURSALES 
CREATE TABLE sucursales (
    id_sucursal INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE
);

-- 2. VENDEDORES 
CREATE TABLE vendedores (
    id_vendedor INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    id_sucursal INTEGER NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES sucursales (id_sucursal)
);

-- 3. CLIENTES 
CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE CHECK (email LIKE '%_@_%._%')
);

-- 4. PRODUCTOS
CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    precio REAL NOT NULL CHECK (precio > 0)
);

-- 5. VENTAS
CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_vendedor INTEGER NOT NULL,
    fecha TEXT NOT NULL DEFAULT (date('now')),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores (id_vendedor)
);

-- 6. DETALLE_VENTA 
CREATE TABLE detalle_venta (
    id_detalle INTEGER PRIMARY KEY,
    id_venta INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario REAL NOT NULL CHECK (precio_unitario > 0),
    FOREIGN KEY (id_venta) REFERENCES ventas (id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
    UNIQUE (id_venta, id_producto)
);