PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ordenes;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS compradores;
DROP TABLE IF EXISTS vendedores;

-- VENDEDORES

CREATE TABLE vendedores (
    id_vendedor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    ciudad TEXT NOT NULL,
    fecha_registro TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activo',
    CHECK (length(trim(nombre_completo)) >= 3),
    CHECK (estado IN ('Activo', 'Inactivo')),
    CHECK (
        fecha_registro GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
    )
);

-- PRODUCTOS

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    id_vendedor INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    categoria TEXT NOT NULL,
    precio REAL NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    estado TEXT NOT NULL DEFAULT 'Disponible',
    CHECK (precio > 0),
    CHECK (stock >= 0),
    CHECK (estado IN ('Disponible', 'Agotado', 'Inactivo')),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

-- COMPRADORES

CREATE TABLE compradores (
    id_comprador INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    ciudad TEXT NOT NULL,
    fecha_registro TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activo',
    CHECK (length(trim(nombre_completo)) >= 3),
    CHECK (estado IN ('Activo', 'Inactivo')),
    CHECK (
        fecha_registro GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
    )
);

-- ORDENES

CREATE TABLE ordenes (
    id_orden INTEGER PRIMARY KEY,
    id_vendedor INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    id_comprador INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,
    fecha_orden TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Pendiente',
    CHECK (cantidad > 0),
    CHECK (precio_unitario > 0),
    CHECK (estado IN ('Pendiente', 'Pagada', 'Enviada', 'Entregada', 'Cancelada')),
    CHECK (
        fecha_orden GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'
    ),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_comprador) REFERENCES compradores(id_comprador)
);

CREATE INDEX idx_productos_vendedor
ON productos(id_vendedor);

CREATE INDEX idx_ordenes_vendedor
ON ordenes(id_vendedor);

CREATE INDEX idx_ordenes_producto
ON ordenes(id_producto);

CREATE INDEX idx_ordenes_comprador
ON ordenes(id_comprador);

CREATE INDEX idx_ordenes_fecha
ON ordenes(fecha_orden);