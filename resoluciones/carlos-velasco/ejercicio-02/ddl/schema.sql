PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    CHECK (length(nombre) >= 3)
);

CREATE TABLE productos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    categoria_id INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    precio REAL NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    fecha_ingreso TEXT NOT NULL,
    sku TEXT NOT NULL UNIQUE,
    FOREIGN KEY (categoria_id)
        REFERENCES categorias(id),
    CHECK (precio > 0),
    CHECK (stock >= 0)
);

CREATE TABLE clientes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    fecha_registro TEXT NOT NULL,
    CHECK (length(nombre_completo) >= 5),
    CHECK (length(correo) >= 5)
);

CREATE TABLE ventas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    producto_id INTEGER NOT NULL,
    cliente_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    fecha_venta TEXT NOT NULL,
    total REAL NOT NULL,
    FOREIGN KEY (producto_id)
        REFERENCES productos(id),
    FOREIGN KEY (cliente_id)
        REFERENCES clientes(id),
    CHECK (cantidad > 0),
    CHECK (total > 0)
);