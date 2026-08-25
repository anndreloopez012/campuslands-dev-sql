PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ordenes;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS compradores;
DROP TABLE IF EXISTS vendedores;

CREATE TABLE vendedores (
    id_vendedor INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL
);

CREATE TABLE compradores (
    id_comprador INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    ciudad TEXT NOT NULL
);

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    id_vendedor INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    sku TEXT NOT NULL UNIQUE,
    precio REAL NOT NULL CHECK (precio > 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

CREATE TABLE ordenes (
    id_orden INTEGER PRIMARY KEY,
    id_comprador INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    fecha TEXT NOT NULL CHECK (
        fecha GLOB '____-__-__' OR fecha GLOB '____-__-__ __:__:__'
    ),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario REAL NOT NULL CHECK (precio_unitario > 0),
    estado TEXT NOT NULL CHECK (
        estado IN ('pendiente', 'pagada', 'enviada', 'entregada', 'cancelada')
    ),
    FOREIGN KEY (id_comprador) REFERENCES compradores(id_comprador),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE INDEX idx_productos_vendedor
ON productos(id_vendedor);

CREATE INDEX idx_ordenes_comprador
ON ordenes(id_comprador);

CREATE INDEX idx_ordenes_producto
ON ordenes(id_producto);

CREATE INDEX idx_ordenes_fecha
ON ordenes(fecha);