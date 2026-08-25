PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS detalle_factura;
DROP TABLE IF EXISTS facturas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    nit TEXT NOT NULL UNIQUE,
    correo TEXT NOT NULL UNIQUE,
    direccion TEXT NOT NULL
);

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    precio REAL NOT NULL CHECK (precio > 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),
    categoria TEXT NOT NULL
);

CREATE TABLE facturas (
    id_factura INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    numero TEXT NOT NULL UNIQUE,
    fecha TEXT NOT NULL CHECK (date(fecha) IS NOT NULL),
    impuesto REAL NOT NULL CHECK (impuesto >= 0),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalle_factura (
    id_detalle INTEGER PRIMARY KEY,
    id_factura INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario REAL NOT NULL CHECK (precio_unitario > 0),
    FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    UNIQUE (id_factura, id_producto)
);

CREATE INDEX idx_facturas_cliente
ON facturas(id_cliente);

CREATE INDEX idx_detalle_factura
ON detalle_factura(id_factura);

CREATE INDEX idx_detalle_producto
ON detalle_factura(id_producto);