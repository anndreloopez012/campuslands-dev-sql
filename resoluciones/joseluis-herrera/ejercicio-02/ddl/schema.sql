PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-- CATEGORIAS

CREATE TABLE categorias (
    id_categoria INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT
);

-- PRODUCTOS

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    id_categoria INTEGER NOT NULL,
    nombre TEXT NOT NULL UNIQUE,
    precio REAL NOT NULL CHECK (precio > 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    fecha_ingreso TEXT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE INDEX idx_productos_categoria
ON productos(id_categoria);

-- CLIENTES

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    telefono TEXT,
    fecha_registro TEXT NOT NULL
);

-- VENTAS

CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario REAL NOT NULL CHECK (precio_unitario > 0),
    fecha_venta TEXT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE INDEX idx_ventas_cliente
ON ventas(id_cliente);

CREATE INDEX idx_ventas_producto
ON ventas(id_producto);

CREATE INDEX idx_ventas_fecha
ON ventas(fecha_venta); 