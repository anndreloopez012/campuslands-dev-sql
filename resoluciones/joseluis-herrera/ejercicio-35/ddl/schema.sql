PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS movimientos;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS bodegas;
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
    id_categoria INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE proveedores (
    id_proveedor INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    telefono TEXT NOT NULL UNIQUE,
    email TEXT,
    estado TEXT NOT NULL DEFAULT 'activo',
    CHECK (length(telefono) >= 8),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE bodegas (
    id_bodega INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    ubicacion TEXT NOT NULL,
    capacidad INTEGER NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activa',
    CHECK (capacidad > 0),
    CHECK (estado IN ('activa', 'inactiva'))
);

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    id_categoria INTEGER NOT NULL,
    id_proveedor INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,
    stock_minimo INTEGER NOT NULL DEFAULT 0,
    estado TEXT NOT NULL DEFAULT 'activo',
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    CHECK (precio_unitario > 0),
    CHECK (stock_minimo >= 0),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE movimientos (
    id_movimiento INTEGER PRIMARY KEY,
    id_producto INTEGER NOT NULL,
    id_bodega INTEGER NOT NULL,
    tipo_movimiento TEXT NOT NULL,
    cantidad INTEGER NOT NULL,
    fecha_movimiento TEXT NOT NULL,
    observacion TEXT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_bodega) REFERENCES bodegas(id_bodega),
    CHECK (tipo_movimiento IN ('entrada', 'salida')),
    CHECK (cantidad > 0)
);

CREATE INDEX idx_productos_categoria
ON productos(id_categoria);

CREATE INDEX idx_productos_proveedor
ON productos(id_proveedor);

CREATE INDEX idx_movimientos_producto
ON movimientos(id_producto);

CREATE INDEX idx_movimientos_bodega
ON movimientos(id_bodega);

CREATE INDEX idx_movimientos_fecha
ON movimientos(fecha_movimiento);